'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getInfor: (req, res) => {
        let sql = 'SELECT w.Name, w.Password, s.StoreName\
        FROM fastorder.store s, fastorder.table t, wifi w\
        where TableKey like ? and  s.Id = t.StoreId and s.Id = w.StoreId; '
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    }
};