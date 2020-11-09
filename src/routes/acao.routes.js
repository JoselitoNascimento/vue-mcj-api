/**
 * Arquivo: src/routes/acao.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Ações'.
 * Data: 09/11/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const acao = require('../controllers/acao.controller');

// ==> Definindo as rotas do CRUD - 'Acao':

// ==> Rota responsável por listar todas as 'Ações': (GET): localhost:3000/acoes
router.get('/acoes', acao.listAllAcoes);

// ==> Rota responsável por criar um novo 'Grupo empresarial': (POST): localhost:3000/grupos-empresariais
router.post('/acoes', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da ação, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da ação inválida!")
], acao.createAcao);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/acoes', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da ação, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da ação inválida!")
], acao.updateAcao);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/acoes/:id', acao.deleteAcaoById);

module.exports = router;