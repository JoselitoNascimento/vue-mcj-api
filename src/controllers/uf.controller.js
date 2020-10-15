const axios = require('axios');
// ==> Método responsável por listar os 'Estados':
exports.listUFs = async (req, res) => {
  const { uf } = req.body;
  const http = axios.create({
    baseURL: 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/' + (uf == undefined ? '' : uf)
  });
  const response = await http.get();
  res.status(200).send(response.data) ;
};