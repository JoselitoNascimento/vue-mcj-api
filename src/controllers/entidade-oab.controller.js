const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por listar as 'OABs' de uma determinada entidade:
exports.listOabsEntidade = async (req, res) => {

  const entidade_id = parseInt(req.params.id);

  const response = await db.query('SELECT entidade_id, numero_oab, uf_oab FROM entidades_oab WHERE entidade_id = $1 ',
    [entidade_id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send(`OABs não encontradas para a entidade: ${entidade_id}!`);
  }

  return res.status(200).send(response.rows);

};