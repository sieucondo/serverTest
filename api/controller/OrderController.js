'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('../db')

module.exports = {
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
    }
}