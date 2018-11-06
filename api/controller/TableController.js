'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getAllTableKey: (req, res) => {
        let sql = 'SELECT t.Id AS TableId, s.Id AS StoreId, t.TableKey, t.TableName, s.StoreName\
            FROM `table` t\
            JOIN store s ON s.Id = t.StoreId\
            WHERE t.TableKey = ?\
            ;'
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
    // nhập tableKey lấy ra status
    getTableStatus: (req, res) => {
        let sql = 'SELECT t.IsAvailable\
            FROM `table` t\
            WHERE t.TableKey = ?\
            ;'
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json({IsAvailable: response[0].IsAvailable[0]})
        })
    },
    // lấy table theo id quán
    getTablesByStoreID: (req, res) => {
        let sql = 'SET      @StoreId      = ?;\
        CALL `fastorder`.`TableGetTableByStoreId`(@StoreId);\
                   ';
        db.query(sql, [req.params.storeID], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    }
}