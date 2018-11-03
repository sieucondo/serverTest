'use strict';
module.exports = function (app) {
  let productsCtrl = require('./controller/ProductsController');
  let wifiCtrl = require('./controller/WifiController');


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

  app.route('/wifi/:tableKey')
    .get(wifiCtrl.getWifi);
  
  app.route('/products-all/:tableKey')  
    .get(productsCtrl.getAllProduct);
};