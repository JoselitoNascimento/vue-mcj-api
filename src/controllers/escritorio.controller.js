const db = require("../config/database");
const { validationResult } = require('express-validator');

// ==> Método responsável por criar uma nova 'Entidade':
/**
 * 
 * falta alterar para tabela de escritorios
 * 
 */

exports.createEscritorio = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: 'Erros ocorridos ao validar campo ' + errors[0].param + ': ' + errors[0].msg});
  }
  try {
    const { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc } = req.body;
    await db.query('BEGIN');
    const newEntidade = await db.query(
      "INSERT INTO entidades (pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id",
      [pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc]
    );

    await db.query('COMMIT')

    return res.status(201).send({
      message: "Entidade adicionada com sucesso!",  
      body: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, us_inc },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao inserir entidade: " + err });
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por alterar uma 'Entidade':
exports.updateEscritorio = async (req, res) => {
  const { errors } = validationResult(req);
  if (errors.length > 0) {
    return res.status(400).send({ message: errors })
  }
  try {
    const { id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_alt, us_alt } = req.body;
    await db.query('BEGIN');
    const { rows } = await db.query(
      "UPDATE entidades SET pessoa_id =$2, pessoa_tipo =$3, nome =$4, fantasia =$5, cnpj_cpf =$6, insc_mun =$7, insc_est =$8, ativo =$9, dt_alt = $10, us_alt = $11  WHERE id = $1 ",
      [ id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_alt, us_alt ]
    );

    await db.query('COMMIT')

    res.status(201).send({
      message: "Entidade alterada com sucesso!",
      body: {
        localizacao: { pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_alt, us_alt }
      },
    });

  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao alterar entidade: " + err.detail });
    await db.query('ROLLBACK');
    return erro;
  }  
};

// ==> Método responsável por excluir uma 'Ação':
exports.deleteEscritorioById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    await db.query(
      "DELETE FROM entidades WHERE id = $1",
      [id]
    );

    res.status(201).send({
      message: "Entidade excluida com sucesso!",
      body: {
        localizacao: { id }
      },
    });
  } catch(err) {
    const erro = res.status(409).send({ message: "Erro ocorrido ao excluir entidade: " + err.detail });
    return erro;
  }  
};

// ==> Método responsável por listar todas as 'Entidades':
exports.listAllEscritorios = async (_, res) => {
  const response = await db.query('SELECT   id,                                ' +
                                  '         nome,                              ' +
                                  '         fantasia,                          ' +
                                  '         logradouro,                        ' +
                                  '         cnpj,                              ' +
                                  '         inscricao_municipal,               ' +
                                  '         numero_nfe,                        ' +
                                  '         cnae,                              ' +
                                  '         numero,                            ' +
                                  '         bairro,                            ' +
                                  '         cidade_ibge,                       ' +
                                  '         uf,                                ' +
                                  '         cep,                               ' +
                                  '         fonefixo,                          ' +
                                  '         fonecel,                           ' +
                                  '         email,                             ' +
                                  '         perc_pis,                          ' +
                                  '         perc_cofins,                       ' +
                                  '         perc_irpj,                         ' +
                                  '         perc_csll,                         ' +
                                  '         perc_iss,                          ' +
                                  '         perc_custo,                        ' +
                                  '         perc_finan,                        ' +
                                  '         perc_inss,                         ' +
                                  '         regime_tributario,                 ' +
                                  '         valor_limite_tributacao,           ' +
                                  '         regime_tributacao_especial,        ' +
                                  '         retem_iss,                         ' +
                                  '         contador_id,                       ' +
                                  '         responsavel_id,                    ' +
                                  '         prefeitura,                        ' +
                                  '         proxy_host,                        ' +
                                  '         proxy_port,                        ' +
                                  '         proxy_user,                        ' +
                                  '         proxy_pass,                        ' +
                                  '         escritorio_host,                   ' +
                                  '         escritorio_port,                   ' +
                                  '         escritorio_user,                   ' +
                                  '         escritorio_pass,                   ' +
                                  '         escritorio_email,                  ' +
                                  '         escritorio_tls,                    ' +
                                  '         escritorio_ssl,                    ' +
                                  '         ssltype,                           ' +
                                  '         ssllib,                            ' +
                                  '         cryptlib,                          ' +
                                  '         httplib,                           ' +
                                  '         xmlsignlib,                        ' +
                                  '         arq_logo_nfe_emissor,              ' +
                                  '         arq_logo_nfe_municipio,            ' +
                                  '         certificado_numero,                ' +
                                  '         certificado_senha,                 ' +
                                  '         certificado_path,                  ' +
                                  '         orientacao_danfe,                  ' +
                                  '         ambiente_nfe,                      ' +
                                  '         versao_emissor_nfe,                ' +
                                  '         observacao_nfe,                    ' +
                                  '         ativo,                             ' +
                                  '         dt_inc,                            ' +
                                  '         dt_alt,                            ' +
                                  '         us_inc,                            ' +
                                  '         us_alt                             ' +
                                  'FROM escritorios                            ' +
                                  'ORDER BY nome ASC                           ' );
  res.status(200).send(response.rows);
};

