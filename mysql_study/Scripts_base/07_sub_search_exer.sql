-- 子查询 练习
USE atguigudb;

-- 1.查询和Zlotkey相同部门的员工姓名和工资
-- 方式1：自连接
SELECT e1.last_name, e1.salary
FROM employees e1 JOIN employees e2
ON e1.department_id = e2.department_id
WHERE e2.last_name = 'Zlotkey';

-- 方式2：子查询
-- 注意：如果last_name = 'Zlotkey'的记录不止一条，需要使用IN；当前例子只有一条所以也可以使用=
SELECT e1.last_name, e1.salary
FROM employees e1 
WHERE e1.department_id IN (
                          SELECT department_id
                          FROM employees
                          WHERE last_name = 'Zlotkey'
                         )

                     
-- 2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
                SELECT AVG(salary)
                FROM employees
               )
               

-- 3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
-- 方式1：使用ALL
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL (
                    SELECT salary
                    FROM employees
                    WHERE job_id = 'SA_MAN'
                   )

-- 方式2：使用排序和分页
SELECT last_name, job_id, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE job_id = 'SA_MAN'
    ORDER BY salary DESC
    LIMIT 0,1
)


-- 4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
-- 测试，查询和姓名中包含字母u的员工所在的部门
SELECT DISTINCT department_id
FROM employees
WHERE last_name LIKE "%u%"

-- 注意：此处=ANY可替换为IN
SELECT job_id, last_name, department_id
FROM employees
WHERE department_id = ANY (
                            SELECT department_id
                            FROM employees
                            WHERE last_name LIKE "%u%"
                          )


-- 5.查询在部门的location_id为1700的部门工作的员工的员工号
-- 测试，查询location_id为1700的部门id
SELECT department_id
FROM departments
WHERE location_id = 1700;

-- 方式1：相关子查询
SELECT e.department_id, e.employee_id
FROM employees e
WHERE department_id = (
                        SELECT department_id
                        FROM departments
                        WHERE location_id = 1700
                        AND department_id = e.department_id
                      )

-- 方式2：多行子查询
SELECT department_id, employee_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location_id = 1700
)


-- 6.查询管理者是King的员工姓名和工资
-- 方式1：自连接
SELECT e1.last_name, e1.salary, e2.employee_id
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e2.last_name = 'King';

-- 方式2：子查询
-- 注意：last_name为King的员工有2个；虽然为管理者的只有1个，但子查询还是会有多条记录，所以需要使用ANY
SELECT last_name, salary, employee_id
FROM employees
WHERE manager_id IN (
                    SELECT employee_id 
                    FROM employees
                    WHERE last_name = 'King'
                  )


-- 7.查询工资最低的员工信息: last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary = (
                SELECT MIN(salary)
                FROM employees
               )


-- 8.查询平均工资最低的部门信息
-- 方式1：使用ALL
SELECT *
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) <= ALL (
                        SELECT AVG(salary)
                        FROM employees
                        GROUP BY department_id
                       )
                      )

-- 方式2：子查询生成新表
SELECT *
FROM departments
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) = (
                            SELECT MIN(dept_avg_sal)
                            FROM (
                              SELECT department_id, AVG(salary) "dept_avg_sal"
                              FROM employees
                              GROUP BY department_id
                            ) t_dept_avg_sal
  )
)


-- 9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）
SELECT d.*, t_dept_avg_sal.avg_sal
FROM departments d JOIN (
    SELECT department_id, AVG(salary) "avg_sal"
    FROM employees
    GROUP BY department_id
    ORDER BY avg_sal
    LIMIT 0, 1
) t_dept_avg_sal
ON d.department_id = t_dept_avg_sal.department_id


-- 10.查询平均工资最高的 job 信息
-- 测试：查看job表
SELECT * FROM jobs;
-- 测试：查找平均工资最高的job_id
SELECT job_id, AVG(salary) "avg_sal"
FROM employees
GROUP BY job_id
ORDER BY avg_sal DESC
LIMIT 0, 1

SELECT j.*, t_dept_avg_sal.avg_sal
FROM jobs j JOIN (
  SELECT job_id, AVG(salary) "avg_sal"
  FROM employees
  GROUP BY job_id
  ORDER BY avg_sal DESC
  LIMIT 0, 1
) t_dept_avg_sal
ON j.job_id = t_dept_avg_sal.job_id;


-- 11.查询平均工资高于公司平均工资的部门
SELECT department_id, AVG(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) > (
  SELECT AVG(salary)
  FROM employees
)


-- 12.查询出公司中所有 manager 的详细信息
-- 方式1：自连接
SELECT DISTINCT e1.*
FROM employees e1 JOIN employees e2
ON e1.employee_id = e2.manager_id;

-- 方式2：子查询
SELECT e1.*
FROM employees e1
WHERE e1.employee_id IN (
    SELECT manager_id
    FROM employees
    WHERE manager_id = e1.employee_id
)


-- 13.各个部门中 最高工资中最低的那个部门的 最低工资
-- 根据部门分组，查询每组中工资的最大值，然后找出所有值中的最小值，找到该值的对应部门，再找该部门的最低工资
-- 方式1：利用排序寻找最小值
-- 测试：找到目标部门信息
SELECT department_id, MAX(salary) "max_sal"
FROM employees
GROUP BY department_id
ORDER BY max_sal
LIMIT 0,1;

-- 完全使用LIMIT
SELECT department_id, salary
FROM employees
WHERE department_id = (
  SELECT department_id
  FROM employees
  GROUP BY department_id
  ORDER BY MAX(salary)
  LIMIT 0,1
)
ORDER BY salary
LIMIT 0,1;

-- 不完全使用LIMIT
SELECT e.department_id, MIN(salary)
FROM employees e JOIN (
  SELECT department_id
  FROM employees
  GROUP BY department_id
  ORDER BY MAX(salary)
  LIMIT 0,1 
) t_dept_max_sal
ON e.department_id = t_dept_max_sal.department_id
GROUP BY e.department_id;

-- 方式2
-- 测试：查询各个部门的最低工资
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id;
-- 测试：查询各个部门的最高工资
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) IN (
  SELECT MIN(dept_max_sal)
  FROM (
    SELECT department_id, MAX(salary) "dept_max_sal"
    FROM employees
    GROUP BY department_id
  ) t_dept_max_sal
);

-- 方式3：使用ALL
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) <= ALL (
  SELECT MAX(salary)
  FROM employees
  GROUP BY department_id
);


-- 14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
-- 测试：查看部门的平均工资
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary);

-- 方式1：连接departments表
-- 先找出平均工资最高的部门id，通过departments表找到对应的manager_id，再在employees表中查找对应的employee_id
SELECT e.last_name, e.department_id, e.email, e.salary
FROM departments d JOIN (
  SELECT department_id, AVG(salary)
  FROM employees
  GROUP BY department_id
  ORDER BY AVG(salary) DESC
  LIMIT 0, 1
) t_dept_avg_sal
ON d.department_id = t_dept_avg_sal.department_id
JOIN employees e
on d.manager_id = e.employee_id;

-- 方式2：只使用employees表
-- 先找出平均工资最高的部门，再查找在该部门的员工的manager_id，然后用所有员工的employee_id进行比对
SELECT last_name, department_id, email, salary
FROM employees
WHERE employee_id IN (
  SELECT manager_id
  FROM employees e JOIN (
    SELECT department_id, AVG(salary)
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 0, 1
  ) t_dept_avg_sal
  ON e.department_id = t_dept_avg_sal.department_id
)


-- 15. 查询所有部门的部门号，其中不包括job_id是"ST_CLERK"的部门号
-- 注意：注意查询方法，需要先查找job_id='ST_CLERK'的部门，然后使用NOT IN查询；
--   如果先查询job_id不为'ST_CLERK'的部门再用IN查询，则无法查询到没有员工的部门；如果使用左外连接则无法排除目标部门
--   因此当前题目必须先查找出目标部门再进行排除        
SELECT * FROM departments;
SELECT DISTINCT *
FROM employees
WHERE job_id = 'ST_CLERK';

-- 方式1：使用IN
SELECT department_id
FROM departments 
WHERE department_id NOT IN (
  SELECT DISTINCT department_id
  FROM employees
  WHERE job_id = 'ST_CLERK'
);

-- 方式2：使用NOT EXISTS
SELECT d.department_id
FROM departments d
WHERE NOT EXISTS (
  SELECT *
  FROM employees
  WHERE job_id = 'ST_CLERK'
  AND department_id = d.department_id
)


-- 16. 选择所有没有管理者的员工的last_name
SELECT last_name
FROM employees
WHERE manager_id IS NULL;

SELECT last_name
FROM employees e1
WHERE NOT EXISTS (
  SELECT *
  FROM employees e2
  WHERE e1.manager_id = e2.employee_id
)


-- 17．查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan'
-- 方式1：自连接
SELECT e1.employee_id, e1.last_name, e1.hire_date, e1.salary
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e2.last_name = 'De Haan';

-- 方式2：子查询
SELECT e1.employee_id, e1.last_name, e1.hire_date, e1.salary
FROM employees e1
WHERE e1.manager_id IN (
    SELECT employee_id
    FROM employees
    WHERE last_name = 'De Haan'
)


-- 18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询）
SELECT employee_id, last_name, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
    HAVING department_id = e1.department_id
)


-- 19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询）
-- 方式1
-- 测试：查询部门人数
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > 5   
)

-- 方式2
SELECT d.department_name
FROM departments d
WHERE 5 < (
  SELECT COUNT(*)
  FROM employees e
  WHERE e.department_id = d.department_id
)


-- 20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询）
SELECT * FROM departments;
SELECT * FROM locations;

-- 方式1
SELECT country_id
FROM locations
WHERE location_id IN (
  SELECT location_id
  FROM departments
  GROUP BY location_id
  HAVING COUNT(*) > 2
)

-- 方式2
SELECT country_id
FROM locations l
WHERE 2 < (
  SELECT COUNT(*)
  FROM departments d
  WHERE d.location_id = l.location_id
)

-- 21.查询每个部门人数（没有人的部门人数显示为0）
SELECT d.department_id, d.department_name, IFNULL(t_dept_count.dept_count, 0)
FROM departments d LEFT JOIN (
    SELECT department_id, COUNT(*) "dept_count"
    FROM employees
    GROUP BY department_id
) t_dept_count
ON d.department_id = t_dept_count.department_id;