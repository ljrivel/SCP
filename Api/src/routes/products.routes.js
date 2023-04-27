import {Router} from 'express';


import {getCategorias,getInventory,deleteProduct,getProduct,updateProduct, moreSendProduct,expiredProduct,
     gananciasNetas,PedidosProvedorCR,PedidosProvedorHN,PedidosProvedorGT,
     getProductsCR,getProductsCRF,getCategoriasCR,createProduct,createBuyCR,
     getProductsGT,getProductsGTF,getCategoriasGT,createBuyGT,
     getProductsHN,getProductsHNF,getCategoriasHN,createBuyHN} from '../controllers/products.controller';



const router = Router();

router.post('/getProducts',getProduct);
router.post('/getInventory',getInventory);
router.post('/updateProduct',updateProduct);
router.post('/deleteProduct',deleteProduct);
router.post('/createProduct',createProduct);
router.get('/getCategorias',getCategorias);
router.post('/moreSendProduct',moreSendProduct); 
router.post('/expiredProduct',expiredProduct);
router.post('/ganancias',gananciasNetas);


router.post('/cr/pedidos',PedidosProvedorCR);
router.get('/cr/getProducts',getProductsCR);
router.post('/cr/getProductsF',getProductsCRF);
router.get('/cr/getCategorias',getCategoriasCR);
router.post('/cr/createBuy',createBuyCR); 

router.get('/gt/getProducts',getProductsGT);
router.post('/gt/getProductsF',getProductsGTF);
router.get('/gt/getCategorias',getCategoriasGT);
router.post('/gt/createBuy',createBuyGT); 
router.post('/gt/pedidos',PedidosProvedorGT);


router.get('/hn/getProducts',getProductsHN);
router.post('/hn/getProductsF',getProductsHNF);
router.get('/hn/getCategorias',getCategoriasHN);
router.post('/hn/createBuy',createBuyHN); 
router.post('/hn/pedidos',PedidosProvedorHN);
 
export default router;