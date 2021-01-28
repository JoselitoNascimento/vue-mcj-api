const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Ação':
exports.createTipoPessoa = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { descricao, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO tiposdepessoa (descricao, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4)",
    [descricao, ativo, dt_inc, us_inc]
  );

  res.status(201).send({
    message: "Tipo de pessoa adicionada com sucesso!",
    body: {
      etapa: { descricao, ativo, dt_inc, us_inc }
    },
  });
};

// ==> Método responsável por alterar uma 'Ação':
exports.updateTipoPessoa = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { id, descricao, ativo, dt_alt, us_alt } = req.body;
  const { rows } = await db.query(
    "UPDATE tiposdepessoa SET descricao =$2, ativo = $4, dt_alt = $5, us_alt = $6  WHERE id = $1 ",
    [id, descricao, ativo, dt_alt, us_alt]
  );

  res.status(201).send({
    message: "Tipo de pessoa alterada com sucesso!",
    body: {
      etapa: { descricao, ativo, dt_alt, us_alt }
    },
  });
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteTipoPessoaById = async (req, res) => {
  const id = parseInt(req.params.id);
  const { rows } = await db.query(
    "DELETE FROM tiposdepessoa WHERE id = $1",
    [id]
  );

  res.status(201).send({
    message: "Tipo de pessoa excluida com sucesso!",
    body: {
      etapa: { id }
    },
  });
};

// ==> Método responsável por listar todas as 'Ações':
exports.listAllTipoPessoa = async (_, res) => {
  const response = await db.query('SELECT id, descricao, ativo FROM tiposdepessoa ORDER BY descricao ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar a 'Ação':
exports.listTipoPessoa = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT id, descricao, ativo FROM tiposdepessoa WHERE id = $1 ',
    [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Tipo de pessoa não cadastrada!');
  }

  return res.status(200).send(response.rows);

};