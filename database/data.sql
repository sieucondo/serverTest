

INSERT INTO `store` VALUES 
(1,'SD0001','12 Nguy?n Van Quá','MDA','0910888333','TP HCM',1,_binary '\0'),
(2,'SF0001','04 hà huy t?p','OKKK','0988744571','TP HCM',2,_binary '\0'),
(3,'SFD0001','13 xô vi?t ngh? tinh','JO','0935198848','TP HCM',NULL,_binary '\0'),
(4,'SD0001','12 Nguy?n Van Quá','MDA','910888333','TP HCM',4,_binary '\0');

INSERT INTO `table` VALUES 
(1,'SD0001F01T01',1,'bàn bình thường','1',_binary ''),
(2,'SD0001F01T02',1,'bàn hồng','1',_binary ''),
(3,'SD0001F01T03',1,'bàn quan','1',_binary ''),
(4,'SF0001F01T01',2,'bàn ăn 1','1',_binary ''),
(5,'SF0001F01T02',2,'bàn ăn 2','1',_binary ''),
(6,'SF0001F01T03',2,'bàn sushi 1','1',_binary ''),
(7,'SFD0001F01T01',3,'bàn nhậu','1',_binary ''),
(8,'SFD0001F01T02',3,'bàn nước 1','1',_binary '');

INSERT INTO `type` VALUES (1,'Đồ Uống'),(2,'Đồ Ăn');

INSERT INTO `image` VALUES 
(1,'cà phê đen','https://imgur.com/4bxrTaH.jpg',NULL),
(2,'cà phê sữa đá','https://imgur.com/rQbXVNV.jpg',NULL),
(3,'tôm hùm','https://imgur.com/47mz8Ds.jpg',NULL),
(4,'tôm càng xanh','https://imgur.com/FK0GNF4.jpg',NULL),
(5,'bia heiniken','https://imgur.com/jVAknsr.jpg',NULL),
(6,'strong bow','https://imgur.com/EgV5H69.jpg',NULL),
(7,'cocacola','https://imgur.com/k5lnu1r.jpg',NULL),
(8,'cơm chiên dương châu','https://imgur.com/8Iikj46.jpg',NULL),
(23,'','https://translate.google.com/?hl=vi','2018-11-06 01:10:38'),
(24,'','akjshdskajhd','2018-11-06 16:14:28');

INSERT INTO `products` VALUES 
(1,1,1,'Cà Phê Đen',12,1,_binary '\0',_binary ''),
(2,1,2,'Cà Phê Sữa',15,1,_binary '\0',_binary ''),
(3,1,7,'Cocacola',10,1,_binary '\0',_binary ''),
(4,2,3,'Tôm Hùm',1256,2,_binary '\0',_binary ''),
(5,2,3,'Tôm Hùm đỏ',1561,2,_binary '\0',_binary ''),
(6,3,5,'Heniken',31,1,_binary '\0',_binary ''),
(7,3,6,'Strong bow',14,1,_binary '\0',_binary ''),
(8,1,3,'Tôm Hoàng Đế',2500,2,_binary '\0',_binary ''),
(9,1,8,'Cơm Chiên Dương Châu',23,2,_binary '\0',_binary ''),
(22,1,24,'coco loa',13,1,_binary '\0',_binary '');

INSERT INTO `role` VALUES (1,'admin'),(2,'owner');

INSERT INTO `user` VALUES 
(1,'MDA1234','Mã Đại','13 hải hồ',1,2,'abcd1234',_binary '\0'),
(2,'OKKK1234','Mã Đáo','13 hàm nghi',2,2,'abcd1234',_binary '\0'),
(3,'sieutnm123','Siêu','12 hùng vương',0,1,'abcd1234',_binary '\0'),
(4,'HOHO122','ag bo','12 dsjja â',1,2,'abcd1234',_binary '\0'),
(5,'YAUTJA','Thanh Hai','12 delhi no',3,2,'abcd1234',_binary '\0'),
(6,'MKBO1','Thanh Ho','12 country ni',3,2,'abcd1234',_binary '\0'),
(7,'MKBOP3','Dam Thanh Ho','45 country long',2,2,'abcd1234',_binary '\0');

INSERT INTO `order` VALUES (1,1,'2018-10-02 12:30:12',NULL,_binary ''),
(2,1,'2018-10-02 12:34:11',NULL,_binary ''),
(3,4,'2018-11-05 22:47:53',NULL,NULL),
(4,1,'2018-11-05 22:56:41',NULL,NULL);

INSERT INTO `orderdetail` VALUES 
(1,1,3,'Cocacola',4,40),
(2,2,2,'Cà Phê Sữa',5,75);

INSERT INTO `bill` VALUES 
(1,1,'2018-11-04 15:32:33',2552),
(2,1,'2018-11-04 18:19:09',NULL),
(3,NULL,'2018-11-04 19:56:01',NULL),
(4,1,'2018-11-04 19:56:07',NULL);

INSERT INTO `billdetail` VALUES 
(1,1,1,'Cà Phê Đen',1,12),
(2,1,8,'Tôm Hoàng Đế',1,2500),
(3,1,3,'Cocacola',1,10),
(4,1,2,'Cà Phê Sữa',2,30);
