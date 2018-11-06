'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getProductById: (req, res) => {
        let sql = 'SELECT `products`.`Id`,\
            `StoreId`,\
            `ImageId`,\
            `ProductName`,\
            `ProductPrice`,\
            `TypeId`,\
            CASE WHEN IsAvailable = 0 THEN FALSE ELSE TRUE END AS IsAvailable\
            FROM `products`\
            WHERE Id = ? AND IsDeleted = 0 AND IsAvailable = 1'
        db.query(sql, [req.params.productId], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
    // lấy ra categories nhà hàng theo tableKey
    detail: (req, res) => {
        let sql = 'SELECT ty.Id , ty.Type\
            FROM\
                `table` t\
                JOIN store s ON t.storeid = s.id\
                JOIN products p ON s.id = p.storeid\
                JOIN `type` ty ON ty.id = p.typeid\
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
                    ty.Id AS TypeId,\
                    p.ProductName,\
                    ty.`Type`,\
                    t.TableName,\
                    s.StoreName,\
                    p.ProductPrice\
            FROM\
                `table` t\
            JOIN store s ON t.storeid = s.id\
            JOIN products p ON s.id = p.storeid\
            JOIN `type` ty ON ty.id = p.typeid\
            WHERE\
                    t.tablekey = ? AND p.IsDeleted = 0 AND p.IsAvailable = 1) a\
        WHERE\
            a.TypeId LIKE "%"?"%"';
        let tableKey = req.params.tableKey;
        let typeId = req.params.typeId;
        if (typeId == 0) {
            typeId = ""
        }
        db.query(sql, [tableKey, typeId], (err, response) => {
            if (err) throw err
            res.json(response)
        });
    },
    //lấy tất cả đồ ăn đồ uống trong quán
    getAllProduct: (req, res) => {
        let sql = 'SELECT \
                p.id,\
                ty.Id AS TypeId,\
                p.ProductName,\
                ty.`Type`,\
                t.TableName,\
                s.StoreName,\
                p.ProductPrice\
            FROM\
                `table` t\
            JOIN store s ON t.storeid = s.id\
            JOIN products p ON s.id = p.storeid\
            JOIN `type` ty ON ty.id = p.typeid\
            WHERE\
                t.tablekey = ? AND p.IsDeleted = 0';
        let tableKey = req.params.tableKey;

        db.query(sql, [tableKey], (err, response) => {
            if (err) throw err
            res.json(response)
        })
    },
    getProductsByStoreId: (req, res) => {
        let sql = 'SET @StoreId = ?;\
        CALL`fastorder`.`GetProductByStoreId`(@StoreId);';
        db.query(sql, [req.params.storeId], (err, response) => {
            if (err) throw err
            res.json(response[1]);
        })
    },
    // Thêm products mới vô db
    insertProductsByStoreId: (req, res) => {
        var storeId = req.body[0].StoreId.toString();
        var img = req.body[0].ImgUrl.toString();
        var name = req.body[0].ProductName.toString();
        var price = req.body[0].ProductPrice.toString();
        var typeId = req.body[0].TypeId.toString();
        console.log('asdsad : ', req.body[0].ImgUrl.toString());

        let sql = 'SET      @StoreId        = ?;\
                   SET      @ImgUrl         = ?;\
                   SET      @ProductName    = ?;\
                   SET      @ProductPrice   = ?;\
                   SET      @TypeId       = ?;\
        CALL `fastorder`.`AddNewProduct`(@StoreId,@ImgUrl,@ProductName,@ProductPrice,@TypeId)';
        db.query(sql, [
            storeId,
            img,
            name,
            price,
            typeId
        ], (err, response) => {
            if (err) throw err
            console.log(JSON.stringify(req.body.ImgUrl))
            res.json({ message: 'Inserted successfully!' })
        })
    },
    //UpdateProduct đã có
    updateProductsByStoreId: (req, res) => {
        var productId = req.body[0].ProductId.toString();
        var img = req.body[0].ImgUrl.toString();
        var name = req.body[0].ProductName.toString();
        var price = req.body[0].ProductPrice.toString();
        var isAvailable = req.body[0].IsAvailable.toString();
        console.log('asdsad : ', req.body[0].ImgUrl.toString());

        let sql = 'SET      @ProductId        = ?;\
                   SET      @ImgUrl         = ?;\
                   SET      @ProductName    = ?;\
                   SET      @ProductPrice   = ?;\
                   SET      @IsAvailable       = ?;\
        CALL `fastorder`.`UpdateProduct`(@ProductId, @ImgUrl, @ProductName, @ProductPrice, @IsAvailable);\
                   ';
        db.query(sql, [
            productId,
            img,
            name,
            price,
            isAvailable
        ], (err, response) => {
            if (err) throw err
            console.log(JSON.stringify(req.body.ImgUrl))
            res.json({ message: 'Update successfully!' })
        })
    },
    // delete product - chuyển IsDelete = 0
    removeProduct: (req, res) => {
        let sql = 'UPDATE `fastorder`.`products`\
            SET\
            `IsDeleted` = 1\
            WHERE `Id` = ?;'
        db.query(sql, [req.params.productId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Remove successfully!' })
        })
    }
};