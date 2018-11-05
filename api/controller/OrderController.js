'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getOrderByStoreId: (req, res) => {
        let sql = 'SET @StoreId = ?;\
        CALL `GetOrderByStoreId`(@StoreId);';
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    }
}