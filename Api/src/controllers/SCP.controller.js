import { getConnectionAdmin } from '../ConnectionSqlAdmin';
const createCsvWriter = require('csv-writer').createObjectCsvWriter;

export const CalcularCargasSociales = async (req, res) => {
  const path = require('path');
  const csvWriter = createCsvWriter({
    path: path.join(
      __dirname,
      'InformeCargarSocialesEmpleado' + req.body.id_mes + '.csv'
    ),
    header: [
      { id: 'cedula', title: 'Cedula' },
      { id: 'cargas_sociales_trabajador', title: 'CargasSociales' },
    ],
  });
  
  const pool = await getConnectionAdmin();
  console.log(req.body.id_mes);
  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec CalcularCargasSocialesEmpleado @id_mes');
  csvWriter.writeRecords(result.recordset);
  res.json(result.recordset);
  pool.close();
};

export const CalcularCargasPatronales = async (req, res) => {
  const path = require('path');
  const csvWriter = createCsvWriter({
    path: path.join(
      __dirname,
      'InformeCargarSocialesPatronales' + req.body.id_mes + '.csv'
    ),
    header: [
      { id: 'monto_cs_patronales', title: 'MontoCargarSocialesPatronales' },
    ],
  });
  /* logica a que base entra */
  const pool = await getConnectionAdmin();

  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec CalcularCargasSocialesPatronales @id_mes');
  csvWriter.writeRecords(result.recordset);
  res.json(result.recordset);
  pool.close();
};

export const CalcularImpuestoRenta = async (req, res) => {
  const path = require('path');
  const csvWriter = createCsvWriter({
    path: path.join(
      __dirname,
      'InformeImpuestosRenta' + req.body.id_mes + '.csv'
    ),
    header: [
      { id: 'cedula', title: 'Cedula' },
      { id: 'creditos_familiares', title: 'CreditoFamiliar' },
      { id: 'impuesto_renta', title: 'ImpuestoRenta' },
    ],
  });

  /* logica a que base entra */
  const pool = await getConnectionAdmin();

  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec CalcularImpuestoRentaMesPlanilla @id_mes');
  console.log(result.recordset);
  csvWriter.writeRecords(result.recordset);
  res.json(result.recordset);
  pool.close();
};

export const ObtenerMeses = async (req, res) => {
  /* logica a que base entra */
  const pool = await getConnectionAdmin();

  console.log(req.body.id_mes);
  const result = await pool.request().query('exec ObtenerMesesPlanilla');
  res.json(result.recordset);
  pool.close();
};

export const GenerarCSV = async (req, res) => {
  console.log(req.body.id_mes);
  console.log('Generando CSV');
  const path = require('path');
  const csvWriter = createCsvWriter({
    path: path.join(__dirname, 'Informe' + req.body.id_mes + '.csv'),
    header: [
      { id: 'cedula', title: 'Cedula' },
      { id: 'creditos_familiares', title: 'CreditoFamiliar' },
      { id: 'impuesto_renta', title: 'ImpuestoRenta' },
      { id: 'cargas_sociales_trabajador', title: 'CargasSociales' },
    ],
  });

  let data = [];

  /* Construimos la data */
  const pool = await getConnectionAdmin();
  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec ObtenerImpuestoRentaYCSTrabajador @id_mes');
  data = result.recordset;
  pool.close();

  csvWriter
    .writeRecords(data)
    .then(() => {
      res.json('Archivo CSV creado correctamente');
    })
    .catch((error) => {
      console.error(error);
      res.json('ERROR');
    });
};
