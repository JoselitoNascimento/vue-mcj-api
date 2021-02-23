/**
 * Arquivo: src/routes/entidade-emails.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Emails da entidade'.
 * Data: 23/02/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const emails = require('../controllers/entidade-email.controller');

// ==> Definindo as rotas do CRUD - 'Emails da entidade':

// ==> Rota responsável por listar todos os 'Emails': (GET): localhost:3000/entidade-emails
router.get('/entidade-emails/:id', emails.listEmailsEntidade);

module.exports = router;