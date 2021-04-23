/**
 * Arquivo: src/routes/lead.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'leads'.
 * Data: 13/04/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const lead = require('../controllers/lead.controller');

// ==> Definindo as rotas do CRUD - 'lead':

// ==> Rota responsável por listar todas os 'leads': (GET): localhost:3000/leads
router.get('/leads', lead.listAllLead);

// ==> Rota responsável por criar um novo 'Lead': (POST): localhost:3000/leads
router.post('/leads', [
  check('dt_cadastro').isDate().withMessage('conteúdo do campo inválido!'),
  check('escritorio_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('entidade_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('grupo_empresarial_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('cnpj_cpf').isLength({ min: 11, max: 14 }).withMessage('CNPJ/CPF da entidade inválido!'),
  check('nome').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('fantasia').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('contato').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('logradouro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('numero').isLength({ min: 1 }).withMessage('conteúdo com tamanho inválido!'),
  check('bairro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cidade_ibge').isInt().withMessage('conteúdo do campo inválido!'),
  check('uf').isLength({ min: 2 }).withMessage('conteúdo com tamanho inválido!'),
  check('cep').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('telefone').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('email').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('ativo').isIn(['S', 'N']).withMessage('conteúdo do campo inválido!'),
], lead.createLead);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/leads', [
  check('dt_cadastro').isDate().withMessage("conteúdo do campo inválido!"),
  check('escritorio_id').isInt().withMessage("conteúdo do campo inválido!"),
  check('entidade_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('grupo_empresarial_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('cnpj_cpf').isLength({ min: 11, max: 14 }).withMessage("CNPJ/CPF da entidade inválido!"),
  check('nome').isLength({ min: 6 }).withMessage("conteúdo com tamanho inválido!"),
  check('fantasia').isLength({ min: 6 }).withMessage("nome de fantasia da entidade inválido!"),
  check('contato').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('logradouro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('numero').isLength({ min: 1 }).withMessage('conteúdo com tamanho inválido!'),
  check('bairro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cidade_ibge').isInt().withMessage('conteúdo do campo inválido!'),
  check('uf').isLength({ min: 2 }).withMessage('conteúdo com tamanho inválido!'),
  check('cep').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('telefone').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('email').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('ativo').isIn(['S', 'N']).withMessage("conteúdo do campo inválido!"),
], lead.updateLead);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/leads/:id', lead.deleteLeadById);

module.exports = router;
