const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por listar os 'Emails' de uma determinada entidade:
exports.listEmailsEntidade = async (req, res) => {

  const { entidade_id } = req.params;

  const response = await db.query('SELECT entidade_id, conta, email FROM entidades_email WHERE entidade_id = $1 ',
    [entidade_id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send(`Emails não encontradas para a entidade: ${entidade_id}!`);
  }

  return res.status(200).send(response.rows);

};