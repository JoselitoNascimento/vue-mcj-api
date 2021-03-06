const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Entidade':
exports.createVisita = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: 'Erros ocorridos ao validar campo ' + errors[0].param + ': ' + errors[0].msg});
  }
  try {
    const { crm_lead_id, data, entidade_id, situacao, dt_inc, us_inc } = req.body;
    await db.query('BEGIN');
    const newVisita = await db.query(
      "INSERT INTO crm_historico (crm_lead_id, data, entidade_id, situacao, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id",
      [crm_lead_id, data, entidade_id, situacao, dt_inc, us_inc]
    );
    const newID = newVisita.rows[0].id;
    // Dados dos serviços
    const { servicos } = req.body;
    if (servicos) {
      for (let index = 0; index < servicos.length; index++) {
        console.log(JSON.stringify(servicos));
        const { servico_id } = servicos[index];
        await db.query(
          "INSERT INTO crm_servicos (crm_historico_id, servico_id, situacao, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5)",
          [newID, servico_id, situacao, dt_inc, us_inc]
        );
      }
    }  
    // Dados dos comentários
    const { posts } = req.body;
    if (posts.length > 0) {
      for (let index = 0; index < posts.length; index++) {
        console.log(JSON.stringify(posts));
        const { data, post } = posts[index];
        await db.query(
          "INSERT INTO crm_posts (crm_historico_id, data, post, situacao, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6)",
          [newID, data, post, situacao, dt_inc, us_inc]
        );
      }  
    }
    await db.query('COMMIT')

    return res.status(201).send({
      message: "Histórico de visita adicionada com sucesso!",
      body: { id : newID, crm_lead_id, data, entidade_id, situacao, dt_inc, us_inc },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao inserir histórico de visita: " + err });
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por alterar uma 'Entidade':
exports.updateVisita = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  try {
    const { id, crm_lead_id, data, entidade_id, situacao, dt_alt, us_alt } = req.body;
    await db.query('BEGIN');
    await db.query( 
      "UPDATE crm_historico SET crm_lead_id =$2, data =$3, entidade_id =$4, situacao =$5, dt_alt = $6, us_alt = $7 WHERE id = $1 ",
      [ id, crm_lead_id, data, entidade_id, situacao, dt_alt, us_alt ]
    );
    // Dados do endereço é para todos 
    const { servicos } = req.body;
    if (servicos) {
      await db.query(
        "DELETE FROM crm_servicos WHERE crm_historico_id = $1",
        [id]
      );
      for (let index = 0; index < servicos.length; index++) {
        const { servico_id } = servicos[index];
        await db.query(
          "INSERT INTO crm_servicos (crm_historico_id, servico_id, situacao, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5)",
          [ id, servico_id, situacao, dt_alt, us_alt ]
        );
      }
    }  
    // Dados da OAB apenas para advogados   
    const { posts } = req.body;
    if (posts) {
      await db.query(
        "DELETE FROM crm_posts WHERE crm_historico_id = $1",
        [id]
      );
      for (let index = 0; index < posts.length; index++) {
        const { data, post } = posts[index];
        await db.query(
          "INSERT INTO crm_posts (crm_historico_id, data, post, situacao, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6)",
          [ id, data, post, situacao, dt_alt, us_alt ]
        );
      }  
    }
    await db.query('COMMIT')

    res.status(201).send({
      message: "Histórico de visita alterado com sucesso!",
      body: {
        localizacao: { id, crm_lead_id, data, entidade_id, situacao, dt_alt, us_alt }
      },
    });

  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao alterar histórico de visita: " + err.detail });
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteVisitaById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    await db.query(
      "DELETE FROM crm_historico WHERE id = $1",
      [id]
    );

    res.status(201).send({
      message: "Histórico de visita excluido com sucesso!",
      body: {
        localizacao: { id }
      },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao excluir histórico de visita: " + err.detail });
    return erro;
  }  
};

// ==> Método responsável por listar todas as 'Entidades':
exports.listAllVisitas = async (_, res) => {
  const response = await db.query("SELECT HIST.id,                                                      " +
                                  "       HIST.crm_lead_id,                                             " +
                                  "       LEAD.nome,                                                    " +
                                  "       LEAD.escritorio_id,                                           " +
                                  "       ESCR.nome AS escritorio,                                      " +
                                  "       HIST.data,                                                    " +
                                  "       HIST.entidade_id,                                             " + 
                                  "       ENTI.nome as responsavel,                                     " +
                                  "       HIST.situacao,                                                " + 
                                  "       CASE HIST.situacao                                            " +
                                  "            WHEN 1 THEN 'QUALIFICADO'                                " +
                                  "            WHEN 2 THEN 'EM PROSPECÇÃO'                              " +
                                  "            WHEN 3 THEN 'AGUARDANDO PROPOSTA'                        " +
                                  "            WHEN 4 THEN 'PROPOSTA ENVIADA'                           " +
                                  "            WHEN 5 THEN 'CONTRATO ASSINADO'                          " +
                                  "            WHEN 6 THEN 'RETORNAR'                                   " +
                                  "            WHEN 7 THEN 'SEM INTERESSE' END AS desc_situacao,        " +
                                  "       HIST.dt_inc,                                                  " + 
                                  "       HIST.us_inc,                                                  " +
                                  "       HIST.dt_alt,                                                  " +
                                  "       HIST.us_alt                                                   " + 
                                  "       FROM public.crm_historico HIST                                " +
                                  "       INNER JOIN crm_leads LEAD ON (LEAD.id = HIST.crm_lead_id)     " + 
                                  "       INNER JOIN entidades ENTI ON (ENTI.id = HIST.entidade_id)     " +
                                  "       INNER JOIN escritorios ESCR ON (ESCR.id = LEAD.escritorio_id) " +
                                  "ORDER BY nome ASC                                                    " );
  if (response.rows.length > 0) {
    return res.status(200).send(response.rows);
  } else {
    return res.status(406).send({ message: "não existe histórico de visita"});
  }
};

// ==> Método responsável por listar a Entidade':
exports.listVisita = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query("SELECT HIST.id,                                                   " +
                                  "       HIST.crm_lead_id,                                          " +
                                  "       LEAD.nome,                                                 " +
                                  "       HIST.data,                                                 " +
                                  "       HIST.entidade_id,                                          " + 
                                  "       ENTI.nome as responsavel,                                  " +
                                  "       HIST.situacao,                                             " + 
                                  "       CASE HIST.situacao                                         " +
                                  "            WHEN 1 THEN 'QUALIFICADO'                             " +
                                  "            WHEN 2 THEN 'EM PROSPECÇÃO'                           " +
                                  "            WHEN 3 THEN 'AGUARDANDO PROPOSTA'                     " +
                                  "            WHEN 4 THEN 'PROPOSTA ENVIADA'                        " +
                                  "            WHEN 5 THEN 'CONTRATO ASSINADO'                       " +
                                  "            WHEN 6 THEN 'RETORNAR'                                " +
                                  "            WHEN 7 THEN 'SEM INTERESSE' END AS desc_situacao,     " +
                                  "       HIST.dt_inc,                                               " + 
                                  "       HIST.us_inc,                                               " +
                                  "       HIST.dt_alt,                                               " +
                                  "       HIST.us_alt                                                " + 
                                  "FROM public.crm_historico HIST                                    " +
                                  "INNER JOIN crm_leads LEAD ON (LEAD.id = HIST.crm_lead_id)         " + 
                                  "INNER JOIN entidades ENTI ON (ENTI.id = HIST.entidade_id)         " +
                                  "WHERE HIST.id = $1                                                ", 
                                  [id]
  );

  if (response.rows.length > 0) {
    return res.status(200).send(response.rows);
  } else {  
    return res.status(400).send('Histórico de visita não cadastrado!');
  }

};

// ==> Método responsável por listar os serviços da visita':
exports.listServicosVisita = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }

  const id = parseInt(req.params.id);
  const response = await db.query("SELECT CRMS.id,                                                   " +
                                  "       CRMS.crm_historico_id,                                     " +
                                  "       CRMS.servico_id,                                           " +
                                  "       SERV.descricao	   	                                       " +
                                  "       FROM public.crm_servicos CRMS                              " +
                                  "       INNER JOIN servicos SERV ON (SERV.id = CRMS.servico_id)    " +
                                  "WHERE CRMS.crm_historico_id = $1                                                ", 
                                  [id]
  );

  if (response.rows.length > 0) {
    return res.status(200).send(response.rows);
  } else {  
    return res.status(400).send('Serviços não cadastrados para a visita!');
  }

};

// ==> Método responsável por listar os posts da visita':
exports.listPostsVisita = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }

  const id = parseInt(req.params.id);
  const response = await db.query("SELECT CRMP.id,                                  " +
                                  "       CRMP.crm_historico_id,                    " +
                                  "       to_char(CRMP.data, 'DD-MM-YYYY') as data, " +
                                  "       CRMP.post                                 " +
                                  "FROM crm_posts CRMP                              " +
                                  "WHERE CRMP.crm_historico_id = $1                 ",
                                  [id]
  );

  if (response.rows.length > 0) {
    return res.status(200).send(response.rows);
  } else {  
    return res.status(400).send('Posts não cadastrados para a visita!');
  }

};