/**
 * Arquivo: src/routes/tipos-ocorrencias.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Tipos de Ocorrências'.
 * Data: 11/12/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const tipoocorrencia = require('../controllers/tipo-ocorrencia.controller');

// ==> Definindo as rotas do CRUD - 'Etapas Processuais':

// ==> Rota responsável por listar todas as 'Etapas processuais': (GET): localhost:3000/etapas-processuais
router.get('/tipos-ocorrencias', tipoocorrencia.listAllTiposOcorrencia);

// ==> Rota responsável por criar uma nova 'Etapa processual': (POST): localhost:3000/etapas-processuais
router.post('/tipos-ocorrencias', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da etapa processual, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da etapa processual inválida!")
], tipoocorrencia.createTipoOcorrencia);

// ==> Rota responsável por alterar uma 'Etapa Processual': (PUT): localhost:3000/etapas-processuais
router.put('/tipos-ocorrencias', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da etapa processual, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da etapa processual inválida!")
], tipoocorrencia.updateTipoOcorrencia);

// ==> Rota responsável por excluir uma 'Etapa Processual': (DELETE): localhost:3000/etapas-processuais
router.delete('/tipos-ocorrencias/:id', tipoocorrencia.deleteTipoOcorrenciaById);

module.exports = router;