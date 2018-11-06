'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('../db')

module.exports = {
    getRoleAndStoreId: (req, res) => {
        let sql = 'SET @UserName = ? ;SET @Password = ?;\
        CALL `getRoleAndStoreId`(@UserName, @Password);';

        db.query(sql, [req.params.Username, req.params.Password], (err, response) => {
            if (err) throw err
            res.json(response[2])
        })
    },

    getAllUser: (req, res) => {
        let sql = 'Select u.Id,u.UserName,u.Fullname,u.Address,u.StoreId,u.RoleId,u.Password, s.StoreName,r.RoleType\
        from user u, store s,role r\
        where u.StoreId = s.Id and r.Id = u.RoleId and u.IsDeleted = 0';
        db.query(sql, (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },

    addUser: (req, res) => {
        var un = req.params.Username;
        var dn = req.params.FullName;
        var add = req.params.Address;
        var sId = req.params.StoreId;
        var rId = req.params.RoleId;
        var pass = req.params.Password;

        let sql = ' SET @UserName = ? ;\
                    SET @Fullname = ?;\
                    SET @Address = ?;\
                    SET @StoreId = ?;\
                    SET @RoleId = ?;\
                    SET @Password = ?;\
        CALL `addUser`(@UserName ,@Fullname ,@Address ,@StoreId ,@RoleId,@Password)';
        db.query(sql, [un, dn, add, sId, rId, pass], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted success ' })
        })
    },
    removeUser: (req, res) => {
        let sql = 'UPDATE `fastorder`.`user` SET\
            `IsDeleted` = 1\
            WHERE `Id` = ?;'
        db.query(sql, [req.params.userId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Remove user successfully!' })
        })
    },
    updateUser: (req, res) => {
        var fn = req.params.fullName;
        var add = req.params.address;
        var uId = req.params.userId;
        let sql = 'UPDATE `fastorder`.`user`SET\
                `Fullname` = ?,\
                `Address` = ?\
            WHERE `Id` = ?;';
        db.query(sql, [fn,
            add,
            uId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Update user successfully!' })
        })
    }    
};