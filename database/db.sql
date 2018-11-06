-- MySQL Script generated by MySQL Workbench
-- Wed Nov  7 02:13:24 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema fastorder
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `fastorder` ;

-- -----------------------------------------------------
-- Schema fastorder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fastorder` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `fastorder` ;

-- -----------------------------------------------------
-- Table `fastorder`.`store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`store` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`store` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `StoreKey` VARCHAR(200) NOT NULL,
  `Location` VARCHAR(250) CHARACTER SET 'utf8' NOT NULL,
  `StoreName` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(50) NULL DEFAULT NULL,
  `Province` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `UserId` INT(11) NULL DEFAULT NULL,
  `IsDeleted` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`table` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`table` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `TableKey` VARCHAR(200) NOT NULL,
  `StoreId` INT(11) NOT NULL,
  `TableName` VARCHAR(200) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `IsAvailable` BIT(1) NOT NULL DEFAULT b'1',
  `IsDeleted` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`Id`),
  INDEX `fk_table_store1_idx` (`StoreId` ASC) VISIBLE,
  CONSTRAINT `fk_table_store1`
    FOREIGN KEY (`StoreId`)
    REFERENCES `fastorder`.`store` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`bill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`bill` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`bill` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `TableId` INT(11) NULL DEFAULT NULL,
  `DateCreate` DATETIME NULL DEFAULT NULL,
  `Total` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_bill_table1_idx` (`TableId` ASC) VISIBLE,
  CONSTRAINT `fk_bill_table1`
    FOREIGN KEY (`TableId`)
    REFERENCES `fastorder`.`table` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
DELAY_KEY_WRITE = 1;


-- -----------------------------------------------------
-- Table `fastorder`.`billdetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`billdetail` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`billdetail` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `BillId` INT(11) NULL DEFAULT NULL,
  `ProductId` INT(11) NULL DEFAULT NULL,
  `ProductName` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `Quantity` INT(11) NULL DEFAULT NULL,
  `Price` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_billdetail_bill1_idx` (`BillId` ASC) VISIBLE,
  CONSTRAINT `fk_billdetail_bill1`
    FOREIGN KEY (`BillId`)
    REFERENCES `fastorder`.`bill` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`image` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`image` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `ImgKey` VARCHAR(1000) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `DateCreate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 44
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`order` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`order` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `TableId` INT(11) NULL DEFAULT NULL,
  `DateCreate` DATETIME NULL DEFAULT NULL,
  `Total` FLOAT NULL DEFAULT NULL,
  `Status` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_order_table1_idx` (`TableId` ASC) VISIBLE,
  CONSTRAINT `fk_order_table1`
    FOREIGN KEY (`TableId`)
    REFERENCES `fastorder`.`table` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`orderdetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`orderdetail` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`orderdetail` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `OrderId` INT(11) NULL DEFAULT NULL,
  `ProductId` INT(11) NULL DEFAULT NULL,
  `ProductName` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `Quantity` INT(11) NULL DEFAULT NULL,
  `Price` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_orderdetail_order_idx` (`OrderId` ASC) VISIBLE,
  CONSTRAINT `fk_orderdetail_order`
    FOREIGN KEY (`OrderId`)
    REFERENCES `fastorder`.`order` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`type` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`type` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(200) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`products` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`products` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `StoreId` INT(11) NULL DEFAULT NULL,
  `ImageId` INT(11) NULL DEFAULT NULL,
  `ProductName` VARCHAR(200) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `ProductPrice` FLOAT NULL DEFAULT NULL,
  `TypeId` INT(11) NULL DEFAULT NULL,
  `IsDeleted` BIT(1) NULL DEFAULT b'0',
  `IsAvailable` BIT(1) NULL DEFAULT b'1',
  PRIMARY KEY (`Id`),
  INDEX `fk_products_store1_idx` (`StoreId` ASC) VISIBLE,
  INDEX `fk_products_image1_idx` (`ImageId` ASC) VISIBLE,
  INDEX `fk_products_type1_idx` (`TypeId` ASC) VISIBLE,
  CONSTRAINT `fk_products_image1`
    FOREIGN KEY (`ImageId`)
    REFERENCES `fastorder`.`image` (`Id`),
  CONSTRAINT `fk_products_store1`
    FOREIGN KEY (`StoreId`)
    REFERENCES `fastorder`.`store` (`Id`),
  CONSTRAINT `fk_products_type1`
    FOREIGN KEY (`TypeId`)
    REFERENCES `fastorder`.`type` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`role` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`role` (
  `Id` INT(11) NOT NULL,
  `RoleType` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fastorder`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fastorder`.`user` ;

CREATE TABLE IF NOT EXISTS `fastorder`.`user` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(32) NOT NULL,
  `Fullname` VARCHAR(250) CHARACTER SET 'utf8' NOT NULL,
  `Address` VARCHAR(250) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `StoreId` INT(11) NULL DEFAULT NULL,
  `RoleId` INT(11) NOT NULL,
  `Password` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `IsDeleted` BIT(1) NULL DEFAULT b'0',
  PRIMARY KEY (`Id`),
  INDEX `fk_user_role1_idx` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`RoleId`)
    REFERENCES `fastorder`.`role` (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `fastorder` ;

-- -----------------------------------------------------
-- procedure AddNewProduct
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`AddNewProduct`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewProduct`(
	_StoreId int,
	_ImgUrl text,
	_ProductName text,
    _ProductPrice float,
    _TypeId int
)
BEGIN
	DECLARE _Curdate datetime DEFAULT current_time();
    
	INSERT INTO `fastorder`.`image` (`ImgKey`, `DateCreate`) VALUES (
	_ImgUrl, _Curdate
	);
    
    INSERT INTO `fastorder`.`products` (`StoreId`, `ImageId`, `ProductName`, `ProductPrice`, `TypeId`) VALUES (
    _StoreId,
    (select id from image where ImgKey LIKE _ImgUrl and DateCreate = _Curdate),
    _ProductName,
    _ProductPrice,
    _TypeId
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddNewStore
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`AddNewStore`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewStore`(
	_StoreName text,
    _PhoneNumber text,
    _Location text,
    _Province text
)
BEGIN
	INSERT INTO fastorder.`store` (StoreKey,`Location`, StoreName, PhoneNumber, Province) VALUES
	(
    '', _Location, _StoreName, _PhoneNumber, _Province
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddNewTable
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`AddNewTable`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewTable`(
    _StoreId int,
	_TableKey text,
    _TableName text
)
BEGIN
	INSERT INTO fastorder.`table`( TableKey, StoreId, TableName) VALUES
	(
    _TableKey, _StoreId, _TableName
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddToBillDetail
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`AddToBillDetail`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddToBillDetail`(
    IN _BillId int,
    IN _ProductId int,
    IN _Quantity int
)
BEGIN
	INSERT INTO `fastorder`.`billdetail`(`BillId`,`ProductId`,`ProductName`,`Quantity`,`Price`)VALUES
	(	_BillId,
		_ProductId,
	(select ProductName from products where id = _ProductId),
		_Quantity,
	(select ProductPrice from products where id = _ProductId) * _Quantity
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddToOrderDetail
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`AddToOrderDetail`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddToOrderDetail`(
    IN _OrderId int,
    IN _ProductId int,
    IN _Quantity int
)
BEGIN
	INSERT INTO `fastorder`.`orderdetail`(`OrderId`,`ProductId`,`ProductName`,`Quantity`,`Price`)VALUES
	(	_OrderId,
		_ProductId,
	(select ProductName from products where id = _ProductId),
		_Quantity,
	(select ProductPrice from products where id = _ProductId) * _Quantity
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateNewBill
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`CreateNewBill`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateNewBill`(
	_TableKey text
)
BEGIN
	DECLARE _Curdate datetime DEFAULT current_time();
	DECLARE _TableId int DEFAULT (select id from `table` where TableKey = _TableKey);
    
	INSERT INTO `fastorder`.`bill` (`TableId`,`DateCreate`)VALUES
	((select id from `table` where tablekey = _TableKey),
		_Curdate
    );
    
    select id as billId from bill where TableId=_TableId and DateCreate=_Curdate;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateNewBillRaft
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`CreateNewBillRaft`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateNewBillRaft`(
	_TableKey text,
    _ProductId int,
    _Quantity int
)
BEGIN
	DECLARE _Curdate datetime DEFAULT current_time();
	DECLARE _TableId int DEFAULT (select id from `table` where TableKey = _TableKey);
    
	INSERT INTO `fastorder`.`bill` (`TableId`,`DateCreate`)VALUES
	((select id from `table` where tablekey = _TableKey),
		_Curdate
    );
    INSERT INTO `fastorder`.`billdetail`(`BillId`,`ProductId`,`ProductName`,`Quantity`,`Price`)VALUES
	((select id from bill where TableId=_TableId and DateCreate=_Curdate),
		_ProductId,
	 (select ProductName from products where id = _ProductId),
		_Quantity,
	 (select ProductPrice from products where id = _ProductId)
	);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CreateNewOrder
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`CreateNewOrder`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateNewOrder`(
	_TableKey text
)
BEGIN
	DECLARE _Curdate datetime DEFAULT current_time();
	DECLARE _TableId int DEFAULT (select id from `table` where TableKey = _TableKey);
    
	INSERT INTO `fastorder`.`order` (`TableId`,`DateCreate`)VALUES
	((select id from `table` where tablekey = _TableKey),
		_Curdate
    );
    
    select id as orderId from `order` where TableId=_TableId and DateCreate=_Curdate;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetBillByStoreId
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`GetBillByStoreId`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBillByStoreId`(
	_StoreId int
)
BEGIN
	SELECT 
    s.Id AS StoreId,
    t.Id AS TableId,
    b.Id AS BillId,
    b.DateCreate,
    (SELECT SUM(price) AS Total FROM billdetail bd 
		WHERE bd.billid = b.Id) AS Total,
    CASE WHEN o.Status = 0 THEN FALSE ELSE TRUE END AS `Status`
FROM
    `bill` b
        JOIN
    `table` t ON t.Id = b.TableId
        JOIN
    store s ON s.Id = t.StoreId
WHERE
    s.Id = _StoreId
;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetOrderByStoreId
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`GetOrderByStoreId`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrderByStoreId`(
	_StoreId int
)
BEGIN
	SELECT 
    s.Id AS StoreId,
    t.Id AS TableId,
    o.Id AS OrderId,
    o.DateCreate,
    (SELECT SUM(price) AS Total FROM orderdetail od
                WHERE od.orderid = o.Id) AS Total,
    CASE WHEN o.Status = 0 THEN FALSE ELSE TRUE END AS `Status`
	FROM
		`order` o
			JOIN
		`table` t ON t.Id = o.TableId
			JOIN
		store s ON s.Id = t.StoreId
	WHERE
		s.Id = _StoreId
     order by o.Id  desc
	;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetProductByStoreId
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`GetProductByStoreId`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductByStoreId`(
	_StoreId int
)
BEGIN
	SELECT 
		s.Id AS StoreId,
		p.Id AS ProductId,
		im.ImgKey,
		p.ProductName,
		p.ProductPrice,
        CASE WHEN p.IsAvailable = 1 THEN TRUE ELSE FALSE END AS IsAvailable,
        p.TypeId,
        t.Type
        
	FROM
		`products` p
		JOIN store s ON s.Id = p.StoreId
		JOIN image im ON im.id = p.imageid
        JOIN type t ON t.Id = p.TypeID
	WHERE
		s.Id = _StoreId AND p.IsDeleted = 0
	;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure TableGetTableByStoreId
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`TableGetTableByStoreId`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TableGetTableByStoreId`(
	_StoreId int
)
BEGIN
	SELECT 	t.Id AS TableId,
			s.Id AS StoreId,
            t.TableKey,
            t.TableName,
            s.StoreName, 
            CASE WHEN t.IsAvailable = 1 THEN TRUE ELSE FALSE END AS IsAvailable
            FROM `table` t
            JOIN store s ON s.Id = t.StoreId
            WHERE t.StoreId = 1 and t.IsDeleted = 0
	;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateProduct
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`UpdateProduct`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProduct`(
	_ProductId int,
    _ImgUrl text,
    _ProductName text,
    _ProductPrice int,
    _IsAvailable int,
    _TypeId int
)
BEGIN

	DECLARE _Curdate datetime DEFAULT current_time();
    
	UPDATE `fastorder`.`products` SET 
    `ProductName` 	= _ProductName,
	`ProductPrice` 	= _ProductPrice,
	`IsAvailable` 	= _IsAvailable,
    `TypeId` 		= _TypeId
	WHERE `Id` = _ProductId;
    
    UPDATE `fastorder`.`image` SET
		`ImgKey` = _ImgUrl,
		`DateCreate` = _Curdate
	WHERE `Id` = (select ImageId from products where id = _ProductId);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addUser
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`addUser`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addUser`(
	_UserName text,
    _Fullname text,
    _Address text,
    _StoreId int,
    _RoleId int,
    _Password text
)
BEGIN
	INSERT INTO `fastorder`.`user` (`UserName`, `Fullname`, `Address`, `StoreId`, `RoleId`, `Password`) VALUES
(_UserName,  _Fullname,_Address, _StoreId ,  _RoleId , _Password)
;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getRoleAndStoreId
-- -----------------------------------------------------

USE `fastorder`;
DROP procedure IF EXISTS `fastorder`.`getRoleAndStoreId`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoleAndStoreId`(
	In _Username text,
    In _Password text
)
BEGIN

	SELECT 
		u.Id As UserId, r.Id As RoleId, s.Id As StoreId,
		u.UserName, u.Fullname, s.StoreName, r.RoleType,
		CASE WHEN s.IsDeleted = 0 THEN FALSE ELSE TRUE END AS IsDeleted
	FROM 
		`user` u
		JOIn `role`r ON r.Id = u.RoleId 
		join store s on s.Id = u.StoreId
	where 
		u.UserName like _Username
		
	 and u.Password like _Password
	 ;

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
