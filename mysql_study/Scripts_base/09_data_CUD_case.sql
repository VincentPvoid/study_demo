-- 数据处理增删改 案例


-- 1、创建数据库test01_library
CREATE DATABASE IF NOT EXISTS test01_library CHARACTER SET 'utf8';

SHOW CREATE DATABASE test01_library;

USE test01_library;

SHOW TABLES;

-- 2、创建表 books
CREATE TABLE IF NOT EXISTS books(
  `id` INT,
  `name` VARCHAR(50),
  authors VARCHAR(100),
  price FLOAT,
  pubdate YEAR,
  note VARCHAR(100),
  num INT
);

SELECT * FROM books;


-- 3、向books表中插入记录
--  1）不指定字段名称，插入第一条记录
INSERT INTO books
VALUES(1, 'Tal of AAA', 'Dickes', 23, '1995', 'novel', 11);

--  2）指定所有字段名称，插入第二记录
INSERT INTO books(`id`, `name`, authors, note, price, pubdate, num)
VALUES(2, 'EmmaT', 'Jane lura', 'joke', 35, '1993', 22);

--  3）同时插入多条记录（剩下的所有记录）
INSERT INTO books(`id`, `name`, authors, price, pubdate, note, num)
VALUES
  (3, 'Story of Jane', 'Jane Tim', 40, '2001', 'novel', 0),
  (4, 'Lovey Day', 'George Byron', 20, '2005', 'novel', 30),
  (5, 'Old land', 'Honore Blade', 30, '2010', 'law', 0),
  (6, 'The Battle', 'Upton Sara', 30, '1999', 'medicine', 40),
  (7, 'Rose Hood', 'Richard haggard', 28, '2008', 'cartoon', 28);


-- 4、将小说类型(novel)的书的价格都增加5。
UPDATE books
SET price = price + 5
WHERE note = 'novel';


-- 5、将名称为EmmaT的书的价格改为40，并将说明改为drama。
UPDATE books
SET price = 40, note = 'drama'
WHERE `name` = 'EmmaT';


-- 6、删除库存为0的记录。
DELETE FROM books
WHERE num = 0;


-- 7、统计书名中包含a字母的书
SELECT * 
FROM books
WHERE `name` LIKE '%a%'; 


-- 8、统计书名中包含a字母的书的数量和库存总量
SELECT COUNT(*), SUM(num)
FROM books
WHERE `name` LIKE '%a%'; 


-- 9、找出“novel”类型的书，按照价格降序排列
SELECT *
FROM books
WHERE note = 'novel'
ORDER BY price DESC;


-- 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列
SELECT * 
FROM books
ORDER BY num DESC, note ASC;


-- 11、按照note分类统计书的数量
SELECT note, COUNT(*) 
FROM books
GROUP BY note;


-- 12、按照note分类统计书的库存量，显示库存量超过30本的
SELECT note, SUM(num)
FROM books
GROUP BY note
HAVING SUM(num) > 30;


-- 13、查询所有图书，每页显示5本，显示第二页
SELECT *
FROM books
LIMIT 5, 5;


-- 14、按照note分类统计书的库存量，显示库存量最多的
SELECT note, SUM(num)
FROM books
GROUP BY note
ORDER BY SUM(num) DESC
LIMIT 0, 1;


-- 15、查询书名达到10个字符的书，不包括里面的空格
SELECT *
FROM books
WHERE CHAR_LENGTH(REPLACE(`name`, ' ', '')) >= 10;


-- 16、查询书名和类型，其中note值为novel显示小说，law显示法律，medicine显示医药，cartoon显示卡通，joke显示笑话
SELECT `name`, note,
  (CASE note
    WHEN 'novel' THEN '小说'  
    WHEN 'law' THEN '法律'  
    WHEN 'medicine' THEN '医药'  
    WHEN 'cartoon' THEN '卡通'  
    WHEN 'joke' THEN '笑话'  
  END) "type"
FROM books;


-- 17、查询书名、库存，其中num值超过30本的，显示滞销，大于0并低于10的，显示畅销，为0的显示无货
SELECT `name`, num,
  (CASE 
    WHEN num > 30 THEN '滞销' 
    WHEN num = 0 THEN '无货' 
    WHEN num > 0 AND num < 10 THEN '畅销'
  END 
  ) "status"
FROM books;


-- 18、统计每一种note的库存量，并合计总量
SELECT IFNULL(note, 'sum') AS note, SUM(num)
FROM books
GROUP BY note WITH ROLLUP;


-- 19、统计每一种note的数量，并合计总量
SELECT IFNULL(note, 'sum') AS note, COUNT(*)
FROM books
GROUP BY note WITH ROLLUP;


-- 20、统计库存量前三名的图书
SELECT *
FROM books
ORDER BY num DESC
LIMIT 0,3;


-- 21、找出最早出版的一本书
SELECT *
FROM books
ORDER BY pubdate
LIMIT 0, 1;


-- 22、找出novel中价格最高的一本书
SELECT *
FROM books
WHERE note = 'novel'
ORDER BY price DESC
LIMIT 0,1;


-- 23、找出书名中字数最多的一本书，不含空格
SELECT *
FROM books
ORDER BY LENGTH(REPLACE(`name`, ' ', '')) DESC
LIMIT 0,1;



SET autocommit = FALSE;
DELETE FROM books;
ROLLBACK;