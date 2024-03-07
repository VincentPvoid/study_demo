-- 练习 聚合函数
USE atguigudb;

-- 1.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees;

-- 2.查询各job_id的员工工资的最大值，最小值，平均值，总和
SELECT job_id, MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees
GROUP BY job_id;

-- 3.选择具有各个job_id的员工人数
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

-- 4.查询员工最高工资和最低工资的差距（DIFFERENCE）
SELECT MAX(salary), MIN(salary), MAX(salary) - MIN(salary) "DIFFERENCE"
from employees;

-- 5.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000;

-- 6.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序
SELECT d.department_id, d.department_name, d.location_id, 
  COUNT(e.salary), AVG(e.salary)
FROM departments d LEFT JOIN employees e
ON e.department_id = d.department_id
GROUP BY d.department_id, d.location_id
ORDER BY AVG(e.salary);

-- 7.查询每个工种、每个部门的部门名、工种名和最低工资
SELECT d.department_name, e.job_id, MIN(salary)
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name, e.job_id; 



