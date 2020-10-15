/**
 * Arquivo: src/routes/cnae.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'UF'.
 * Data: 15/10/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const cnaeController = require('../controllers/cnae.controller');

// ==> Rota responsável por listar todos os 'CNAEs': (GET): 'https://servicodados.ibge.gov.br/api/v2/cnae/classes/'
router.get('/cnaes', cnaeController.listCNAEs);

module.exports = router;