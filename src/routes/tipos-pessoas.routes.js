/**
 * Arquivo: src/routes/tipos-pessoas.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Tipos de Pessoas'.
 * Data: 28/01/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const tipopessoa = require('../controllers/tipo-pessoa.controller');

// ==> Definindo as rotas do CRUD - 'Tipos de pessoas':

// ==> Rota responsável por listar todas os 'Tipos de Pessoa': (GET): localhost:3000/tipos-pessoas
router.get('/tipos-pessoas', tipopessoa.listAllTipoPessoa);

// ==> Rota responsável por criar um novo 'Tipo de Pessoa': (POST): localhost:3000/tipos-pessoas
router.post('/tipos-pessoas', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do tipo de pessoa, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da etapa processual inválida!")
], tipopessoa.createTipoPessoa);

// ==> Rota responsável por alterar um 'Tipo de Pessoa': (PUT): localhost:3000/tipos-pessoas
router.put('/tipos-pessoas', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do tipo de pessoa, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da etapa processual inválida!")
], tipopessoa.updateTipoPessoa);

// ==> Rota responsável por excluir um 'Tipo de Pessoa': (DELETE): localhost:3000/tipos-pessoas
router.delete('/tipos-pessoas/:id', tipopessoa.deleteTipoPessoaById);

module.exports = router;