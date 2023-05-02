import { Router } from 'express';

import {
  CalcularCargasSociales,
  CalcularCargasPatronales,
  CalcularImpuestoRenta,
  ObtenerMeses,
  GenerarCSV,
} from '../controllers/SCP.controller';

const router = Router();

router.post('/CCS', CalcularCargasSociales);
router.post('/CCP', CalcularCargasPatronales);
router.post('/CIR', CalcularImpuestoRenta);
router.get('/Meses', ObtenerMeses);
router.post('/GenerarCSV', GenerarCSV);

export default router;
