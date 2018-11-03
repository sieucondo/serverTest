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

  app.route('/products2/:tableKey&:typeId')
    .get(productsCtrl.getProductByType);

  app.route('/table/:tableKey')
    .get(wifiCtrl.getWifi);
<<<<<<< HEAD
  
  app.route('/products/:tableKey')  
    .get(productsCtrl.getAllProduct);
=======
    
>>>>>>> 736a79586c5556a975b18866c29a3baaf36bd2ca
};