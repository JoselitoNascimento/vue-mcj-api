/**
 * Arquivo: src/routes/etapas-processuais.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Etapas Processuais'.
 * Data: 03/12/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const orgaoCompetente = require('../controllers/orgao-competente.controller');

// ==> Definindo as rotas do CRUD - 'Etapas Processuais':

// ==> Rota responsável por listar todas as 'Etapas processuais': (GET): localhost:3000/etapas-processuais
router.get('/orgaos-competentes', orgaoCompetente.listAllOrgaosCompetentes);

// ==> Rota responsável por criar uma nova 'Etapa processual': (POST): localhost:3000/etapas-processuais
router.post('/orgaos-competentes', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do orgão competente, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do orgão competente inválida!")
], orgaoCompetente.createOrgaoCompetente);

// ==> Rota responsável por alterar uma 'Etapa Processual': (PUT): localhost:3000/etapas-processuais
router.put('/orgaos-competentes', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do orgão competente, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do orgão competente inválida!")
], orgaoCompetente.updateOrgaoCompetente);

// ==> Rota responsável por excluir uma 'Etapa Processual': (DELETE): localhost:3000/etapas-processuais
router.delete('/orgaos-competentes/:id', orgaoCompetente.deleteOrgaoCompetenteById);

module.exports = router;