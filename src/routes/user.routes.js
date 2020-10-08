// @ts-nocheck
/**
 * Arquivo: src/routes/user.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'User'.
 * Data: 04/03/2020
 * Author Glaucia Lemos
 */

const router = require('express-promise-router')();
const userController = require('../controllers/user.controller');

// ==> Definindo as rotas do CRUD - 'User':

// ==> Rota responsável por listar todos os 'Usuarios': (GET): localhost:3000/api/products
router.get('/users', userController.listAllUsers);

// ==> Rota responsável por criar um novo 'usuarios': (POST): localhost:3000/api/products
router.post('/users', userController.createUser);

module.exports = router;