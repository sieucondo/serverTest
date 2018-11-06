'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getAllStore: (req, res) => {
        let sql = 'SELECT `Id`, `StoreKey`, `Location`,`StoreName`,`PhoneNumber`,\
        `Province`,`UserId`,\
        CASE WHEN IsDeleted = 0 THEN FALSE ELSE TRUE END AS IsDeleted\
        FROM `store` WHERE IsDeleted=0'
        db.query(sql, (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
    addNewStore: (req, res) => {
        var sn = req.params.StoreName;
        var pn = req.params.PhoneNumber;
        var locale = req.params.Location;
        var province = req.params.Province;

        let sql = ' SET      @StoreName     = ?;\
                    SET      @PhoneNumber   = ?;\
                    SET      @Location      = ?;\
                    SET      @Province      = ?;\
        CALL `fastorder`.`AddNewStore`(@StoreName, @PhoneNumber, @Location, @Province);';
        db.query(sql, [
            sn,
            pn,
            locale,
            province
        ], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted successfully!' })
        })
    },
    removeStore: (req, res) => {
        let sql = 'UPDATE `fastorder`.`store` SET\
            `IsDeleted` = 1\
            WHERE `Id` = ?;'
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Remove user successfully!' })
        })
    },
    updateStore: (req, res) => {
        var location = req.params.location;
        var pn = req.params.phoneNumber;
        var sn = req.params.storeName;
        var province = req.params.province;
        var sId = req.params.storeId;
        let sql = 'UPDATE `fastorder`.`store`SET\
                `Location` = ?,\
                `StoreName` = ?,\
                `PhoneNumber` = ?,\
                `Province` = ?\
            WHERE `Id` = ?;';
        db.query(sql, [location, pn, sn, province, sId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Update user successfully!' })
        })
    }   
}