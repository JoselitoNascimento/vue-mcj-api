/**
 * Arquivo: src/routes/entidade-enderecos.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Endereços da entidade'.
 * Data: 05/03/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const enderecos = require('../controllers/entidade-endereco.controller');
// ==> Definindo as rotas do CRUD - 'Enderecos da entidade':

// ==> Rota responsável por listar todos os 'Endrecos': (GET): localhost:3000/entidade-enderecos
router.get('/entidade-enderecos/:entidade_id', enderecos.listEnderecosEntidade);

module.exports = router;