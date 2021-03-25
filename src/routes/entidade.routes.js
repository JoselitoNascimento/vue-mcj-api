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

// ==> Rota responsável por listar todas as 'Entidades': (GET): localhost:3000/entidades
router.get('/entidades', entidade.listAllEntidades);

// ==> Rota responsável por listar Entidades por categoria': (GET): localhost:3000/categoria
router.get('/entidades/categoria/:id', entidade.listEntidadeCategoria);

// ==> Rota responsável por criar um novo 'Grupo empresarial': (POST): localhost:3000/grupos-empresariais
router.post('/entidades', [
  check('pessoa_id').isInt().withMessage('conteúdo do campo inválido!'),
  check('pessoa_tipo').isIn(['F', 'J']).withMessage('conteúdo do campo inválido!'),
  check('nome').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('fantasia').isLength({ min: 6 }).withMessage('conteúdo com tamanho inválido!'),
  check('cnpj_cpf').isLength({ min: 11, max: 14 }).withMessage('CNPJ/CPF da entidade inválido!'),
  check('ativo').isIn(['A', 'I']).withMessage('conteúdo do campo inválido!'),
  check('nome_contato','conteúdo do campo não informado!').custom((value,{req}) => {
    const {pessoa_id, nome_contato} = req.body;
    if (pessoa_id < 3) { return nome_contato } else {return true}
  }),
], entidade.createEntidade);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/entidades', [
  check('pessoa_id').isInt().withMessage("conteúdo do campo inválido!"),
  check('pessoa_tipo').isIn(['F', 'J']).withMessage("conteúdo do campo inválido!"),
  check('nome').isLength({ min: 6 }).withMessage("conteúdo com tamanho inválido!"),
  check('fantasia').isLength({ min: 6 }).withMessage("nome de fantasia da entidade inválido!"),
  check('cnpj_cpf').isLength({ min: 11, max: 14 }).withMessage("CNPJ/CPF da entidade inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("conteúdo do campo inválido!"),
  check('nome_contato','conteúdo do campo não informado!').custom((value,{req}) => {
    const {pessoa_id, nome_contato} = req.body;
    if (pessoa_id < 3) { return nome_contato } else {return true}
  }),
], entidade.updateEntidade);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/entidades/:id', entidade.deleteEntidadeById);

module.exports = router;
