const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Ação':
exports.createTipoOcorrencia = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { descricao, tipo_faturar, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO tiposdeocorrencia (descricao, tipo_faturar, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5)",
    [descricao, tipo_faturar, ativo, dt_inc, us_inc]
  );

  res.status(201).send({
    message: "Tipo de ocorrência adicionada com sucesso!",
    body: {
      etapa: { descricao, tipo_faturar, ativo, dt_inc, us_inc }
    },
  });
};

// ==> Método responsável por alterar uma 'Ação':
exports.updateTipoOcorrencia = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { id, descricao, tipo_faturar, ativo, dt_alt, us_alt } = req.body;
  const { rows } = await db.query(
    "UPDATE tiposdeocorrencia SET descricao =$2, tipo_faturar = $3, ativo = $4, dt_alt = $5, us_alt = $6  WHERE id = $1 ",
    [id, descricao, tipo_faturar, ativo, dt_alt, us_alt]
  );

  res.status(201).send({
    message: "Tipo de ocorrência alterada com sucesso!",
    body: {
      etapa: { descricao, tipo_faturar, ativo, dt_alt, us_alt }
    },
  });
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteTipoOcorrenciaById = async (req, res) => {
  const id = parseInt(req.params.id);
  const { rows } = await db.query(
    "DELETE FROM tiposdeocorrencia WHERE id = $1",
    [id]
  );

  res.status(201).send({
    message: "Tipo de ocorrência excluida com sucesso!",
    body: {
      etapa: { id }
    },
  });
};

// ==> Método responsável por listar todas as 'Ações':
exports.listAllTiposOcorrencia = async (_, res) => {
  const response = await db.query('SELECT id, descricao, tipo_faturar, ativo FROM tiposdeocorrencia ORDER BY descricao ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar a 'Ação':
exports.listTipoOcorrencia = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const id = req.body.id;
  const response = await db.query('SELECT id, descricao, tipo_faturar, ativo FROM tiposdeocorrencia WHERE id = $1 ',
    [id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('Tipo de ocorrência não cadastrada!');
  }

  return res.status(200).send(response.rows);

};