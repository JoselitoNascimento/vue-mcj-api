/**
 * Arquivo: src/routes/escritorios.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'escritorios'.
 * Data: 20/04/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const escritorio = require('../controllers/escritorio.controller');

// ==> Rota responsável por listar todas as 'Entidades': (GET): localhost:3000/entidades
router.get('/escritorios', escritorio.listAllEscritorios);

// ==> Rota responsável por criar um novo 'Grupo empresarial': (POST): localhost:3000/grupos-empresariais
router.post('/escritorios', [
  check('nome').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('fantasia').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('logradouro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cnpj').isLength({ min: 14, max: 14 }).withMessage('CNPJ do escritório inválido!'),
  check('cnae').isLength({ min: 7 }).withMessage('conteúdo com tamanho inválido!'),
  check('numero').isLength({ min: 1 }).withMessage('conteúdo com tamanho inválido!'),
  check('bairro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cidade_ibge').isInt().withMessage('conteúdo do campo inválido!'),
  check('uf').isLength({ min: 2 }).withMessage('conteúdo com tamanho inválido!'),
  check('cep').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('ativo').isIn(['A', 'I']).withMessage('conteúdo do campo inválido!'),
], escritorio.createEscritorio);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/escritorios', [
  check('nome').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('fantasia').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('logradouro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cnpj').isLength({ min: 14, max: 14 }).withMessage('CNPJ do escritório inválido!'),
  check('cnae').isLength({ min: 7 }).withMessage('conteúdo com tamanho inválido!'),
  check('numero').isLength({ min: 1 }).withMessage('conteúdo com tamanho inválido!'),
  check('bairro').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cidade_ibge').isInt().withMessage('conteúdo do campo inválido!'),
  check('uf').isLength({ min: 2 }).withMessage('conteúdo com tamanho inválido!'),
  check('cep').isLength({ min: 8 }).withMessage('conteúdo com tamanho inválido!'),
  check('ativo').isIn(['A', 'I']).withMessage('conteúdo do campo inválido!'),
], escritorio.updateEscritorio);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/escritorios/:id', escritorio.deleteEscritorioById);

module.exports = router;
