const express = require('express');

// App
const cors = require('cors');
const app = express();

const corsOptions = {
  origin: '*',
  optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
}

app.use(cors(corsOptions));

// ==> Rotas da API:
const index = require('./routes/index');
const userRoute = require('./routes/user.routes');
const ufRoute = require('./routes/uf.routes');
const municipiosRoute = require('./routes/municipio.routes');
const cnaeRoute = require('./routes/cnae.routes');
const gruposEmpresariais = require('./routes/grupo-empresarial.routes');
const acoes = require('./routes/acao.routes');
const localizacoes = require('./routes/localizacao.routes');
const servicos = require('./routes/servicos.routes');
const etapasProcessuais = require('./routes/etapas-processuais.routes');
const orgaosCompetentes = require('./routes/orgaos-competentes.routes');
const tipoOcorrencias = require('./routes/tipos-ocorrencias.routes');
const entidades = require('./routes/entidade.routes');
const tipoPessoas = require('./routes/tipos-pessoas.routes');
const oabs = require('./routes/entidade-oabs.routes');
const emails = require('./routes/entidade-emails.routes');
const estagiarios = require('./routes/entidade-estagiarios.routes');
const enderecos = require('./routes/entidade-enderecos.routes');
const parceiros = require('./routes/entidade-parceiros.routes');
const leads = require('./routes/lead.routes');
const escritorios = require('./routes/escritorio.routes');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.json({ type: 'application/vnd.api+json' }));
// Load routes
app.use(index);
app.use('/', userRoute);
app.use('/', ufRoute);
app.use('/', municipiosRoute);
app.use('/', cnaeRoute);
app.use('/', gruposEmpresariais);
app.use('/', acoes);
app.use('/', localizacoes);
app.use('/', servicos);
app.use('/', etapasProcessuais);
app.use('/', orgaosCompetentes);
app.use('/', tipoOcorrencias);
app.use('/', entidades);
app.use('/', tipoPessoas);
app.use('/', oabs);
app.use('/', emails);
app.use('/', estagiarios);
app.use('/', enderecos);
app.use('/', parceiros);
app.use('/', leads);
app.use('/', escritorios);

module.exports = app;