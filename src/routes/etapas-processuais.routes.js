/**
 * Arquivo: src/routes/etapas-processuais.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Etapas Processuais'.
 * Data: 03/12/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const etapaProcessual = require('../controllers/etapa-processual.controller');

// ==> Definindo as rotas do CRUD - 'Etapas Processuais':

// ==> Rota responsável por listar todas as 'Etapas processuais': (GET): localhost:3000/etapas-processuais
router.get('/etapas-processuais', etapaProcessual.listAllEtapasProcessuais);

// ==> Rota responsável por criar uma nova 'Etapa processual': (POST): localhost:3000/etapas-processuais
router.post('/etapas-processuais', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da etapa processual, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da etapa processual inválida!")
], etapaProcessual.createEtapaProcessual);

// ==> Rota responsável por alterar uma 'Etapa Processual': (PUT): localhost:3000/etapas-processuais
router.put('/etapas-processuais', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da etapa processual, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da etapa processual inválida!")
], etapaProcessual.updateEtapaProcessual);

// ==> Rota responsável por excluir uma 'Etapa Processual': (DELETE): localhost:3000/etapas-processuais
router.delete('/etapas-processuais/:id', etapaProcessual.deleteEtapaProcessualById);

module.exports = router;