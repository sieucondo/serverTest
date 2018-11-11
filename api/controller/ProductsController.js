'use strict'

const util = require('util')
const mysql = require('mysql')
const db = require('./../db')

module.exports = {
    getProductById: (req, res) => {
        let sql = 'SET @ProductId = ?;\
        CALL `fastorder`.`GetProductById`(@ProductId);';
        db.query(sql, [req.params.productId], (err, response) => {
            if (err) throw err
            res.json(response[1])
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
        let sql = ' SET @Tablekey = ?;\
                    SET @TypeId = ?;\
        CALL `fastorder`.`GetProductByType`(@Tablekey, @TypeId);';
        let tableKey = req.params.tableKey;
        let typeId = req.params.typeId;
        if (typeId == 0) {
            typeId = ""
        }
        db.query(sql, [tableKey, typeId.toString()], (err, response) => {
            if (err) throw err
            res.json(response[2])
        });
    },
    //lấy tất cả đồ ăn đồ uống trong quán
    getAllProduct: (req, res) => {
        let sql = 'SET  @Tablekey = ?;\
        CALL `fastorder`.`GetAllProduct`(@Tablekey);';
        let tableKey = req.params.tableKey;

        db.query(sql, [tableKey], (err, response) => {
            if (err) throw err
            res.json(response[1])
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
        let sql = 'SET      @StoreId        = ?;\
                   SET      @ImgUrl         = ?;\
                   SET      @ProductName    = ?;\
                   SET      @ProductPrice   = ?;\
                   SET      @TypeId         = ?;\
                   \
        CALL `fastorder`.`AddNewProduct`(\
            @StoreId\
            ,@ImgUrl\
            ,@ProductName\
            ,@ProductPrice\
            ,@TypeId)';
        db.query(sql, [
            req.params.StoreId,
            req.params.ImgUrl,
            req.params.ProductName,
            req.params.ProductPrice,
            req.params.TypeId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Inserted successfully!' })
        })
    },
    //UpdateProduct đã có
    updateProductsByStoreId: (req, res) => {

        let sql = 'SET      @ProductId      = ?;\
                   SET      @ImgUrl         = ?;\
                   SET      @ProductName    = ?;\
                   SET      @ProductPrice   = ?;\
                   SET      @IsAvailable    = ?;\
                   SET      @TypeId         = ?;\
        CALL `fastorder`.`UpdateProduct`(@ProductId, @ImgUrl, @ProductName, @ProductPrice, @IsAvailable,@TypeId);\
                   ';
        db.query(sql, [
            req.params.ProductId,
            req.params.ImgUrl,
            req.params.ProductName,
            req.params.ProductPrice,    
            req.params.IsAvailable,
            req.params.TypeId
        ], (err, response) => {
            if (err) throw err
            res.json({ message: 'Update successfully!' })
        })
    },
    // delete product - chuyển IsDelete = 0
    removeProduct: (req, res) => {
        let sql = 'UPDATE `fastorder`.`products`\
            SET `IsDeleted` = 1\
            WHERE `Id` = ?;'
        db.query(sql, [req.params.productId], (err, response) => {
            if (err) throw err
            res.json({ message: 'Remove successfully!' })
        })
    }
};