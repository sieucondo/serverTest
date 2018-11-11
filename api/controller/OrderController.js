'use strict'

const util = require('util')
const mysql = require('mysql')

const db = require('./../db')

module.exports = {
    // hàm tạo và trả về billId vừa được tạo
    getOrderByStoreId: (req, res) => {
        let sql = 'SET @StoreId = ?;\
        CALL `GetOrderByStoreId`(@StoreId);';
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    // hàm tạo và trả về billId vừa được tạo
    createOrder: (req, res) => {
        // let data = req.body;
        let sql = 'SET @TableKey=?; \
        CALL `CreateNewOrder`(@TableKey);';
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    addProductsToOrderDetail: (req, res) => {
        let sql = 'SET @OrderId = ?;SET @ProductId = ?;SET @Quantity = ?;\
            CALL `AddToOrderDetail`(@OrderId, @ProductId, @Quantity);';
        db.query(sql, [req.params.OrderId, req.params.ProductId, req.params.Quantity], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted successfully!' })
        })

    },
    getOrderDetailByStoreId: (req, res) => {
        let sql = 'SET @StoreId = ?;\
        CALL `fastorder`.`GetOrderDetailByStoreId`(@StoreId);';
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    getOrderDetailByOrderId: (req, res) => {
        let sql ='SET   @OrderId    =   ?;\
        CALL `fastorder`.`GetOrderDetailByOrderId`(@OrderId);';
        db.query(sql, [req.params.orderId], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    }
}