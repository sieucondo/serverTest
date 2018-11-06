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
            res.json({ IsAvailable: response[0].IsAvailable[0] })
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
    },
    addNewTable: (req, res) => {
        var sId = req.params.StoreId;
        var tk = req.params.TableKey;
        var tn = req.params.TableName;

        let sql = ' SET @StoreId = ?;\
                    SET @TableKey = ?;\
                    SET @TableName = ?;\
        CALL `AddNewTable`(@StoreId, @TableKey, @TableName);';
        db.query(sql, [
            sId,
            tk,
            tn], (err, response) => {
                if (err) throw err
                res.json({ message: 'Inserted successfully!' })
            })
    },
    updateTable: (req, res) => {
        var tn = req.params.tableName;
        var tId = req.params.tableId
        let sql = 'UPDATE `fastorder`.`table`\
            SET `TableName` = ? \
            WHERE `Id` = ?;';
        db.query(sql, [tn.toString(), tId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Update table successfully!' })
        })
    }
}