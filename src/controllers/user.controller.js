const db = require("../config/database");
const bcrypt = require('bcrypt');
const salt = bcrypt.genSaltSync(10);
const { validationResult } = require('express-validator');

// ==> Método responsável por criar um novo 'Usuario':

exports.createUser = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const { user_name, email, perfil_id, ativo, dt_inc, us_inc, entidade_id } = req.body;
  const password = bcrypt.hashSync(req.body.password, salt)
  const { rows } = await db.query(
    "INSERT INTO usuarios (user_name, email, password, perfil_id, ativo, dt_inc, us_inc, entidade_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
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
  const response = await db.query('SELECT id, user_name, email, password, perfil_id, ativo, entidade_id FROM usuarios ORDER BY user_name ASC');
  res.status(200).send(response.rows);
};

// ==> Método responsável por logar o 'Usuario':
exports.loginUser = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  const email = req.body.email;
  /*
    const password = bcrypt.hashSync(req.body.password, salt);
    const response = await db.query('SELECT user_name, perfil_id, entidade_id FROM usuarios WHERE email = $1 AND password = $2 ',
      [email, password]
    );
  */

  //const password = bcrypt.hashSync(req.body.password, salt);
  const password = req.body.password;
  const response = await db.query('SELECT user_name, password, perfil_id, entidade_id FROM usuarios WHERE email = $1 ',
    [email]
  );

  if (response.rows.length == 0) {
    return res.status(400).send('usuário não cadastrado!');
  }

  const passHashedDB = response.rows[0].password;
  const match = await bcrypt.compare(password, passHashedDB);

  if (match) {
    return res.status(200).send(response.rows);
  } else {
    return res.status(400).send('usuário não cadastrado!');
  }

};