import { Router } from 'express';

import {
  CalcularCargasSociales,
  CalcularCargasPatronales,
  CalcularImpuestoRenta,
  ObtenerMeses,
} from '../controllers/SCP.controller';

const router = Router();

router.post('/CCS', CalcularCargasSociales);
router.post('/CCP', CalcularCargasPatronales);
router.post('/CIR', CalcularImpuestoRenta);
router.get('/Meses', ObtenerMeses);

export default router;
