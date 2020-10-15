const axios = require('axios');
// ==> Método responsável por listar os 'Estados':
exports.listCNAEs = async (req, res) => {
  const { cnae } = req.body;
  const http = axios.create({
    baseURL: 'https://servicodados.ibge.gov.br/api/v2/cnae/classes/' + (cnae == undefined ? '' : cnae)
  });
  const response = await http.get();
  res.status(200).send(response.data) ;
};