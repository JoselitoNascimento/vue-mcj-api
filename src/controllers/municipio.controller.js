const axios = require('axios');
// ==> Método responsável por listar os 'Estados':
exports.listMunicipios = async (req, res) => {
  const { municipio } = req.body;
  const http = axios.create({
    baseURL: 'https://servicodados.ibge.gov.br/api/v1/localidades/municipios/' + (municipio == undefined ? '' : municipio)
  });
  const response = await http.get();
  res.status(200).send(response.data) ;
};
