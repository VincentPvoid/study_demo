-- 存储过程与函数 练习

-- 存储过程练习
-- 0.准备工作
CREATE DATABASE IF NOT EXISTS test12_pro_func CHARACTER SET 'utf8';
USE test12_pro_func;

-- 1. 创建存储过程insert_user(),实现传入用户名和密码，插入到admin表中
CREATE TABLE `admin`(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  user_name VARCHAR(15) NOT NULL,
  pwd VARCHAR(25) NOT NULL
);

-- 不需要修改分隔符就可以执行
-- DELIMITER $$
CREATE PROCEDURE insert_user(IN userName VARCHAR(15), IN pwdCode VARCHAR(25))
BEGIN
  INSERT INTO `admin`(user_name, pwd)
  VALUES(userName, pwdCode);
END 
-- DELIMITER ;

CALL insert_user('aaa', '123');

SELECT * FROM `admin`;

-- 2. 创建存储过程get_phone(),实现传入女神编号，返回女神姓名和女神电话
CREATE TABLE IF NOT EXISTS beauty(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  phone VARCHAR(15) UNIQUE,
  birth DATE
);
INSERT INTO beauty(`name`,phone,birth)
VALUES
  ('朱茵','13201233453','1982-02-12'),
  ('孙燕姿','13501233653','1980-12-09'),
  ('田馥甄','13651238755','1983-08-21'),
  ('邓紫棋','17843283452','1991-11-12'),
  ('刘若英','18635575464','1989-05-18'),
  ('杨超越','13761238755','1994-05-11');
SELECT * FROM beauty;

CREATE PROCEDURE get_phone(IN userId INT, OUT userName VARCHAR(15), OUT phoneNum VARCHAR(15))
BEGIN
  SELECT `name`, phone INTO userName, phoneNum
  FROM beauty
  WHERE `id` = userId;
END;

-- DROP PROCEDURE get_phone;

CALL get_phone(5, @userName, @phoneNum);
SELECT @userName, @phoneNum;


-- 3. 创建存储过程date_diff()，实现传入两个女神生日，返回日期间隔大小
CREATE PROCEDURE date_diff(IN date1 DATE, IN date2 DATE, OUT duration INT)
BEGIN
  SELECT DATEDIFF(date1, date2) INTO duration;
END;

CALL date_diff('1982-02-12', '1982-03-15', @duration);
SELECT @duration;


-- 4. 创建存储过程format_date(),实现传入一个日期，格式化成xx年xx月xx日并返回
CREATE PROCEDURE format_date(IN oriDate DATETIME, OUT resStr VARCHAR(25))
BEGIN
  SELECT DATE_FORMAT(oriDate, '%Y-%m-%d') INTO resStr;
END;

-- DROP PROCEDURE format_date;

SET @mydate = CURRENT_DATE();
CALL format_date(@mydate,@strdate);
SELECT @strdate;


-- 5. 创建存储过程beauty_limit()，根据传入的起始索引和条目数，查询女神表的记录
CREATE PROCEDURE beauty_limit(IN startInd INT, IN pageSize INT)
BEGIN
  SELECT * 
  FROM beauty
  LIMIT startInd, pageSize;
END;

CALL beauty_limit(0,3);



-- 创建带inout模式参数的存储过程
-- 6. 传入a和b两个值，最终a和b都翻倍并返回
CREATE PROCEDURE double_num(INOUT aa INT, INOUT bb INT)
BEGIN
  SET aa = aa * 2;
  SET bb = bb * 2;
END;

SET @a1 = 3, @b1 = 8;
CALL double_num(@a1, @b1);
SELECT @a1, @b1;


-- 7. 删除题目5的存储过程
DROP PROCEDURE IF EXISTS beauty_limit;


-- 8. 查看题目6中存储过程的信息
SHOW CREATE PROCEDURE double_num\G;
SHOW PROCEDURE STATUS LIKE 'double_num'\G;
SELECT * FROM information_schema.Routines
WHERE ROUTINE_NAME='double_num'\G;



################################################################################


-- 存储函数练习
-- 0. 准备工作
USE test12_pro_func;
CREATE TABLE IF NOT EXISTS employees
AS
SELECT * FROM atguigudb.`employees`;
CREATE TABLE IF NOT EXISTS departments
AS
SELECT * FROM atguigudb.`departments`;


-- 无参有返回
-- 1. 创建函数get_count(),返回公司的员工个数
CREATE FUNCTION get_count() 
RETURNS INT
LANGUAGE SQL
DETERMINISTIC
BEGIN
  RETURN (
    SELECT COUNT(*)
    FROM employees
  );
END ;
-- DROP FUNCTION get_count;

SELECT get_count();


-- 有参有返回
-- 2. 创建函数ename_salary(),根据员工姓名，返回它的工资
DESC employees;
CREATE FUNCTION ename_salary(empName VARCHAR(25))
RETURNS DOUBLE(8,2)
LANGUAGE SQL
DETERMINISTIC
BEGIN
  RETURN (
    SELECT salary
    FROM employees
    WHERE last_name = empName
  );
END;

SET @empName = 'Abel';
SELECT ename_salary(@empName);


-- 3. 创建函数dept_sal() ,根据部门名，返回该部门的平均工资
-- 查询某部门平均工资
SELECT AVG(e.salary)
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'IT'

DESC departments;
SELECT * FROM departments;
SELECT * FROM employees;

CREATE FUNCTION dept_sal(deptName VARCHAR(20))
RETURNS DOUBLE(8,2)
LANGUAGE SQL
DETERMINISTIC
BEGIN
  RETURN (
    SELECT AVG(e.salary)
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    WHERE d.department_name = deptName
  );
END;

DROP FUNCTION IF EXISTS dept_sal;

SET @deptName = 'Marketing';
SELECT dept_sal(@deptName);


-- 4. 创建函数add_float()，实现传入两个float，返回二者之和
SET GLOBAL log_bin_trust_function_creators = 1;
CREATE FUNCTION add_float(num1 FLOAT, num2 FLOAT)
RETURNS FLOAT
BEGIN
  RETURN ( SELECT num1 + num2 );
END;

SET @num1 = 1.2, @num2 = 2.1;
SELECT add_float(@num1, @num2);

