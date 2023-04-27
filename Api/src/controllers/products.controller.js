import { getConnectionAdmin } from '../ConnectionSqlAdmin';

export const getInventory = async (req, res) => {
  const pool = await getConnectionAdmin();

  const result = await pool
    .request()
    .input('id_pais', req.body.id_pais)
    .input('id_sucursal', req.body.id_sucursal)
    .input('id_producto', req.body.id_producto)
    .input('activo', req.body.activo)
    .query(
      'exec sp_get_inventarios @id_pais,@id_sucursal,@id_producto,@activo'
    );
  res.json(result.recordset);
  pool.close();
};

export const getCategorias = async (req, res) => {
  /* logica a que base entra */
  const pool = await getConnectionAdmin();

  const result = await pool.request().query('exec get_categories');

  res.json(result.recordset);
  pool.close();
};
