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
