-- 练习：创建和管理表 练习3


-- 1、创建数据库test03_company
CREATE DATABASE IF NOT EXISTS test03_company CHARACTER SET 'utf8';

-- -- 删除数据库
-- DROP DATABASE test03_company;

SHOW CREATE DATABASE test03_company;

USE test03_company;


-- 2、创建表offices
CREATE TABLE IF NOT EXISTS offices(
  officeCode INT,
  city VARCHAR(30),
  `address` VARCHAR(50),
  country VARCHAR(50),
  postalCode VARCHAR(25)
)

-- -- 删除offices表
-- DROP TABLE offices;


-- 3、创建表employees
CREATE TABLE IF NOT EXISTS employees(
  empNum INT,
  lastName VARCHAR(50),
  firstName VARCHAR(50),
  mobile VARCHAR(25),
  `code` INT,
  jobTitle VARCHAR(50),
  birth DATE,
  note VARCHAR(255),
  sex VARCHAR(5)
);

DESC employees;

-- 4、将表employees的mobile字段修改到code字段后面
ALTER TABLE employees MODIFY mobile VARCHAR(25) AFTER `code`;


-- 5、将表employees的birth字段改名为birthday
ALTER TABLE employees CHANGE birth birthday DATE;


-- 6、修改sex字段，数据类型为char(1)
ALTER TABLE employees MODIFY sex CHAR(1);


-- 7、删除字段note
ALTER TABLE employees DROP note;


-- 8、增加字段名favoriate_activity，数据类型为varchar(100)
ALTER TABLE employees ADD favoriate_activity VARCHAR(100);


-- 9、将表employees的名称修改为 employees_info
RENAME TABLE employees
TO employees_info;

DESC employees_info;
