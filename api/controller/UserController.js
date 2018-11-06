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
            res.json(response[2])
        })
    },

    getAllUser: (req, res) => {
        let sql = 'SELECT * FROM fastorder.user u , store s\
        where u.StoreId = s.Id';
        db.query(sql, (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },

    getAllUserById: (req, res) => {
        let sql = 'SELECT * FROM fastorder.user u where u.Id = ?';
        db.query(sql,[req.params.userId], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },

    addUser :(req, res) => {
        let sql = 'SET @UserName = ? ;SET @Fullname = ?;SET @Address = ?;SET @StoreId = ?;SET @RoleId = ?;SET @Password = ?;\
        CALL `addUser`(@UserName ,@Fullname ,@Address ,@StoreId ,@RoleId,@Password)';
        db.query(sql,[req.params.Username,req.params.FullName,
            req.params.Address,req.params.StoreId,req.params.RoleId,req.params.Password], (err, response) => {
            if (err) throw err
            res.send({ message: 'Delete success!' })
        })
    },
};