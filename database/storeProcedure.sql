DELIMITER $$
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
	(select ProductPrice from products where id = _ProductId)
	);

END$$
DELIMITER ;

DELIMITER $$
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

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewProduct`(
	_StoreId int,
	_ImgUrl text,
	_ProductName text,
    _ProductPrice float,
    _TypeId int
)
BEGIN
	DECLARE _Curdate datetime DEFAULT current_time();
    
	INSERT INTO `fastorder`.`image` (`Description`, `ImgPath`, `DateCreate`) VALUES (
    '', _ImgUrl, _Curdate
	);
    
    INSERT INTO `fastorder`.`products` (`StoreId`, `ImageId`, `ProductName`, `ProductPrice`, `TypeId`) VALUES (
    _StoreId,
    (select id from image where ImgPath LIKE _ImgUrl and DateCreate = _Curdate),
    _ProductName,
    _ProductPrice,
    _TypeId
	);

END$$
DELIMITER ;

DELIMITER $$
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
	;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductByStoreId`(
	_StoreId int
)
BEGIN
	SELECT 
		s.Id AS StoreId,
		p.Id AS ProductId,
		im.ImgPath,
		p.ProductName,
		p.ProductPrice
	FROM
		`products` p
		JOIN store s ON s.Id = p.StoreId
		JOIN image im ON im.id = p.imageid
	WHERE
		s.Id = _StoreId
	;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProduct`(
	_ProductId int,
    _ImgUrl text,
    _ProductName text,
	_ProductPrice text,
    _IsAvailable int
)
BEGIN

	DECLARE _Curdate datetime DEFAULT current_time();
    
	UPDATE `fastorder`.`products` SET `ProductName` = _ProductName,
	`ProductPrice` = _ProductPrice,
	`IsAvailable` = _IsAvailable
	WHERE `Id` = _ProductId;
    
    UPDATE `fastorder`.`image` SET
		`ImgPath` = _ImgUrl,
		`DateCreate` = _Curdate
	WHERE `Id` = (select ImageId from products where id = _ProductId);

END$$
DELIMITER ;

DELIMITER $$
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

DELIMITER $$
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

DELIMITER $$
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

DELIMITER $$
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

DELIMITER $$
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
		s.Id = _StoreId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewStore`(
	_StoreName text,
    _PhoneNumber text,
    _Location text,
    _Province text
)
BEGIN
	INSERT INTO `fastorder`.`store` (`StoreKey`,`Location`, `StoreName`, `PhoneNumber`, `Province`) VALUES
	(
    '', _Location, _StoreName, _PhoneNumber, _Province
    );

END$$
DELIMITER ;

DROP procedure IF EXISTS `AddNewTable`;

DELIMITER $$
USE `fastorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewTable`(
    _StoreId int,
	_TableKey text,
    _TableName text
)
BEGIN
	INSERT INTO `fastorder`.`table`( `TableKey`, `StoreId`, `TableName`) VALUES
	(
    _TableKey, _StoreId, _TableName
    );

END$$

DELIMITER ;

