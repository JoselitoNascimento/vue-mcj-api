/**
 * Arquivo: src/routes/uf.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'UF'.
 * Data: 15/10/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const ufController = require('../controllers/uf.controller');

// ==> Rota responsável por listar todos os 'Estados': (GET): 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
router.get('/ufs', ufController.listUFs);

module.exports = router;