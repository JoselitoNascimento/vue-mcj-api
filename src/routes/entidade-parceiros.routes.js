/**
 * Arquivo: src/routes/entidade-parceiros.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'parceiros'.
 * Data: 05/04/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const parceiros = require('../controllers/entidade-parceiro.controller');

// ==> Definindo as rotas do CRUD - 'parceiros':

// ==> Rota responsável por listar todos os 'Emails': (GET): localhost:3000/entidade-emails
router.get('/entidade-parceiros/:entidade_id', parceiros.listParceirosEntidade);

module.exports = router;