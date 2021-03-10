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
    return res.status(400).send({ message: 'Erros: ' + errors });
  }
  try {
    const { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc } = req.body;
    await db.query('BEGIN');
    const newEntidade = await db.query(
      "INSERT INTO entidades (pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16) RETURNING id",
      [pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc]
    );

    console.log('ID: ' + newEntidade.rows[0].id);

    const { nome_contato, porte_id, cnae_principal, grupo_empresarial_id } = req.body;
    const newComplemento = await db.query(
      "INSERT INTO entidades_dados_complementares (entidade_id, nome_contato, porte_id, cnae_principal, grupo_empresarial_id) VALUES ($1, $2, $3, $4, $5)",
      [newEntidade.rows[0].id, nome_contato, porte_id, cnae_principal, grupo_empresarial_id]
    );

    await db.query('COMMIT')

    console.log('ID: ' + newEntidade.rows[0].id);

    return res.status(201).send({
      message: "Entidade adicionada com sucesso!",
      body: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc },
    });
  } catch(err) {
    await db.query('ROLLBACK');
    return res.status(409).send({ message: "Erro ocorrido ao inserir entidade: " + e});
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