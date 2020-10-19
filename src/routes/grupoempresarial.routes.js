/**
 * Arquivo: src/routes/grupoempresarial.routes.js
 * Descrição: arquivo responsável pelas rotas da api relacionado a classe 'Grupos Empresariais'.
 * Data: 19/10/2020
 * Author Joselito Nascimento
 */

const router = require('express-promise-router')();
const { check } = require('express-validator');
const grupoempresarialController = require('../controllers/grupoempresarial.controller');

// ==> Definindo as rotas do CRUD - 'User':
// ==> Rota responsável por listar todos os 'Grupos Empresariais': (GET): localhost:3000/users
router.get('/grupos-empresariais', grupoempresarialController.listAllGrupos);

// ==> Rota responsável por criar um novo 'Grupo Empresarial': (POST): localhost:3000/users
router.post('/grupos-empresariais', [
  check('descricao').isLength({ min: 8, max: 60 }).withMessage("tamanho da descrição do Grupo Empresarial inválido!")
], grupoempresarialController.createGrupoEmpresarial);

// ==> Rota responsável por logar 'Usuario': (GET): localhost:3000/user
router.post('/grupos-empresariais', [
  check('id').isLength({ min: 1 }).withMessage("Grupo Empresarial não informado!")
], grupoempresarialController.listGrupo);

module.exports = router;