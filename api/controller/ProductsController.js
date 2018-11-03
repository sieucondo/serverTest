'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    get: (req, res) => {
        let sql = 'SELECT * FROM `products`'
        db.query(sql, (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
    // lấy ra categories nhà hàng theo tableKey
    detail: (req, res) => {
        let sql = 'SELECT ty.Id , ty.Type\
            FROM\
                `table` t\
                JOIN\
                store s ON t.storeid = s.id\
                JOIN\
                products p ON s.id = p.storeid\
                JOIN\
                category c ON c.id = p.category\
                JOIN\
                `type` ty ON ty.id = c.typeId\
            WHERE\
                t.tablekey = ?\
            GROUP BY ty.Id;'
        db.query(sql, [req.params.tableKey], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
    update: (req, res) => {
        let data = req.body;
        let productId = req.params.productId;
        let sql = 'UPDATE products SET ? WHERE id = ?'
        db.query(sql, [data, productId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Update success!' })
        })
    },
    store: (req, res) => {
        let data = req.body;
        let sql = 'INSERT INTO products SET ?'
        db.query(sql, [data], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted successfully!' })
        })
    },
    delete: (req, res) => {
        let sql = 'DELETE FROM products WHERE id = ?'
        db.query(sql, [req.params.productId], (err, response) => {
            if (err) throw err
            res.send({ message: 'Delete success!' })
        })
    },
    // lấy menu theo tableKey và Type
    getProductByType: (req, res) => {
        let sql = 'SELECT *\
                FROM\
                    (SELECT \
                        p.id,\
                            c.TypeId,\
                            p.ProductName,\
                            c.`Description`,\
                            ty.`Type`,\
                            t.TableName,\
                            s.StoreName,\
                            p.ProductPrice\
                    FROM\
                        `table` t\
                    JOIN store s ON t.storeid = s.id\
                    JOIN products p ON s.id = p.storeid\
                    JOIN category c ON c.id = p.category\
                    JOIN `type` ty ON ty.id = c.typeId\
                    WHERE\
                        t.tablekey = ?) a\
                WHERE\
                    a.TypeId = ?';

        let sql1 = 'SELECT \
                    p.id,\
                    c.TypeId,\
                    p.ProductName,\
                    c.`Description`,\
                    ty.`Type`,\
                    t.TableName,\
                    s.StoreName,\
                    p.ProductPrice\
                FROM\
                    `table` t\
                JOIN store s ON t.storeid = s.id\
                JOIN products p ON s.id = p.storeid\
                JOIN category c ON c.id = p.category\
                JOIN `type` ty ON ty.id = c.typeId\
                WHERE\
                    t.tablekey = ?';

        let tableKey = req.params.tableKey;
        let typeId = req.params.typeId;
        console.log(typeId)

        if((typeId == 1)||(typeId)==2){
            db.query(sql, [tableKey, typeId], (err, response) => {
                if (err) throw err
                res.json(response)
            });
        }else{
            db.query(sql1, [tableKey], (err, response) => {
                if (err) throw err
                res.json(response)
            });
        }

      
    },
    //lấy tất cả đồ ăn đồ uống trong quán
    getAllProduct: (req, res) => {
        let sql = 'SELECT \
                p.id,\
                c.TypeId,\
                p.ProductName,\
                c.`Description`,\
                ty.`Type`,\
                t.TableName,\
                s.StoreName,\
                p.ProductPrice\
            FROM\
                `table` t\
            JOIN store s ON t.storeid = s.id\
            JOIN products p ON s.id = p.storeid\
            JOIN category c ON c.id = p.category\
            JOIN `type` ty ON ty.id = c.typeId\
            WHERE\
                t.tablekey = ?';
        let tableKey = req.params.tableKey;

        db.query(sql, [tableKey], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
}