/**
 * Arquivo: src/routes/entidade-estagiarios.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Estagiários da entidade'.
 * Data: 24/02/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const estagiarios = require('../controllers/entidade-estagiario.controller');

// ==> Definindo as rotas do CRUD - 'Estagiários da entidade':

// ==> Rota responsável por listar todos os 'Estagiários': (GET): localhost:3000/entidade-estagiarios
router.get('/entidade-estagiarios/:id', estagiarios.listEstagiariosEntidade);

module.exports = router;