import {Router} from 'express';


import { createUser,loginUser,getPuestos,deleteEmployee,clientesFrecuentes,getUsersCR,bonoRecibidos,
    createEmployeeCR,getEmployeesCR,updateEmployeeCR,filterEmployeesCR,bonoEmployeeCR,
    getUsersGT,createEmployeeGT,getEmployeesGT,updateEmployeeGT,filterEmployeesGT,bonoEmployeeGT,
    getUsersHN,createEmployeeHN,getEmployeesHN,updateEmployeeHN,filterEmployeesHN,bonoEmployeeHN } from '../controllers/users.controller';



const router = Router();


router.get('/getPuestos',getPuestos);
router.post('/register',createUser);
router.post('/login',loginUser);
router.post('/deleteEmployee',deleteEmployee);
router.post('/clienteFrecuentes',clientesFrecuentes);
router.post('/bonosRecibidos',bonoRecibidos);

 


router.get('/cr/getUsers',getUsersCR);
router.get('/cr/getEmployees',getEmployeesCR);
router.post('/cr/createEmployee',createEmployeeCR);
router.post('/cr/updateEmployee',updateEmployeeCR);
router.post('/cr/filterEmployee',filterEmployeesCR);
router.post('/cr/bonoEmployee',bonoEmployeeCR);


router.get('/gt/getUsers',getUsersGT);
router.get('/gt/getEmployees',getEmployeesGT);
router.post('/gt/createEmployee',createEmployeeGT);
router.post('/gt/updateEmployee',updateEmployeeGT);
router.post('/gt/filterEmployee',filterEmployeesGT);
router.post('/gt/bonoEmployee',bonoEmployeeGT);

router.get('/hn/getUsers',getUsersHN);
router.get('/hn/getEmployees',getEmployeesHN);
router.post('/hn/createEmployee',createEmployeeHN);
router.post('/hn/updateEmployee',updateEmployeeHN);
router.post('/hn/filterEmployee',filterEmployeesHN);
router.post('/hn/bonoEmployee',bonoEmployeeHN);





export default router;