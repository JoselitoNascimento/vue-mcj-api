const db = require("../config/database");

// ==> Método responsável por criar um novo 'Usuario':

exports.createUser = async (req, res) => {
  const { user_name, email, password, perfil_id, ativo, dt_inc, us_inc, entidade_id } = req.body;
  const { rows } = await db.query(
    "INSERT INTO tbusuarios (user_name, email, password, perfil_id, ativo, dt_inc, us_inc, entidade_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
    [user_name, email, password, perfil_id, ativo, dt_inc, us_inc, entidade_id]
  );

  res.status(201).send({
    message: "user added successfully!",
    body: {
      product: { user_name, email, password, perfil_id, ativo, dt_inc, us_inc, entidade_id }
    },
  });
};

// ==> Método responsável por listar todos os 'Usuarios':
exports.listAllUsers = async (_, res) => {
    const response = await db.query('SELECT * FROM tbusuarios ORDER BY user_name ASC');
    res.status(200).send(response.rows);
};