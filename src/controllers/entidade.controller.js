const db = require("../config/database");
const { validationResult } = require('express-validator');
//const { Pool } = require('pg');
//const pool = new Pool();

// ==> Método responsável por criar uma nova 'Ação':
/*exports.createEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_ibge, uf, cep, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO entidades (pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_ibge, uf, cep, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16) RETURNING id",
    [pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_ibge, uf, cep, ativo, dt_inc, us_inc]
  );
  

  res.status(201).send({
    message: "Entidade adicionada com sucesso!",
    body: {
      localizacao: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_ibge, uf, cep, ativo, dt_inc, us_inc }
    },
  });
};
*/
// ==> Método responsável por criar uma nova 'Entidade':
exports.createEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    const erro = res.status(400).send({ message: 'Erros: ' + errors });
    console.log('Erro: ' + JSON.stringify(errors));
    return erro;
  }
  try {
    console.log(req.body);
    const { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc } = req.body;
    await db.query('BEGIN');
    const newEntidade = await db.query(
      "INSERT INTO entidades (pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id",
      [pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc]
    );
    const newID = newEntidade.rows[0].id;
    // Dados complementares apenas para Cliente=1 e Fornecedor=2   
    if (pessoa_id == 1 || pessoa_id == 2) {
      const { nome_contato, porte_id, cnae_principal, grupo_empresarial_id } = req.body;
      const newComplemento = await db.query(
        "INSERT INTO entidades_dados_complementares (entidade_id, nome_contato, porte_id, cnae_principal, grupo_empresarial_id) VALUES ($1, $2, $3, $4, $5)",
        [newID, nome_contato, porte_id, cnae_principal, grupo_empresarial_id]
      );
    }
    // Dados do endereço é para todos 
    const { enderecos } = req.body;
    console.log('Endereços: ' + JSON.stringify(enderecos));
    if (enderecos) {
      for (let index = 0; index < enderecos.length; index++) {
        const { cep, logradouro, numero, bairro, cidade_ibge, uf, complemento } = enderecos[index];
        const newEndereco = await db.query(
          "INSERT INTO entidades_enderecos (entidade_id, cep, logradouro, numero, bairro, cidade_ibge, uf, complemento, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)",
          [newID, cep, logradouro, numero, bairro, cidade_ibge, uf, complemento, ativo, dt_inc, us_inc]
        );
      }
    }  
    // Dados da OAB apenas para advogados   
    const { oabs } = req.body;
    if (oabs) {
      for (let index = 0; index < oabs.length; index++) {
        const { numero_oab, uf_oab, ativo, dt_inc, us_inc } = oabs[index];
        const newOab = await db.query(
          "INSERT INTO entidades_oab (entidade_id, numero_oab, uf_oab, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6)",
          [newID, numero_oab, uf_oab, ativo, dt_inc, us_inc]
        );
//        console.log('OABs ' + newOab);
      }  
    }
/*
    // Dados do estagiário apenas para advogados 
    const { estagiarios } = req.body;
    if (estagiarios) {
      const { estagiario_id, dt_inicio, dt_final, ativo, dt_inc, us_inc } = estagiarios;
      const newEstagiario = await db.query(
        "INSERT INTO entidades_estagiario (entidade_id, estagiario_id, dt_inicio, dt_final, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7)",
        [newEntidade.rows[0].id, estagiario_id, dt_inicio, dt_final, ativo, dt_inc, us_inc]
      );
      console.log('Estagiario: ' + newEstagiario);
    }
    // Dados do email é para todos   
    const { emails } = req.body;
    if (emails) {
      const { conta, email, ativo, dt_inc, us_inc } = emails;
      const newEmail = await db.query(
        "INSERT INTO entidades_email (entidade_id, conta, email, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6)",
        [newEntidade.rows[0].id, conta, email, ativo, dt_inc, us_inc]
      );
      console.log('Email: ' + newEmail);
    }
*/
    await db.query('COMMIT')

    return res.status(201).send({
      message: "Entidade adicionada com sucesso!",
      body: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao inserir entidade: " + err});
    //console.log(erro);
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por alterar uma 'Entidade':
exports.updateEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_alt, us_alt } = req.body;
  const { rows } = await db.query(
    "UPDATE entidades SET pessoa_id =$2, pessoa_tipo =$2, nome =$4, fantasia =$5, cnpj_cpf =$6, insc_mun =$7, insc_est =$8, ativo =$9, dt_alt = $10, us_alt = $11  WHERE id = $1 ",
    [ id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_alt, us_alt ]
  );

  res.status(201).send({
    message: "Entidade alterada com sucesso!",
    body: {
      localizacao: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_alt, us_alt }
    },
  });
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteEntidadeById = async (req, res) => {
  const id = parseInt(req.params.id);
  const { rows } = await db.query(
    "DELETE FROM entidades WHERE id = $1",
    [id]
  );

  res.status(201).send({
    message: "Entidade excluida com sucesso!",
    body: {
      localizacao: { id }
    },
  });
};

// ==> Método responsável por listar todas as 'Entidades':
exports.listAllEntidades = async (_, res) => {
  const response = await db.query('SELECT entidades.id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, entidades.ativo, ' + 
                                  'entidades.dt_inc, entidades.dt_alt, entidades.us_inc, entidades.us_alt, descricao as categoria ' + 
                                  'FROM entidades ' + 
                                  'INNER JOIN tiposdepessoa ON (tiposdepessoa.id = entidades.pessoa_id) ' + 
                                  'ORDER BY nome ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar a 'Entidade':
exports.listEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT entidades.id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, entidades.ativo, ' + 
                                  'entidades.dt_inc, entidades.dt_alt, entidades.us_inc, entidades.us_alt, descricao as categoria ' +
                                  'FROM entidades ' +
                                  'INNER JOIN tiposdepessoa ON (tiposdepessoa.id = entidades.pessoa_id) ' + 
                                  'WHERE entidades.id = $1 ', 
                                  [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Entidade não cadastrada!');
  }

  return res.status(200).send(response.rows);

};

// ==> Método responsável por listar por 'Tipo de Pessoa':
exports.listEntidadeCategoria = async (req, res) => {
  let urlIdx = JSON.stringify(req.url);
  let pessoa_id = urlIdx.substring(32,33);

  const response = await db.query('SELECT id, nome FROM entidades WHERE pessoa_id = $1 AND ativo = $2 ',
    [pessoa_id, 'A']
  );

  if (response.rows.length == 0) {
    return res.status(400).send(`Nao foi encontrado nenhum registro para categoria ${pessoa_id}!`);
  }

  return res.status(200).send(response.rows);

};