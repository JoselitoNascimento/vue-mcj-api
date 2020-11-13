/**
 * Arquivo: src/routes/acao.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Serviços'.
 * Data: 13/11/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const servico = require('../controllers/servico.controller');

// ==> Definindo as rotas do CRUD - 'Serviço':

// ==> Rota responsável por listar todas as 'Serviços': (GET): localhost:3000/servicos
router.get('/servicos', servico.listAllServicos);

// ==> Rota responsável por criar um novo 'Serviço': (POST): localhost:3000/servicos
router.post('/servicos', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do serviço, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do serviço inválida!")
], servico.createServico);

// ==> Rota responsável por alterar um 'Serviço': (PUT): localhost:3000/servicos
router.put('/servicos', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição do serviço, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação do serviço inválida!")
], servico.updateServico);

// ==> Rota responsável por excluir um 'Serviço': (DELETE): localhost:3000/servicos
router.delete('/servicos/:id', servico.deleteServicoById);

module.exports = router;