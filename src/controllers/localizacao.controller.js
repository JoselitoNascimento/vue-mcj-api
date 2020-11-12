const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Ação':
exports.createLocalizacao = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { descricao, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO localizacoes (descricao, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4)",
    [descricao, ativo, dt_inc, us_inc]
  );

  res.status(201).send({
    message: "Localização adicionada com sucesso!",
    body: {
      localizacao: { descricao, ativo, dt_inc, us_inc }
    },
  });
};

// ==> Método responsável por alterar uma 'Ação':
exports.updateLocalizacao = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { id, descricao, ativo, dt_alt, us_alt } = req.body;
  const { rows } = await db.query(
    "UPDATE localizacoes SET descricao =$2, ativo = $3, dt_alt = $4, us_alt = $5  WHERE id = $1 ",
    [id, descricao, ativo, dt_alt, us_alt]
  );

  res.status(201).send({
    message: "Localização alterada com sucesso!",
    body: {
      localizacao: { descricao, ativo, dt_alt, us_alt }
    },
  });
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteLocalizacaoById = async (req, res) => {
  const id = parseInt(req.params.id);
  const { rows } = await db.query(
    "DELETE FROM localizacoes WHERE id = $1",
    [id]
  );

  res.status(201).send({
    message: "Localização excluida com sucesso!",
    body: {
      localizacao: { id }
    },
  });
};

// ==> Método responsável por listar todas as 'Ações':
exports.listAllLocalizacoes = async (_, res) => {
  const response = await db.query('SELECT id, descricao, ativo FROM localizacoes ORDER BY descricao ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar a 'Ação':
exports.listLocalizacao = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT id, descricao, ativo FROM localizacoes WHERE id = $1 ',
    [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Localização não cadastrada!');
  }

  return res.status(200).send(response.rows);

};