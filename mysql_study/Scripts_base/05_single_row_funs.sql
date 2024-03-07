-- 练习 单行函数
USE atguigudb;

-- 1.显示系统时间(注：日期+时间)
SELECT NOW(), SYSDATE()
FROM DUAL;

-- 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT employee_id, last_name, salary, salary * 1.2 AS "new salary"
FROM employees;

-- 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT last_name, CHAR_LENGTH(last_name) AS "length"
FROM employees
ORDER BY last_name;

-- 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT(employee_id, last_name, salary) AS "OUT_PUT"
FROM employees;

-- 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT last_name, hire_date, 
  FLOOR(DATEDIFF(NOW(), hire_date) / 365) AS "years", 
  DATEDIFF(NOW(), hire_date) AS "days"
FROM employees
ORDER BY years DESC;

-- 6.查询员工姓名，hire_date , department_id，满足以下条件：
-- 雇用时间在1997年之后，department_id为80 或 90 或110, commission_pct不为空
SELECT last_name, hire_date, department_id, commission_pct
FROM employees
WHERE DATEDIFF(hire_date, '1997-01-01') >= 0
AND department_id IN (80, 90, 110)
AND commission_pct IS NOT NULL;

-- 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT last_name, hire_date,
  DATEDIFF(NOW(), hire_date) AS "days"
FROM employees
WHERE DATEDIFF(NOW(), hire_date) > 10000;

-- 8.做一个查询，产生下面的结果
-- <last_name> earns <salary> monthly but wants <salary*3>
SELECT CONCAT(last_name, ' earns ', TRUNCATE(salary, 0), ' monthly but wants ', TRUNCATE(salary * 3, 0)) AS "Dream Salary"
FROM employees;

-- 9.使用case-when，按照下面的条件：
-- job grade
-- AD_PRES A
-- ST_MAN B
-- IT_PROG C
-- SA_REP D
-- ST_CLERK E
SELECT last_name, job_id AS "job", 
  CASE job_id
    WHEN 'AD_PRES' THEN 'A'
    WHEN 'ST_MAN' THEN 'B'
    WHEN 'IT_PROG' THEN 'C'
    WHEN 'SA_REP' THEN 'D'
    WHEN 'ST_CLERK' THEN 'E'
  END AS "grade"
FROM employees;
