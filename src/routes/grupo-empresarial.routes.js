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

// ==> Rota responsável por listar todos os 'Grupos empresariais': (GET): localhost:3000/grupos-empresariais
router.get('/grupos-empresariais', grupoController.listAllGrupos);

// ==> Rota responsável por criar um novo 'Grupo empresarial': (POST): localhost:3000/grupos-empresariais
router.post('/grupos-empresariais', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do grupo empresarial, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do grupo empresarial inválida!")
], grupoController.createGrupo);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/grupos-empresariais', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do grupo empresarial, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do grupo empresarial inválida!")
], grupoController.updateGrupo);

module.exports = router;