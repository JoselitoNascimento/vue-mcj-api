const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Ação':
exports.createEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO entidades (pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)",
    [pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_inc, us_inc]
  );

  res.status(201).send({
    message: "Entidade adicionada com sucesso!",
    body: {
      localizacao: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_inc, us_inc }
    },
  });
};

// ==> Método responsável por alterar uma 'Ação':
exports.updateEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_alt, us_alt } = req.body;
  const { rows } = await db.query(
    "UPDATE entidades SET pessoa_id =$2, pessoa_tipo =$2, nome =$4, fantasia =$5, cnpj_cpf =$6, insc_mun =$7, insc_est =$8, endereco =$9, numero =$10, bairro =$11, cidade_id =$12, uf =$13, cep =$14, ativo =$15, dt_alt = $16, us_alt = $17  WHERE id = $1 ",
    [ id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_alt, us_alt ]
  );

  res.status(201).send({
    message: "Entidade alterada com sucesso!",
    body: {
      localizacao: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_alt, us_alt }
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

// ==> Método responsável por listar todas as 'Ações':
exports.listAllEntidades = async (_, res) => {
  const response = await db.query('SELECT id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_inc, dt_alt, us_inc, us_alt FROM entidades ORDER BY nome ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar a 'Ação':
exports.listEntidade = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_id, uf, cep, ativo, dt_inc, dt_alt, us_inc, us_alt FROM entidades WHERE id = $1 ',
    [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Entidade não cadastrada!');
  }

  return res.status(200).send(response.rows);

};