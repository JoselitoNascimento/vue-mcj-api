/**
 * Arquivo: src/routes/grupo-empresaial.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Grupos Empresariais'.
 * Data: 21/10/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const grupoController = require('../controllers/grupo-empresarial.controller');

// ==> Definindo as rotas do CRUD - 'User':

// ==> Rota responsável por listar todos os 'Usuarios': (GET): localhost:3000/users
router.get('/grupos-empresariais', grupoController.listAllGrupos);

// ==> Rota responsável por criar um novo 'usuarios': (POST): localhost:3000/users
router.post('/grupos-empresariais', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do grupo empresrial, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do grupo empresrial inválida!")
], grupoController.createGrupo);

// ==> Rota responsável por logar 'Usuario': (GET): localhost:3000/grupos-empresariais
module.exports = router;