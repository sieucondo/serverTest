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
        let sql = 'SELECT \
            b.Id,\
            b.TableId,\
            t.TableName,\
            b.DateCreate,\
            (SELECT \
                    SUM(price) AS Total FROM billdetail bd\
                WHERE bd.billid = b.Id) AS Total\
        FROM\
            fastorder.bill b\
            JOIN `table` t ON t.Id = b.TableId\
            JOIN store s ON s.Id = t.StoreId\
        WHERE\
            s.Id = ?;';
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json(response);
        })
    },
}