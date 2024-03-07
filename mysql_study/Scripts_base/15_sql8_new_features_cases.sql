-- MySQL8其它新特性 案例



-- 新特性1：窗口函数
-- 案例1：假设现在有这样一个数据表，它显示了某购物网站在每个城市每个区的销售额：
USE test14_base_others;

CREATE TABLE IF NOT EXISTS sales(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  city VARCHAR(15),
  county VARCHAR(15),
  sales_value DECIMAL
);

INSERT INTO sales(city,county,sales_value)
VALUES
  ('北京','海淀',10.00),
  ('北京','朝阳',20.00),
  ('上海','黄埔',30.00),
  ('上海','长宁',10.00);
  
SELECT * FROM sales;

-- 需求：现在计算这个网站在每个城市的销售总额、在全国的销售总额、每个区的销售额占所在城市销售额中的比率，以及占总销售额中的比率。
-- 方式1：使用分组和聚合函数
CREATE TEMPORARY TABLE `a` -- 创建临时表
SELECT SUM(sales_value) AS sales_value -- 计算总计金额
FROM sales;
-- 查看临时表 a
SELECT * FROM `a`;

-- 2. 计算每个城市的销售总额并存入临时表 b：
CREATE TEMPORARY TABLE b -- 创建临时表
SELECT city,SUM(sales_value) AS sales_value -- 计算城市销售合计
FROM sales
GROUP BY city;

-- 查看临时表 b 
SELECT * FROM b;

-- 3. 计算各区的销售占所在城市的总计金额的比例，和占全部销售总计金额的比例。可以通过下面的连接查询获得需要的结果：
SELECT s.city AS 城市,s.county AS 区,s.sales_value AS 区销售额,
  b.sales_value AS 市销售额,s.sales_value/b.sales_value AS 市比率,
  `a`.sales_value AS 总销售额,s.sales_value/`a`.sales_value AS 总比率
FROM sales s
JOIN b ON (s.city=b.city) -- 连接市统计结果临时表
JOIN `a` -- 连接总计金额临时表
ORDER BY s.city,s.county;


-- 方式2：使用窗口函数
SELECT city AS 城市,county AS 区,sales_value AS 区销售额,
  SUM(sales_value) OVER(PARTITION BY city) AS 市销售额, -- 计算市销售额
  sales_value/SUM(sales_value) OVER(PARTITION BY city) AS 市比率,
  SUM(sales_value) OVER() AS 总销售额, -- 计算总销售额
  sales_value/SUM(sales_value) OVER() AS 总比率
FROM sales
ORDER BY city,county;




-- 案例2：窗口函数演示
-- 创建表
CREATE TABLE IF NOT EXISTS goods(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  category_id INT,
  category VARCHAR(15),
  `NAME` VARCHAR(30),
  price DECIMAL(10,2),
  stock INT,
  upper_time DATETIME
);
-- 添加数据
INSERT INTO goods(category_id,category,NAME,price,stock,upper_time)
VALUES
  (1, '女装/女士精品', 'T恤', 39.90, 1000, '2020-11-10 00:00:00'),
  (1, '女装/女士精品', '连衣裙', 79.90, 2500, '2020-11-10 00:00:00'),
  (1, '女装/女士精品', '卫衣', 89.90, 1500, '2020-11-10 00:00:00'),
  (1, '女装/女士精品', '牛仔裤', 89.90, 3500, '2020-11-10 00:00:00'),
  (1, '女装/女士精品', '百褶裙', 29.90, 500, '2020-11-10 00:00:00'),
  (1, '女装/女士精品', '呢绒外套', 399.90, 1200, '2020-11-10 00:00:00'),
  (2, '户外运动', '自行车', 399.90, 1000, '2020-11-10 00:00:00'),
  (2, '户外运动', '山地自行车', 1399.90, 2500, '2020-11-10 00:00:00'),
  (2, '户外运动', '登山杖', 59.90, 1500, '2020-11-10 00:00:00'),
  (2, '户外运动', '骑行装备', 399.90, 3500, '2020-11-10 00:00:00'),
  (2, '户外运动', '运动外套', 799.90, 500, '2020-11-10 00:00:00'),
  (2, '户外运动', '滑板', 499.90, 1200, '2020-11-10 00:00:00');

SELECT * FROM goods;


-- 1. 序号函数
-- ① ROW_NUMBER()函数
-- ROW_NUMBER()函数能够对数据中的序号进行顺序显示。
-- 例：查询 goods 数据表中每个商品分类下价格降序排列的各个商品信息。
SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num, 
  id, category_id, category, NAME, price, stock
FROM goods;

-- 例：查询 goods 数据表中每个商品分类下价格最高的3种商品信息。
SELECT *
FROM (
  SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
    `id`, category_id, category, `NAME`, price, stock
  FROM goods) t
WHERE row_num <= 3;


-- ② RANK()函数
-- 使用RANK()函数能够对序号进行并列排序，并且会跳过重复的序号，比如序号为1、1、3。
-- 例：使用RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。
SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
  `id`, category_id, category, `NAME`, price, stock
FROM goods;

-- 例：使用RANK()函数获取 goods 数据表中类别为“女装/女士精品”的价格最高的4款商品信息。
SELECT *
FROM(
  SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
    `id`, category_id, category, `NAME`, price, stock
  FROM goods) t
WHERE category_id = 1 AND row_num <= 4;


-- ③ DENSE_RANK()函数
-- DENSE_RANK()函数对序号进行并列排序，并且不会跳过重复的序号，比如序号为1、1、2。
-- 例：使用DENSE_RANK()函数获取 goods 数据表中各类别的价格从高到低排序的各商品信息。
SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
  `id`, category_id, category, `NAME`, price, stock
FROM goods;

-- 例：使用DENSE_RANK()函数获取 goods 数据表中类别为“女装/女士精品”的价格最高的4款商品信息。
SELECT *
FROM(
  SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
    `id`, category_id, category, `NAME`, price, stock
  FROM goods) t
WHERE category_id = 1 AND row_num <= 3;



-- 2. 分布函数
-- ① PERCENT_RANK()函数
-- PERCENT_RANK()函数是等级值百分比函数。按照如下方式进行计算。
-- (rank - 1) / (rows - 1)
-- 其中，rank的值为使用RANK()函数产生的序号，rows的值为当前窗口的总记录数。
-- 例：计算 goods 数据表中名称为“女装/女士精品”的类别下的商品的PERCENT_RANK值。
-- 写法一：
SELECT RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS r,
PERCENT_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS pr,
  `id`, category_id, category, `NAME`, price, stock
FROM goods
WHERE category_id = 1;

-- 写法二：
SELECT RANK() OVER w AS r,
PERCENT_RANK() OVER w AS pr,
  `id`, category_id, category, `NAME`, price, stock
FROM goods
WHERE category_id = 1 WINDOW w AS (PARTITION BY category_id ORDER BY price DESC);


-- ② CUME_DIST()函数
-- CUME_DIST()函数主要用于查询小于或等于某个值的比例。
-- 例：查询goods数据表中小于或等于当前价格的比例。
SELECT CUME_DIST() OVER(PARTITION BY category_id ORDER BY price ASC) AS cd,
  `id`, category, `NAME`, price
FROM goods;



-- 3. 前后函数
-- ① LAG(expr,n)函数
-- LAG(expr,n)函数返回当前行的前n行的expr的值。
-- 例：查询goods数据表中前一个商品价格与当前商品价格的差值。
SELECT `id`, category, `NAME`, price, pre_price, price - pre_price AS diff_price
FROM (
  SELECT `id`, category, `NAME`, price,LAG(price,1) OVER w AS pre_price
  FROM goods
  WINDOW w AS (PARTITION BY category_id ORDER BY price)
) t;


-- ② LEAD(expr,n)函数
-- LEAD(expr,n)函数返回当前行的后n行的expr的值。
-- 例：查询goods数据表中后一个商品价格与当前商品价格的差值。
SELECT `id`, category, `NAME`, behind_price, price,behind_price - price AS diff_price
FROM(
  SELECT `id`, category, `NAME`, price,LEAD(price, 1) OVER w AS behind_price
  FROM goods 
  WINDOW w AS (PARTITION BY category_id ORDER BY price)
) t;



-- 4. 首尾函数
-- ① FIRST_VALUE(expr)函数
-- FIRST_VALUE(expr)函数返回第一个expr的值。
-- 例：按照价格排序，查询第1个商品的价格信息。
SELECT `id`, category, `NAME`, price, stock,FIRST_VALUE(price) OVER w AS first_price
FROM goods 
WINDOW w AS (PARTITION BY category_id ORDER BY price);


-- ② LAST_VALUE(expr)函数
-- LAST_VALUE(expr)函数返回最后一个expr的值。
-- 例：按照价格排序，查询最后一个商品的价格信息。
SELECT `id`, category, `NAME`, price, stock,LAST_VALUE(price) OVER w AS last_price
FROM goods 
WINDOW w AS (PARTITION BY category_id ORDER BY price);



-- 5. 其他函数
-- ① NTH_VALUE(expr,n)函数
-- NTH_VALUE(expr,n)函数返回第n个expr的值。
-- 例：查询goods数据表中排名第2和第3的价格信息。
SELECT `id`, category, `NAME`, price,NTH_VALUE(price,2) OVER w AS second_price,
  NTH_VALUE(price,3) OVER w AS third_price
FROM goods 
WINDOW w AS (PARTITION BY category_id ORDER BY price);


-- ② NTILE(n)函数
-- NTILE(n)函数将分区中的有序数据分为n个桶，记录桶编号。
-- 例：将goods表中的商品按照价格分为3组。
SELECT NTILE(3) OVER w AS nt,`id`, category, `NAME`, price
FROM goods 
WINDOW w AS (PARTITION BY category_id ORDER BY price);



##################################################################################




-- 新特性2：公用表表达式
-- 准备工作：复制员工和部门表数据
CREATE TABLE IF NOT EXISTS emps_copy
AS
SELECT *
FROM atguigudb.employees;

CREATE TABLE IF NOT EXISTS dept_copy
AS
SELECT *
FROM atguigudb.departments;

-- 案例1：查询员工所在的部门的详细信息
-- 方式一：子查询
SELECT * FROM dept_copy
WHERE department_id IN (
  SELECT DISTINCT department_id
  FROM emps_copy
);

-- 方式二：普通公用表表达式
WITH emp_dept_id
AS (SELECT DISTINCT department_id FROM emps_copy)
SELECT *
FROM dept_copy d JOIN emp_dept_id e
ON d.department_id = e.department_id;



-- 案例2：
-- 对于employees表，包含employee_id，last_name和manager_id三个字段。
-- 如果a是b的管理者，那么，我们可以把b叫做a的下属，如果同时b又是c的管理者，那么c就是b的下属，是a的下下属
-- 查询下下属（层级为3）
-- 使用递归公用表表达式
WITH RECURSIVE cte
AS
(
SELECT employee_id,last_name,manager_id,1 AS n FROM emps_copy WHERE employee_id = 100
-- 种子查询，找到第一代领导
UNION ALL
SELECT a.employee_id,a.last_name,a.manager_id,n+1 FROM emps_copy AS a JOIN cte
ON (a.manager_id = cte.employee_id) -- 递归查询，找出以递归公用表表达式的人为领导的人
)
SELECT employee_id,last_name FROM cte WHERE n >= 3;
