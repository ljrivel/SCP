import sql from 'mssql';

const sqlConfig = {
  user: 'General',
  password: '12345',
  server: 'localhost',
  database: 'SCP',
  trustServerCertificate: true,
};

export async function getConnectionAdmin() {
  try {
    const pool = await sql.connect(sqlConfig);
    return pool;
  } catch {
    console.log('Error al conectar a la base de datos');
  }
}
