const express = require('express');
const router = express.Router();
const  productController = require('../controllers/products.controller');
const  categoryController = require('../controllers/category.controller');
const  inventaireController = require('../controllers/inventaire.controller');

router.get('/product', productController.getAll);
router.post('/product', productController.create);
router.get('/product/:id', productController.getById);
router.put('/product/:id', productController.update);
router.delete('/product/:id', productController.delete);

router.get('/category', categoryController.getAll);
router.post('/category', categoryController.create);
router.get('/category/:id', categoryController.getById);
router.put('/category/:id', categoryController.update);
router.delete('/category/:id', categoryController.delete);

router.get('/inventaire', inventaireController.getAll);
router.post('/inventaire', inventaireController.create);
router.get('/inventaire/:id', inventaireController.getById);
router.put('/inventaire/:id', inventaireController.update);
router.delete('/inventaire/:id', inventaireController.delete);

module.exports = router;