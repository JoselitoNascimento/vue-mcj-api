const db = require("../config/database");

// ==> Método responsável por criar um novo 'Usuario':

exports.createGrupoEmpresarial = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { descricao, ativo, dt_inc, us_inc } = req.body;
  const { rows } = await db.query(
    "INSERT INTO grupoempresarial (descricao, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4)",
    [descricao, ativo, dt_inc, us_inc]
  );

  res.status(201).send({
    message: "grupo empresarial added successfully!",
    body: {
      grupoEmpresarial: { descricao, ativo, dt_inc, us_inc }
    },
  });
};

// ==> Método responsável por listar todos os 'Usuarios':
exports.listAllGrupos = async (_, res) => {
  console.log('passou por aqui...');  
  const response = await db.query('SELECT id, descricao, ativo FROM grupoempresarial ORDER BY descricao ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por listar todos os 'Usuarios':
exports.listGrupo = async (_, res) => {
    const response = await db.query('SELECT id, descricao, ativo FROM grupoempresarial ORDER BY descricao ASC');
    res.status(200).send(response.rows);
  };
  