const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar um novo 'Grupo Empresarial':
exports.createGrupo = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { descricao, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO gruposempresariais (descricao, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4)",
    [descricao, ativo, dt_inc, us_inc]
  );

  res.status(201).send({
    message: "Grupo Empresarial adicionado com sucesso!",
    body: {
      grupoempresarial: { descricao, ativo, dt_inc, us_inc }
    },
  });
};

// ==> Método responsável por alterar um 'Grupo Empresarial':
exports.updateGrupo = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { id, descricao, ativo, dt_alt, us_alt } = req.body;
  const { rows } = await db.query(
    "UPDATE gruposempresariais SET descricao =$2, ativo = $3, dt_alt = $4, us_alt = $5  WHERE id = $1 ",
    [id, descricao, ativo, dt_alt, us_alt]
  );

  res.status(201).send({
    message: "Grupo Empresarial alterado com sucesso!",
    body: {
      grupoempresarial: { descricao, ativo, dt_alt, us_alt }
    },
  });
};

// ==> Método responsável por excluir um 'Grupo Empresarial':
exports.deleteGrupoById = async (req, res) => {
  const id = parseInt(req.params.id);
  const { rows } = await db.query(
    "DELETE FROM gruposempresariais WHERE id = $1",
    [id]
  );

  res.status(201).send({
    message: "Grupo Empresarial excluido com sucesso!",
    body: {
      grupoempresarial: { id }
    },
  });
};

// ==> Método responsável por listar todos os 'Grupos Empresariais':
exports.listAllGrupos = async (_, res) => {
  const response = await db.query('SELECT id, descricao, ativo FROM gruposempresariais ORDER BY descricao ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por logar o 'Usuario':
exports.listGrupo = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT id, descricao, ativo FROM gruposempresariais WHERE id = $1 ',
    [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Grupo empresarial não cadastrado!');
  }

  return res.status(200).send(response.rows);

};