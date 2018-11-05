'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('../db')

module.exports = {
    getRoleAndStoreId: (req, res) => {
        let sql = 'SET @UserName = ? ;SET @Password = ?;\
        CALL `getRoleAndStoreId`(@UserName, @Password);';
        db.query(sql, [req.params.Username ,req.params.Password], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },

    getAllUser: (req, res) => {
        let sql = 'Select Id,UserName,Fullname,Address,Dob,StoreId,RoleId,Password\
        from user';
        db.query(sql, (err, response) => {
            if (err) throw err
            res.json(response[2])
        })
    }
};