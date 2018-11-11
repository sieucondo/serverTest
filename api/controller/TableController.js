'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getAllTableKey: (req, res) => {
        let sql = 'SET  @TableKey   =?;\
        CALL `fastorder`.`GetAllTableKey`(@TableKey);';
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json(response[1])
        })
    },
    // nhập tableKey lấy ra status
    getTableStatus: (req, res) => {
        let sql = 'SET @TableKey    =?;\
        CALL `fastorder`.`GetTableStatus`(@TableKey);';
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json({ IsAvailable: response[1][0].IsAvailable })
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
        var StoreId = req.params.StoreId;
        var TableKey = req.params.TableKey;
        var TableName = req.params.TableName;

        let sql = ' SET @StoreId    = ?;\
                    SET @TableKey   = ?;\
                    SET @TableName  = ?;\
        CALL `AddNewTable`(@StoreId, @TableKey, @TableName);';
        db.query(sql, [
            StoreId,
            TableKey,
            TableName], (err, response) => {
                if (err) throw err
                res.json({ message: 'Inserted successfully!' })
            })
    },
    updateTable: (req, res) => {
        var tn = req.params.tableName;
        var tId = req.params.tableId;
        var IsAvailable = req.params.IsAvailable
        let sql = ' SET @TableId        = ?;\
                    SET @TableName      = ?;\
                    SET @IsAvailable    = ?;\
        CALL `fastorder`.`UpdateTable`(@TableId, @TableName, @IsAvailable);';
        db.query(sql, [tId,tn.toString(), parseInt(IsAvailable)], (err, response) => {
            if (err) throw err
            res.json({ message: 'Update table successfully!' })
        })
    }
}