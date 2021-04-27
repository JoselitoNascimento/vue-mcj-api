const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Entidade':
exports.createLead = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: 'Erros ocorridos ao validar campo ' + errors[0].param + ': ' + errors[0].msg});
  }
  try {
    const { dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_inc, us_inc } = req.body;

    const leadExists = await db.query('SELECT cnpj_cpf               ' + 
                                      'FROM crm_leads                ' + 
                                      'WHERE cnpj_cpf = $1           ', 
                                      [cnpj_cpf]
                                  );
    if (leadExists.rows.length > 0) {
      return res.status(409).send({
        message: "CNPJ/CPF já cadastrado!",
      });
    }

    await db.query(
      "INSERT INTO crm_leads (dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10,$11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25) RETURNING id",
      [dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_inc, us_inc]
    );

    return res.status(201).send({
      message: "Lead adicionado com sucesso!",
      body: { dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_inc, us_inc },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao inserir lead: " + err });
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por alterar uma 'Entidade':
exports.updateLead = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  try {
    const { id, dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_alt, us_alt } = req.body;
    await db.query(
      "UPDATE crm_leads SET dt_cadastro =$2, escritorio_id =$3, entidade_id =$4, grupo_empresarial_id =$5, cnpj_cpf =$6, nome =$7, fantasia =$8, contato =$9, logradouro =$10, numero =$11, bairro =$12, cidade_ibge =$13, uf =$14, cep =$15, telefone =$16, email =$17, cnae_principal =$18, comentario =$19, situacao =$20, pessoa_tipo =$21, complemento =$22, ativo =$23, dt_alt =$24, us_alt =$25 WHERE id = $1 ",
      [ id, dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_alt, us_alt ]
    );

    res.status(201).send({
      message: "Entidade alterada com sucesso!",
      body: {
        localizacao: { dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, comentario, situacao, pessoa_tipo, complemento, ativo, dt_alt, us_alt }
      },
    });

  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao alterar lead: " + err.detail });
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteLeadById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    await db.query(
      "DELETE FROM crm_leads WHERE id = $1",
      [id]
    );

    res.status(201).send({
      message: "Lead excluido com sucesso!",
      body: {
        localizacao: { id }
      },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao excluir lead: " + err.detail });
    return erro;
  }  
};

// ==> Método responsável por listar todas as 'Entidades':
exports.listAllLead = async (_, res) => {
  const response = await db.query("SELECT CRM.id,                           " +
                                  "       CASE CRM.situacao                 " +
                                  "       WHEN 1 THEN 'QUALIFICADO'         " +
                                  "       WHEN 2 THEN 'EM PROSPECÇÃO'       " +
                                  "       WHEN 3 THEN 'AGUARDANDO PROPOSTA' " +           
                                  "       WHEN 4 THEN 'PROPOSTA ENVIADA'    " +              
                                  "       WHEN 5 THEN 'CONTRATO ASSINADO'   " +             
                                  "       WHEN 6 THEN 'RETORNAR'            " +                        
                                  "       ELSE 'SEM INTERESSE'              " +
                                  "       END AS situacao,                  " +
                                  "       CRM.dt_cadastro,                  " +
                                  "       CRM.escritorio_id,                " + 
                                  "       ESC.nome as escritorio,           " +
                                  "       CRM.entidade_id,                  " + 
                                  "       ENT.nome as responsavel,          " +
                                  "       CRM.grupo_empresarial_id,         " + 
                                  "       GRP.descricao as grupo_emp,       " +
                                  "       CRM.cnpj_cpf,                     " + 
                                  "       CRM.nome,                         " + 
                                  "       CRM.fantasia,                     " +
                                  "       contato,                          " +
                                  "       CRM.logradouro,                   " +
                                  "       CRM.numero,                       " +
                                  "       CRM.bairro,                       " +
                                  "       CRM.cidade_ibge,                  " +
                                  "       CRM.uf,                           " +
                                  "       CRM.cep,                          " +
                                  "       CRM.telefone,                     " +
                                  "       CRM.email,                        " +
                                  "       CRM.cnae_principal,               " +
                                  "       CRM.comentario,                   " +
                                  "       CRM.pessoa_tipo,                  " +
                                  "       CRM.complemento,                  " +
                                  "       CRM.ativo,                        " +
                                  "       CRM.dt_inc,                       " +
                                  "       CRM.dt_alt,                       " +
                                  "       CRM.us_inc,                       " +
                                  "       CRM.us_alt                        " +
                                  "FROM crm_leads CRM                       " + 
                                  "INNER JOIN escritorios ESC               " +
                                  "ON (CRM.escritorio_id = ESC.id)          " +
                                  "INNER JOIN entidades ENT                 " +
                                  "ON (CRM.entidade_id = ENT.id)            " +
                                  "INNER JOIN gruposempresariais GRP        " +
                                  "ON (CRM.grupo_empresarial_id = GRP.id)   " +
                                  "ORDER BY CRM.nome ASC                    ");
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar a 'Entidade':
exports.listLead = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT dt_cadastro,           ' +
                                  '       escritorio_id,         ' + 
                                  '       entidade_id,           ' + 
                                  '       grupo_empresarial_id,  ' + 
                                  '       cnpj_cpf,              ' + 
                                  '       nome,                  ' + 
                                  '       fantasia,              ' +
                                  '       contato,               ' +
                                  '       logradouro,            ' +
                                  '       numero,                ' +
                                  '       bairro,                ' +
                                  '       cidade_ibge,           ' +
                                  '       uf,                    ' +
                                  '       cep,                   ' +
                                  '       telefone,              ' +
                                  '       email,                 ' +
                                  '       cnae_principal,        ' +
                                  '       comentario,            ' +
                                  '       ativo,                 ' +
                                  '       dt_inc,                ' +
                                  '       dt_alt,                ' +
                                  '       us_inc,                ' +
                                  '       us_alt                 ' +
                                  'FROM crm_leads                ' + 
                                  'WHERE entidades.id = $1       ', 
                                  [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Lead não cadastrada!');
  }

  return res.status(200).send(response.rows);

};
