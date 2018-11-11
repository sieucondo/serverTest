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
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    addProductsToBillDetail: (req, res) => {
        let sql = 'SET @BillId = ?;SET @ProductId = ?;SET @Quantity = ?;\
            CALL `AddToBillDetail`(@BillId, @ProductId, @Quantity);';
        db.query(sql, [req.params.BillId, req.params.ProductId, req.params.Quantity], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted successfully!' })
        })
    },
    // hàm trả về thông tin bill qua storeId
    getBillByStoreId: (req, res) => {
        let sql = 'SET  @StoreId    =   ?;\
        CALL `fastorder`.`GetBillByStoreId`(@StoreId);';
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    getBillDetailByBillId: (req, res) => {
        let sql = 'SET  @Id    =   ?;\
        CALL `fastorder`.`GetBillDetailById`(@Id);';
        db.query(sql, [req.params.Id], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    getBillByBillId: (req, res) => {
        let sql = 'SET  @Id    =   ?;\
        CALL `fastorder`.`GetBillById`(@Id);';
        db.query(sql, [req.params.Id], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
}