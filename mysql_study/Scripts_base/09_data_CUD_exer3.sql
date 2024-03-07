-- 数据处理增删改 练习3


-- 1. 使用已有的数据库dbtest11
USE dbtest11;


-- 2. 创建表employee，并添加记录
CREATE TABLE IF NOT EXISTS employees(
  `id` INT,
  `name` VARCHAR(20),
  sex VARCHAR(2),
  tel VARCHAR(20),
  addr VARCHAR(50),
  salary DOUBLE
);

INSERT INTO employees(`id`, `name`, sex, tel, addr, salary)
VALUES
  (10001, '张一一', '男', '13456789000', '山东青岛', 1001.58),
  (10002, '刘小红', '女', '13454319000', '河北保定', 1201.21),
  (10003, '李四', '男', '0751-1234567', '广东佛山', 1004.11),
  (10004, '刘小强', '男', '0755-5555555', '广东深圳', 1501.23),
  (10005, '王艳', '女', '020-1232133', '广东广州', 1405.16);

SELECT * FROM employees;


-- 3. 查询出薪资在1200~1300之间的员工信息
SELECT *
FROM employees
WHERE salary >= 1200 AND salary <= 1300;


-- 4. 查询出姓“刘”的员工的工号，姓名，家庭住址
SELECT `id`, `name`, addr
FROM employees
WHERE `name` LIKE "刘%";


-- 5. 将“李四”的家庭住址改为“广东韶关”
UPDATE employees
SET addr = '广东韶关'
WHERE `name` = '李四';


-- 6. 查询出名字中带“小”的员工
SELECT *
FROM employees
WHERE `name` LIKE "%小%";

