/**
 * Arquivo: src/routes/user.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'User'.
 * Data: 11/10/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const userController = require('../controllers/user.controller');

// ==> Definindo as rotas do CRUD - 'User':

// ==> Rota responsável por listar todos os 'Usuarios': (GET): localhost:3000/users
router.get('/users', userController.listAllUsers);

// ==> Rota responsável por criar um novo 'usuarios': (POST): localhost:3000/users
router.post('/users', [
  check('email').isEmail().withMessage("email inválido!"),
  check('password').isLength({ min: 8, max: 20 }).withMessage("tamanho de senha inválido!"),
  check('perfil_id').isInt({ min: 1 }).withMessage("perfil de usuário inválido!"),
  check('entidade_id').isInt({ min: 1 }).withMessage("código do usuário inválido no cadastro de entidades!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do usuário inválida!")
], userController.createUser);

// ==> Rota responsável por logar 'Usuario': (GET): localhost:3000/user
router.post('/user', [
  check('email').isEmail().withMessage("email inválido!"),
  check('password').isLength({ min: 8, max: 20 }).withMessage("tamanho de senha inválido!")
], userController.loginUser);

module.exports = router;