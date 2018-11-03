'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    // hàm tạo và trả về billId vừa được tạo
    createBill: (req, res) => {
        // let data = req.body;
        let sql = 'SET @TableKey=?; \
        CALL `CreateNewBill`(@TableKey);';
        db.query(sql, [req.params.tableKey], (err, rows, response) => {
            if (!err) {
                rows.forEach(element => {
                    if (element.constructor == Array) {
                        res.json(element[0].billId);
                    }
                });
            }
            else throw err;
        })
    },
    addProductsToBillDetail: (req, res) => {
        let sql = 'SET @BillId = ?;SET @ProductId = ?;SET @Quantity = ?;\
            CALL `AddToBillDetail`(@BillId, @ProductId, @Quantity);';
        db.query(sql, [req.params.BillId, req.params.ProductId, req.params.Quantity], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted successfully!' })
        })
    }
}