CREATE DATABASE `fastorder` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `fastorder`;

CREATE TABLE `bill` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TableId` int(11) DEFAULT NULL,
  `DateCreate` date DEFAULT NULL,
  `Total` float DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE `fastorder`.`bill` 
CHANGE COLUMN `DateCreate` `DateCreate` DATETIME NULL DEFAULT NULL ;

CREATE TABLE `billdetail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `BillId` int(11) DEFAULT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductName` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` float DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `order` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TableId` int(11) DEFAULT NULL,
  `DateCreate` date DEFAULT NULL,
  `Total` float DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE `fastorder`.`bill` 
CHANGE COLUMN `DateCreate` `DateCreate` DATETIME NULL DEFAULT NULL ;

CREATE TABLE `orderdetail` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `OrderId` int(11) DEFAULT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductName` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` float DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `category` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TypeId` int(11) DEFAULT NULL,
  `Description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `image` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ImgPath` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `StoreId` int(11) DEFAULT NULL,
  `ImageId` int(11) DEFAULT NULL,
  `ProductName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ProductPrice` float DEFAULT NULL,
  `Category` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `store` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `StoreKey` varchar(200) NOT NULL,
  `Location` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `PhoneNumber` varchar(50) DEFAULT NULL,
  `Province` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE `fastorder`.`store` 
ADD COLUMN `StoreName` VARCHAR(250) NOT NULL AFTER `Location`;

CREATE TABLE `table` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TableKey` varchar(200) NOT NULL,
  `StoreId` int(11) NOT NULL,
  `TableName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Floor` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE `fastorder`.`table` 
ADD COLUMN `IsAvailable` BIT NOT NULL DEFAULT 1 AFTER `Floor`;

CREATE TABLE `type` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserKey` varbinary(200) NOT NULL,
  `Fullname` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Address` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Dob` date DEFAULT NULL,
  `StoreId` int(11) NOT NULL,
  `Password` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `wifi` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `StoreId` int(11) NOT NULL,
  `Name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- insert
INSERT INTO `fastorder`.`category` (`TypeId`,`Description`) VALUES 
(1, 'Cà phê'),
(1, 'Nước ngọt'),
(2, 'Hải Sản'),
(2, 'Lẩu'),
(1, 'Bia'),
(2, 'Cơm');


INSERT INTO `fastorder`.`image` (`Description`,`ImgPath`) VALUES
('cà phê đen', 'https://imgur.com/4bxrTaH.jpg'),
('cà phê sữa đá', 'https://imgur.com/rQbXVNV.jpg'),
('tôm hùm', 'https://imgur.com/47mz8Ds.jpg'),
('tôm càng xanh', 'https://imgur.com/FK0GNF4.jpg'),
('bia heiniken', 'https://imgur.com/jVAknsr.jpg'),
('strong bow', 'https://imgur.com/EgV5H69.jpg'),
('cocacola', 'https://imgur.com/k5lnu1r.jpg'),
('cơm chiên dương châu', 'https://imgur.com/8Iikj46.jpg')
;

INSERT INTO `fastorder`.`products`(`StoreId`,`ImageId`,`ProductName`,`ProductPrice`,`Category`)VALUES
( 1, 1, 'Cà Phê Đen', 12, 1),
( 1, 2, 'Cà Phê Sữa', 15, 1),
( 1, 4, 'Cocacola', 10, 2),
( 2, 3, 'Tôm Hùm', 1256, 3),
( 2, 3, 'Tôm Hùm đỏ', 1561, 3),
( 3, 5, 'Heniken', 31, 5),
( 3, 6, 'Strong bow', 14, 2),
(1, 3, 'Tôm Hoàng Đế', 2500, 3),
(1, 7, 'Cơm Chiên Dương Châu', 23, 6);
;

INSERT INTO `fastorder`.`store` (`StoreKey`,`Location`,`StoreName`,`PhoneNumber`,`Province`)VALUES
('SD0001', '12 Nguy?n Van Quá', 'MDA', 0910888333, 'TP HCM'),
( 'SF0001', '04 hà huy t?p', 'OKKK', 0988744571, 'TP HCM'),
('SFD0001', '13 xô vi?t ngh? tinh', 'JO', 0935198848, 'TP HCM')
;

INSERT INTO `fastorder`.`table` (`TableKey`,`StoreId`,`TableName`,`Floor`)VALUES
('SD0001F01T01', 1, 'bàn bình thường', 1),
('SD0001F01T02', 1, 'bàn hồng', 1),
('SD0001F01T03', 1, 'bàn quan', 1),
('SF0001F01T01', 2, 'bàn ăn 1', 1),
('SF0001F01T02', 2, 'bàn ăn 2', 1),
('SF0001F01T03', 2, 'bàn sushi 1', 1),
('SFD0001F01T01', 3, 'bàn nhậu', 1),
('SFD0001F01T02', 3, 'bàn nước 1', 1)
;

INSERT INTO `fastorder`.`type`(`Type`)VALUES
('Đồ Uống'),
('Đồ Ăn')
;

INSERT INTO `fastorder`.`wifi` (`StoreId`, `Name`, `Password`) VALUES ('1', 'MDA1', '88888888'), ('2', 'OKK1', '88888888'), ('3', 'JOLO', '88888888'), ('1', 'MDA2', '88888888'), ('2', 'OKK2', '88888888');
