'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getAllStore: (req, res) => {
<<<<<<< HEAD
        let sql = 'SELECT * FROM fastorder.store;'
        db.query(sql,(err, response) => {
            if (err) throw err
            res.json(response)
        })
    }
};
=======
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
>>>>>>> 8a39d66ec6e15d9b14b553ecee6e133314fafa95
