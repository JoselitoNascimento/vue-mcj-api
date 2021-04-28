/**
 * Arquivo: src/routes/lead.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'leads'.
 * Data: 13/04/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const visita = require('../controllers/crm-visita.controller');

// ==> Definindo as rotas do CRUD - 'lead':

// ==> Rota responsável por listar todas os 'leads': (GET): localhost:3000/leads
router.get('/visitas', visita.listAllVisitas);

// ==> Rota responsável por criar um novo 'Lead': (POST): localhost:3000/leads
router.post('/visitas', [
  check('crm_lead_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('data').isDate().withMessage('conteúdo do campo inválido!'),
  check('entidade_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('situacao').isInt().withMessage('conteúdo do campo inválido!'),
], visita.createVisita);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/visita', [
  check('crm_lead_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('data').isDate().withMessage('conteúdo do campo inválido!'),
  check('entidade_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('situacao').isInt().withMessage('conteúdo do campo inválido!'),
], visita.updateVisita);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/visitas/:id', visita.deleteVisitaById);

module.exports = router;
