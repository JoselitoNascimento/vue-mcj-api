const express = require('express');
const cors = require('cors');

// App
const app = express();

// ==> Rotas da API:
const index = require('./routes/index');
const userRoute = require('./routes/user.routes');

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.json({ type: 'application/vnd.api+json' }));
app.use(cors());

// Load routes
app.use(index);
app.use('/', userRoute);

module.exports = app;