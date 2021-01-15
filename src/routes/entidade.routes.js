/**
 * Arquivo: src/routes/entidade.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Entidades'.
 * Data: 15/01/2021
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const entidade = require('../controllers/entidade.controller');

// ==> Definindo as rotas do CRUD - 'Localização':

// ==> Rota responsável por listar todas as 'Localizações': (GET): localhost:3000/localizacoes
router.get('/entidades', entidade.listAllEntidades);

// ==> Rota responsável por criar um novo 'Grupo empresarial': (POST): localhost:3000/grupos-empresariais
router.post('/entidades', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da localização, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da localização inválida!")
], entidade.createEntidade);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/entidades', [
  check('descricao').isLength({ min: 6 }).withMessage("tamanho da descrição da localização, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da ação inválida!")
], entidade.updateEntidade);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/entidades/:id', entidade.deleteEntidadeById);

module.exports = router;