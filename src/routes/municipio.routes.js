/**
 * Arquivo: src/routes/uf.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'MUNICIPIOS'.
 * Data: 15/10/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const municipioController = require('../controllers/municipio.controller');

// ==> Rota responsável por listar todos os 'Estados': (GET): 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
router.get('/municipios', municipioController.listMunicipios);

module.exports = router;
