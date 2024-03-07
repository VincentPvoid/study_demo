-- 子查询 案例
USE atguigudb;

-- 单行子查询

-- 查询比Abel工资高的员工
-- 方式1：自连接
SELECT e2.last_name, e2.salary
FROM employees e1 JOIN employees e2 
ON e1.salary < e2.salary
WHERE e1.last_name = 'Abel';

-- 方式2：子查询
SELECT last_name, salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE last_name = 'Abel'
              );



-- HAVING 中的子查询
-- 查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
                        SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = 50
                    );



-- CASE中的子查询
-- 显示员工的employee_id,last_name和location。其中，若员工department_id与location_id为1800的department_id相同，则location为’Canada’，其余则为’USA’。
SELECT employee_id, last_name,
      (CASE department_id
        WHEN
          (SELECT department_id FROM departments
          WHERE location_id = 1800)
        THEN 'Canada' 
        ELSE 'USA' END) "location"
FROM employees;



-- 多行子查询

-- 查询平均工资最低的部门id
-- 方式1：查询所有部门的平均工资，作为一张新表；然后找到该新表中的最低工资，再和其他所有部门的平均工资进行比较筛选；
-- 如果进行比较的值等于最小值，就是要查找的目标部门
-- 注意：查询出来的新表必须起别名（表别名直接写，不要用单双引号包裹）；新表中使用了聚合函数的列可以不起别名
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
                      SELECT MIN(avg_sal)
                        FROM (
                          SELECT department_id, AVG(salary) "avg_sal"
                          FROM employees
                          GROUP BY department_id
                        ) t_dept_avg_sal
                      )
                      

-- 方式2：使用多行比较操作符ALL
-- 所有部门的平均工资进行比较，小于等于所有平均工资（这里主要取的是等于）的即为目标部门
-- 小于等于所有平均工资，即小于等于所有平均工资的最小值
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= ALL (
                        SELECT AVG(salary)
                        FROM employees
                        GROUP BY department_id
                      )




-- 相关子查询

-- 查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
-- 方式1：相关子查询
SELECT last_name, salary, department_id
FROM employees e1
WHERE salary > (
                SELECT AVG(salary)
                FROM employees
                WHERE department_id = e1.department_id
                )

-- 方式2：在FROM中使用子查询
-- 把所有部门的平均工资作为一张新表
SELECT e1.last_name, e1.salary, e1.department_id
FROM employees e1
JOIN (
  SELECT department_id, AVG(salary) "dept_avg_sal"
  FROM employees e2
  GROUP BY department_id
  ) e2
ON e1.department_id = e2.department_id
WHERE e1.salary > e2.dept_avg_sal


-- 若employees表中employee_id与job_history表中employee_id相同的数目不小于2，输出这些相同id的员工的employee_id,last_name和其job_id
-- 查看job_history表
SELECT * FROM job_history;

SELECT e.employee_id, e.last_name, e.job_id
FROM employees e
WHERE 2 <= (
            SELECT COUNT(*)
            FROM job_history
            WHERE employee_id = e.employee_id
           );



-- 查询公司管理者的employee_id，last_name，job_id，department_id信息
-- 方式1：自连接
SELECT DISTINCT e1.employee_id, e1.last_name, e1.job_id, e1.department_id
FROM employees e1 JOIN employees e2
ON e1.employee_id = e2.manager_id;

-- 方式2：子查询，使用EXISTS
-- 在子查询中查找所有的管理者id，再用EXISTS关键字，检查所有员工id在子查询中是否存在对应id
SELECT e1.employee_id, e1.last_name, e1.job_id, e1.department_id
FROM employees e1
WHERE EXISTS (
              SELECT *
              FROM employees e2
              WHERE e2.manager_id = e1.employee_id
             )

-- 方式3：子查询，使用IN
-- 在子查询中筛选出所有的管理者id，再遍历员工id查看是否存在于管理者id中
SELECT employee_id,last_name,job_id,department_id
FROM employees
WHERE employee_id IN (
                      SELECT DISTINCT manager_id
                      FROM employees
                     );
  



-- 查找比Abel工资高的员工
-- 方式1：自连接
-- 在e1表中查找Abel，再把Abel的工资与e2表中的员工进行比较
-- SQL99写法
SELECT e2.last_name, e2.salary
FROM employees e1 JOIN employees e2
ON e1.salary < e2.salary
WHERE e1.last_name = 'Abel';

-- SQL92写法
SELECT e2.last_name, e2.salary
FROM employees e1, employees e2
WHERE e1.last_name = 'Abel'
AND e1.salary < e2.salary;

-- 方式2：子查询
SELECT last_name, salary
FROM employees
WHERE salary > (
                SELECT salary
                FROM employees
                WHERE last_name = 'Abel'
               )