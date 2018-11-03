'use strict';
module.exports = function(app) {
  let productsCtrl = require('./controller/ProductsController');
  let wifiCtrl = require('./controller/WifiController');


  // todoList Routes
  app.route('/products')
    .get(productsCtrl.get)
    .post(productsCtrl.store);

  app.route('/products/:productId')
    .get(productsCtrl.detail)
    .put(productsCtrl.update)
    .delete(productsCtrl.delete);

    app.route('/products2/:tableKey&:typeId')
    .get(productsCtrl.getProductByType);

  app.route('/table/:tableKey')
    .get(wifiCtrl.getWifi);
  
  app.route('/products/:tableKey')  
    .get(productsCtrl.getAllProduct);
};