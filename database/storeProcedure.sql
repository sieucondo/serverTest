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
    _Description text,
	_ProductName text,
    _ProductPrice float,
    _Category int
)
BEGIN
	DECLARE _Curdate datetime DEFAULT current_time();
    
	INSERT INTO `fastorder`.`image` (`Description`, `ImgPath`, `DateCreate`) VALUES (
    _Desciption, _ImgUrl, _Curdate
	);
    INSERT INTO `fastorder`.`products` (`StoreId`, `ImageId`, `ProductName`, `ProductPrice`, `Category`) VALUES (
    _StoreId,
    (select id from image where ImgPath LIKE _ImgUrl and DateCreate = _Curdate),
    _ProductName,
    _ProductPrice,
    _Category
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
    o.Total,
    o.Status
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
END
$$
DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoleAndStoreId`(
	In _Username text,
    In _Password text
)
BEGIN

SELECT RoleType , s.Id as StoreId
FROM fastorder.user u, fastorder.role r, store s
where u.RoleId = r.Id and s.UserId = u.Id and u.UserName = _Username and u.Password = _Password;

END
$$
DELIMITER ;