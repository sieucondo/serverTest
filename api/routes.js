'use strict';
module.exports = function (app) {
  let productsCtrl = require('./controller/ProductsController');
  let tableCtrl = require('./controller/TableController');
  let billCtrl = require('./controller/BillController');
  let orderCtrl = require('./controller/OrderController');
  let userCtrl = require('./controller/UserController');

  // todoList Routes
  app.route('/products')
    .get(productsCtrl.get)
    .post(productsCtrl.store);

  app.route('/products/:tableKey')
    .get(productsCtrl.detail)
    .put(productsCtrl.update)
    .delete(productsCtrl.delete);

  app.route('/products-type/:tableKey&:typeId')
    .get(productsCtrl.getProductByType);
    
  app.route('/products-all/:tableKey')
    .get(productsCtrl.getAllProduct);

  app.route('/table/:tableKey')
    .get(tableCtrl.getAllTableKey);

  app.route('/bill/:tableKey')
    .get(billCtrl.createBill);

  app.route('/bills/:BillId&:ProductId&:Quantity')
    .post(billCtrl.addProductsToBillDetail);

  app.route('/table-status/:tableKey')
    .get(tableCtrl.getTableStatus);

  app.route('/order/:storeId')
    .get(orderCtrl.getOrderByStoreId);

  app.route('/user/:Username&:Password')
    .get(userCtrl.getRoleAndStoreId);

  app.route('/products-store/:storeId')
    .get(productsCtrl.getProductsByStoreId);

  app.route('/createorder/:tableKey')
    .get(orderCtrl.createOrder);

  app.route('/createorderdetail/:OrderId&:ProductId&:Quantity')
    .post(orderCtrl.addProductsToOrderDetail);


  app.route('/addproduct/:StoreId&:ImgUrl&:ProductName&:ProductPrice&:TypeId')
    .post(productsCtrl.insertProductsByStoreId);

  app.route('/table-status/:storeID')
    .get(tableCtrl.getAllTableKey);


};