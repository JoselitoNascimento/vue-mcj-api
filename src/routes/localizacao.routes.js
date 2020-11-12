/**
 * Arquivo: src/routes/acao.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Localizações'.
 * Data: 12/11/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const localizacao = require('../controllers/localizacao.controller');

// ==> Definindo as rotas do CRUD - 'Localização':

// ==> Rota responsável por listar todas as 'Localizações': (GET): localhost:3000/localizacoes
router.get('/localizacoes', localizacao.listAllLocalizacoes);

// ==> Rota responsável por criar um novo 'Grupo empresarial': (POST): localhost:3000/grupos-empresariais
router.post('/localizacoes', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da localização, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da localização inválida!")
], localizacao.createLocalizacao);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/localizacoes', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da localização, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da ação inválida!")
], localizacao.updateLocalizacao);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/localizacoes/:id', localizacao.deleteLocalizacaoById);

module.exports = router;