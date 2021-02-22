/**
 * Arquivo: src/routes/entidade-oab.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'OABs da entidade'.
 * Data: 19/02/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const oabs = require('../controllers/entidade-oab.controller');

// ==> Definindo as rotas do CRUD - 'OABs da entidade':

// ==> Rota responsável por listar todas as 'OABs': (GET): localhost:3000/entidade-oabs
router.get('/entidade-oabs/:id', oabs.listOabsEntidade);

module.exports = router;