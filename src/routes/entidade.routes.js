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
  check('pessoa_id').isInt().withMessage("categoria da entidade inválida!"),
  check('pessoa_tipo').isIn(['F', 'J']).withMessage("tipo de pessoa inválida!"),
  check('nome').isLength({ min: 6 }).withMessage("razão social da entidade inválido!"),
  check('fantasia').isLength({ min: 6 }).withMessage("nome de fantasia da entidade inválido!"),
  check('cnpj_cpf').isLength({ min: 11, max: 14 }).withMessage("CNPJ/CPF da entidade inválido!"),
  check('endereco').isLength({ min: 1 }).withMessage("endereço da entidade inválido!"),
  check('bairro').isLength({ min: 1 }).withMessage("bairro da entidade inválido!"),
  check('cidade_ibge').isLength({ min: 1 }).withMessage("cidade da entidade inválida!").isInt().withMessage("codigo da cidade inválido!"),
  //check('cep').isLength({ min: 8 , max: 8 }).withMessage("cep da entidade, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da localização inválida!"),
  check('cep').custom((value, {req}) => {
    if (req.body.pessoa_id == 1 && value == "") {
      return false;
    } 
    return true;
  }).withMessage("cep não informado!"),
], entidade.createEntidade);

// ==> Rota responsável por alterar um 'Grupo empresarial': (PUT): localhost:3000/grupos-empresariais
router.put('/entidades', [
  check('pessoa_id').isInt().withMessage("categoria da entidade inválida!"),
  check('pessoa_tipo').isIn(['F', 'J']).withMessage("tipo de pessoa inválida!"),
  check('nome').isLength({ min: 6 }).withMessage("razão social da entidade inválido!"),
  check('fantasia').isLength({ min: 6 }).withMessage("nome de fantasia da entidade inválido!"),
  check('cnpj_cpf').isLength({ min: 11, max: 14 }).withMessage("CNPJ/CPF da entidade inválido!"),
  check('endereco').isLength({ min: 1 }).withMessage("endereço da entidade inválido!"),
  check('bairro').isLength({ min: 1 }).withMessage("bairro da entidade inválido!"),
  check('cidade_ibge').isLength({ min: 1 }).withMessage("cidade da entidade inválida!").isInt().withMessage("codigo da cidade inválido!"),
  check('cep').isLength({ min: 8 , max: 8 }).withMessage("cep da entidade, inválido!"),
  check('ativo').isIn(['A', 'I']).withMessage("situação da localização inválida!"),
], entidade.updateEntidade);

// ==> Rota responsável por excluir um 'Grupo empresarial': (DELETE): localhost:3000/grupos-empresariais
router.delete('/entidades/:id', entidade.deleteEntidadeById);

module.exports = router;
