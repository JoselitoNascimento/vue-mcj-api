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

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.json({ type: 'application/vnd.api+json' }));

// Load routes
app.use(index);
app.use('/', userRoute);
app.use('/', ufRoute);
app.use('/', municipiosRoute);
app.use('/', cnaeRoute);

module.exports = app;