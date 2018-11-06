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
}
