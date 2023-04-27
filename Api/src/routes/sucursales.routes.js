import {Router} from 'express';


import {deleteBranchCR,getSedesCR,createBranchCR,editBranchCR,
    deleteBranchGT,getSedesGT,createBranchGT,editBranchGT,
    deleteBranchHN,getSedesHN,createBranchHN,editBranchHN   } from '../controllers/sucursales.controller';


 
const router = Router();

router.post('/cr/deleteSucursal',deleteBranchCR );
router.get('/cr/getSedes',getSedesCR);
router.post('/cr/createSucursal',createBranchCR);  
router.post('/cr/editSucursal',editBranchCR);  


router.post('/gt/deleteSucursal',deleteBranchGT );
router.get('/gt/getSedes',getSedesGT);
router.post('/gt/createSucursal',createBranchGT);  
router.post('/gt/editSucursal',editBranchGT);  


router.post('/hn/deleteSucursal',deleteBranchHN );
router.get('/hn/getSedes',getSedesHN);
router.post('/hn/createSucursal',createBranchHN);  
router.post('/hn/editSucursal',editBranchHN);  


export default router; 