import { getConnectionAdmin } from '../ConnectionSqlAdmin';

export const CalcularCargasSociales = async (req, res) => {
  const pool = await getConnectionAdmin();

  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec CalcularCargasSocialesEmpleado @id_mes');
  res.json(result.recordset);
  pool.close();
};

export const CalcularCargasPatronales = async (req, res) => {
  /* logica a que base entra */
  const pool = await getConnectionAdmin();

  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec CalcularCargasSocialesPatronales @id_mes');
  res.json(result.recordset);
  pool.close();
};

export const CalcularImpuestoRenta = async (req, res) => {
  /* logica a que base entra */
  const pool = await getConnectionAdmin();

  const result = await pool
    .request()
    .input('id_mes', req.body.id_mes)
    .query('exec CalcularImpuestoRentaMesPlanilla @id_mes');
  res.json(result.recordset);
  pool.close();
};
