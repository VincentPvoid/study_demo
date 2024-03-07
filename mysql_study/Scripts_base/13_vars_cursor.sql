-- 变量、流程控制与游标 练习


-- 变量
-- 0.准备工作
CREATE DATABASE IF NOT EXISTS test13_var_cur CHARACTER SET 'utf8';
USE test13_var_cur;
CREATE TABLE IF NOT EXISTS employees
AS
SELECT * FROM atguigudb.employees;

CREATE TABLE IF NOT EXISTS departments
AS
SELECT * FROM atguigudb.departments;

SET GLOBAL log_bin_trust_function_creators = 1;

-- 无参有返回
-- 1. 创建函数get_count(),返回公司的员工个数
CREATE FUNCTION get_count()
RETURNS INT
BEGIN
  DECLARE emp_count INT DEFAULT 0;
  SELECT COUNT(*) INTO emp_count
  FROM employees;
  RETURN emp_count;
END ;

SELECT get_count();

DESC employees;
SELECT * FROM employees;


-- 有参有返回
-- 2. 创建函数ename_salary(),根据员工姓名，返回它的工资
CREATE FUNCTION ename_salary(emp_last_name VARCHAR(25))
RETURNS DOUBLE
BEGIN
  DECLARE emp_salary DOUBLE;

  SELECT salary INTO emp_salary
  FROM employees
  WHERE last_name = emp_last_name;

  RETURN emp_salary;
END;

SET @test_name = 'Abel';
SELECT ename_salary(@test_name);


-- 3. 创建函数dept_sal() ,根据部门名，返回该部门的平均工资
DESC departments;
SELECT AVG(e.salary)
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Marketing';

CREATE FUNCTION dept_sal(dept_name VARCHAR(30))
RETURNS DOUBLE(8,2)
BEGIN
  DECLARE avg_sal DOUBLE;

  SELECT AVG(e.salary) INTO avg_sal
  FROM employees e JOIN departments d
  ON e.department_id = d.department_id
  WHERE d.department_name = dept_name;

  RETURN avg_sal;
END;

-- DROP FUNCTION IF EXISTS dept_sal;

SELECT dept_sal('IT');


-- 4. 创建函数add_float()，实现传入两个float，返回二者之和
CREATE FUNCTION add_float(float1 FLOAT, float2 FLOAT)
RETURNS FLOAT
BEGIN
  DECLARE res FLOAT;
  SET res = float1 + float2;
  RETURN res;
END;

DROP FUNCTION IF EXISTS add_float;

SELECT add_float(1.2, 2.1);





-- 流程控制
-- 1. 创建函数test_if_case()，实现传入成绩，如果成绩>90,返回A，如果成绩>80,返回B，如果成绩>60,返回C，否则返回D
-- 要求：分别使用if结构和case结构实现
CREATE FUNCTION test_if_case1(score INT)
RETURNS CHAR
BEGIN
  DECLARE res CHAR;

  IF score > 90
    THEN SET res = 'A';
  ELSEIF score > 80
    THEN SET res = 'B';
  ELSEIF score > 60
    THEN SET res = 'C';
  ELSE
    SET res = 'D';
  END IF;

  RETURN res;
END;

CREATE FUNCTION test_if_case2(score INT)
RETURNS CHAR(1)
BEGIN
  DECLARE res CHAR(1);

  CASE
    WHEN score > 90 THEN SET res = 'A';
    WHEN score > 80 THEN SET res = 'B';
    WHEN score > 60 THEN SET res = 'C';
    ELSE SET res = 'D';
  END CASE;

  RETURN res;
END;

SELECT test_if_case1(18);
SELECT test_if_case2(98);


-- 2. 创建存储过程test_if_pro()，传入工资值，如果工资值<3000,则删除工资为此值的员工，如果3000 <= 工资值 <= 5000,则修改此工资值的员工薪资涨1000，否则涨工资500
SELECT *
FROM employees
ORDER BY salary;

CREATE PROCEDURE test_if_pro(IN emp_salary DOUBLE(8,2))
BEGIN
  DECLARE emp_last_name VARCHAR(25);

  -- SELECT last_name INTO emp_last_name
  -- FROM employees
  -- WHERE salary = emp_salary;

  -- IF emp_last_name IS NOT NULL
  --   IF emp_salary < 3000
  --     THEN DELETE FROM employees WHERE last_name = emp_last_name;
  --   ELSEIF emp_salary <= 5000
  --     THEN UPDATE employees SET salary = salary + 1000 WHERE last_name = emp_last_name;
  --   ELSE
  --     UPDATE employees SET salary = salary + 500 WHERE last_name = emp_last_name;
  --   END IF;
  -- END IF; 


  IF emp_salary < 3000
    THEN DELETE FROM employees WHERE salary = emp_salary;
  ELSEIF emp_salary <= 5000
    THEN UPDATE employees SET salary = salary + 1000 WHERE salary = emp_salary;
  ELSE
    UPDATE employees SET salary = salary + 500 WHERE salary = emp_salary;
  END IF;

END;

DROP PROCEDURE IF EXISTS test_if_pro;

CALL test_if_pro(3100);


-- 3. 创建存储过程insert_data(),传入参数为 IN 的 INT 类型变量 insert_count,实现向admin表中批量插入insert_count条记录
CREATE TABLE test_admin(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  user_name VARCHAR(25) NOT NULL,
  user_pwd VARCHAR(35) NOT NULL
);
SELECT * FROM test_admin;

-- DELETE FROM test_admin;

CREATE PROCEDURE insert_data(IN insert_count INT)
BEGIN
  DECLARE loop_num INT DEFAULT 0;

  WHILE loop_num < insert_count DO
    INSERT INTO test_admin(user_name, user_pwd)
    VALUES(CONCAT('', loop_num), ROUND(RAND() * 100000));

    SET loop_num = loop_num + 1;
  END WHILE;
END;

DROP PROCEDURE IF EXISTS insert_data;

CALL insert_data(50);





-- 游标的使用
/* 创建存储过程update_salary()，参数1为 IN 的INT型变量dept_id，表示部门id；
参数2为 IN的INT型变量change_sal_count，表示要调整薪资的员工个数。
查询指定id部门的员工信息，按照salary升序排列，根据hire_date的情况，调整前change_sal_count个员工的薪资，详情如下。
  hire_date < 1995  salary = salary*1.2
  hire_date >=1995 and hire_date <= 1998 salary = salary*1.15
  hire_date > 1998 and hire_date <= 2001 salary = salary *1.10
  hire_date > 2001 salary = salary * 1.05
*/
SELECT * 
FROM employees
WHERE YEAR(hire_date) > 1999;

SELECT COUNT(*)
FROM employees 
WHERE department_id = 10
ORDER BY salary

CREATE PROCEDURE update_salary(IN dept_id INT, IN change_sal_count INT)
BEGIN
  -- 循环次数
  DECLARE for_num INT DEFAULT 0;
  -- 当前操作员工编号
  DECLARE emp_id INT;
  -- 当前员工hire_date
  DECLARE emp_date DATE;
  -- 记录需要修改的倍率
  DECLARE change_rate DOUBLE DEFAULT 0.00;

  -- 记录查询出来的条数
  DECLARE tar_count INT;
  
  -- 定义游标
  DECLARE emp_cursor CURSOR FOR (
    SELECT employee_id, hire_date 
    FROM employees 
    WHERE department_id = dept_id
    ORDER BY salary
  );

  -- 记录目标部门的员工数；如果该值小于目标值，则循环该次数
  SELECT COUNT(*) INTO tar_count
  FROM employees 
  WHERE department_id = dept_id
  ORDER BY salary;


  -- 打开游标
  OPEN emp_cursor;

  WHILE (for_num < change_sal_count AND for_num < tar_count) DO
    -- 使用游标
    FETCH emp_cursor INTO emp_id, emp_date;

    -- 根据条件，设置需要修改的倍率
    IF YEAR(emp_date) < 1995
      THEN SET change_rate = 1.2;
    ELSEIF YEAR(emp_date) >= 1995 AND YEAR(emp_date) <= 1998
      THEN SET change_rate = 1.15;
    ELSEIF YEAR(emp_date) > 1998 AND YEAR(emp_date) <= 2001
      THEN SET change_rate = 1.10;
    ELSE
      SET change_rate = 1.05;
    END IF;  

    -- 修改对应员工工资
    UPDATE employees 
    SET salary = salary * change_rate
    WHERE employee_id = emp_id;  

    SET for_num = for_num + 1;
  END WHILE;

  -- 关闭游标
  CLOSE emp_cursor;
END;

DROP PROCEDURE IF EXISTS update_salary;

SELECT * FROM employees
WHERE department_id = 10
ORDER BY salary;

CALL update_salary(10, 2);