const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por listar os 'Emails' de uma determinada entidade:
exports.listEstagiariosEntidade = async (req, res) => {

  const { entidade_id } = req.params;

  const response = await db.query(
    'SELECT est.entidade_id, est.estagiario_id, ent.nome, est.dt_inicio, est.dt_final ' +
    'FROM entidades_estagiario est ' +
    'INNER JOIN entidades ent ON (ent.id = est.estagiario_id) ' +
    'WHERE est.entidade_id = $1 ',
    [entidade_id]
  );
  
  return res.status(200).send(response.rows);

};