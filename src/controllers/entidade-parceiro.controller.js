const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por listar os 'Emails' de uma determinada entidade:
exports.listParceirosEntidade = async (req, res) => {

  const { entidade_id } = req.params;

  const response = await db.query('SELECT EXP.entidade_id, ENT.nome AS entidade,           ' +
                                  '       EXP.parceiro_id, PAR.nome AS parceiro            ' +
                                  'FROM entidades_parceiros EXP                            ' +
                                  'INNER JOIN entidades ENT ON (ENT.id = EXP.entidade_id)  ' +
                                  'INNER JOIN entidades PAR ON (PAR.id = EXP.parceiro_id)  ' +
                                  'WHERE entidade_id  = $1                                 ' ,
      [entidade_id]
  );

  if (response.rows.length == 0) {
    return res.status(400).send(`Parceiros não encontradas para a entidade: ${entidade_id}!`);
  }

  return res.status(200).send(response.rows);

};