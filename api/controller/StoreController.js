'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getAllStore: (req, res) => {
        let sql = 'SELECT * FROM fastorder.store;'
        db.query(sql,(err, response) => {
            if (err) throw err
            res.json(response)
        })
    }
};