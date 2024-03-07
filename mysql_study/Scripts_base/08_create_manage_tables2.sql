-- 练习：创建和管理表 练习2


-- 1、创建数据库 test02_market
CREATE DATABASE IF NOT EXISTS test02_market CHARACTER SET 'utf8';

-- -- 删除数据库
-- DROP DATABASE test02_market;

SHOW CREATE DATABASE test02_market;

-- 查看当前使用数据库
SELECT DATABASE();
-- 使用目标数据库
USE test02_market;


-- 2、创建数据表 customers
CREATE TABLE IF NOT EXISTS customers(
  c_num INT,
  c_name VARCHAR(50),
  c_contact VARCHAR(50),
  c_city VARCHAR(50),
  c_birth DATE
);

-- 查看customers表
DESC customers;

-- 3、将 c_contact 字段移动到 c_birth 字段后面
ALTER TABLE customers MODIFY c_contact VARCHAR(50) AFTER c_birth;


-- 4、将 c_name 字段数据类型改为 varchar(70)
ALTER TABLE customers MODIFY c_name VARCHAR(70);


-- 5、将c_contact字段改名为c_phone
ALTER TABLE customers 
CHANGE c_contact c_phone VARCHAR(50); 


-- 6、增加c_gender字段到c_name后面，数据类型为char(1)
ALTER TABLE customers ADD c_gender CHAR(1) AFTER c_name;


-- 7、将表名改为customers_info
RENAME TABLE customers
TO customers_info;

DESC customers_info;


-- 8、删除字段c_city
ALTER TABLE customers_info DROP c_city;
