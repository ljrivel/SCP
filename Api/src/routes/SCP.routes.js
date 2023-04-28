import { Router } from 'express';

import {
  CalcularCargasSociales,
  CalcularCargasPatronales,
  CalcularImpuestoRenta,
} from '../controllers/SCP.controller';

const router = Router();

router.get('/CCS', CalcularCargasSociales);
router.post('/CCP', CalcularCargasPatronales);
router.post('/CIR', CalcularImpuestoRenta);

export default router;
