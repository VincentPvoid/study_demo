-- 约束 练习

-- 基础练习
-- 练习1
-- 已经存在数据库test04_emp，两张表emp2和dept2
CREATE DATABASE IF NOT EXISTS test04_emp CHARACTER SET 'utf8';

-- -- 删除test04_emp数据库
-- DROP DATABASE test04_emp;

USE test04_emp;
CREATE TABLE emp2(
  `id` INT,
  emp_name VARCHAR(15)
);
CREATE TABLE dept2(
  `id` INT,
  dept_name VARCHAR(15)
);

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp2';
SELECT * FROM information_schema.table_constraints WHERE table_name = 'dept2';

DESC emp2;
DESC dept2;

-- 1.向表emp2的id列中添加PRIMARY KEY约束
ALTER TABLE emp2 ADD PRIMARY KEY (`id`);


-- 2. 向表dept2的id列中添加PRIMARY KEY约束
ALTER TABLE dept2 ADD PRIMARY KEY (`id`);


-- 3. 向表emp2中添加列dept_id，并在其中定义FOREIGN KEY约束，与之相关联的列是dept2表中的id列。
ALTER TABLE emp2 ADD dept_id INT;
ALTER TABLE emp2 ADD CONSTRAINT fk_emp2_deptid FOREIGN KEY(dept_id) REFERENCES dept2(`id`);


-- 删除外键约束
-- 1.查看外键约束索引名
SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp2';
-- 2. 删除外键约束
ALTER TABLE emp2 DROP FOREIGN KEY fk_emp2_deptid;
-- 3. 删除对应的列
ALTER TABLE emp2 DROP dept_id;



##########################################################################################



-- 练习2
-- 承接 数据处理增删改 案例 (09_data_CUD_case.sql)
-- 1、创建数据库test01_library （此处该数据库已经存在）
CREATE DATABASE IF NOT EXISTS test01_library CHARACTER SET 'utf8';

USE test01_library;

SELECT * FROM books;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'books';


-- 2、创建表 books，表结构如下：
-- 查看09_data_CUD_case.sql，已经创建完成


-- 3、使用ALTER语句给books按如下要求增加相应的约束
-- 为id增加主键约束
ALTER TABLE books ADD PRIMARY KEY (`id`);
-- 为id指定自增约束
ALTER TABLE books MODIFY `id` INT AUTO_INCREMENT;

-- 为name、authors、price、pubdate、num增加非空约束
ALTER TABLE books MODIFY `name` VARCHAR(50) NOT NULL;
ALTER TABLE books MODIFY authors VARCHAR(100) NOT NULL;
ALTER Table books MODIFY price FLOAT NOT NULL;
ALTER TABLE books MODIFY pubdate YEAR NOT NULL;
ALTER TABLE books MODIFY num INT NOT NULL;



##########################################################################################



-- 练习3
-- 1. 创建数据库test05_company
CREATE DATABASE IF NOT EXISTS test05_company CHARACTER SET 'utf8';

USE test05_company;

SELECT DATABASE();


-- 2. 按照下表给出的表结构在test05_company数据库中创建两个数据表offices和employees
CREATE TABLE IF NOT EXISTS offices(
  officeCode INT,
  city VARCHAR(50) NOT NULL,
  `address` VARCHAR(50),
  country VARCHAR(50) NOT NULL,
  postalCode VARCHAR(15) UNIQUE,
  -- 把officeCode设置为主键并起约束名
  CONSTRAINT offices_office_code_pk PRIMARY KEY(officeCode)
);

CREATE TABLE IF NOT EXISTS employees(
  employeeNumber INT PRIMARY KEY AUTO_INCREMENT,
  lastName VARCHAR(50) NOT NULL,
  firstName VARCHAR(50) NOT NULL,
  mobile VARCHAR(25) UNIQUE,
  officeCode INT NOT NULL,
  jobTitle VARCHAR(50) NOT NULL,
  birth DATETIME NOT NULL,
  note VARCHAR(255),
  sex VARCHAR(5),
  CONSTRAINT fk_emp_offcode FOREIGN KEY(officeCode) REFERENCES offices(officeCode)
);

SELECT * FROM offices;
SELECT * FROM employees;


-- 3. 将表employees的mobile字段修改到officeCode字段后面
ALTER TABLE employees MODIFY mobile VARCHAR(25) AFTER officeCode;


-- 4. 将表employees的birth字段改名为employee_birth
ALTER TABLE employees CHANGE birth employee_birth DATETIME;


-- 5. 修改sex字段，数据类型为CHAR(1)，非空约束
ALTER TABLE employees MODIFY sex CHAR(1) NOT NULL;


-- 6. 删除字段note
ALTER TABLE employees DROP note;


-- 7. 增加字段名favoriate_activity，数据类型为VARCHAR(100)
ALTER TABLE employees ADD favoriate_activity VARCHAR(100);


-- 8. 将表employees名称修改为employees_info
RENAME TABLE employees
TO employees_info;

SELECT * FROM employees_info;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'employees_info';





##########################################################################################



-- 拓展练习
-- 练习1（对应pdf练习3）
-- 1、创建数据库：test_company
CREATE DATABASE IF NOT EXISTS test06_company CHARACTER SET 'utf8';
USE test06_company;

-- 2、在此数据库下创建如下3表，数据类型，宽度，是否为空根据实际情况自己定义。
 /* A．部门表（departments） ：部门编号（depid），部门名称（depname），部门简介（deinfo）；其中部门编号为主键。
    B．雇员表（emoloyees） ：雇员编号（empid），姓名（name），性别（sex），职称（title），出生日期（birthday），所在部门编号（depid）
      其中
      雇员编号为主键；
      部门编号为外键，外键约束等级为（on update cascade 和on delete set null）；
      性别默认为男；
    C．工资表（salary） ：雇员编号（empid），基本工资（basesalary），职务工资（titlesalary），扣除（deduction）。其中雇员编号为主键。 */
CREATE TABLE IF NOT EXISTS departments(
  depid INT PRIMARY KEY,
  depname VARCHAR(20) NOT NULL,
  deinfo VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS employees(
  empid INT PRIMARY KEY,
  `name` VARCHAR(20) NOT NULL,
  sex CHAR(1) NOT NULL DEFAULT '男',
  title VARCHAR(20) NOT NULL,
  birthday DATE,
  depid INT,
  
  CONSTRAINT fk_emp_depid FOREIGN KEY(depid) REFERENCES departments(depid) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS salary(
  empid INT PRIMARY KEY,
  basesalary DECIMAL(10,2),
  titlesalary DECIMAL(10,2),
  deduction DECIMAL(8,2)
)


-- 3、给工资表（salary）的雇员编号（empid）增加外键约束，外键约束等级为（on update cascade 和on delete cascade）
ALTER TABLE salary 
ADD Foreign Key (empid) REFERENCES employees(empid) ON UPDATE CASCADE ON DELETE CASCADE;


-- 4、添加数据
INSERT INTO departments(depid, depname, deinfo)
VALUES
  (111, '生产部', NULL),
  (222, '销售部', NULL),
  (333, '人事部', '人力资源管理');

INSERT INTO employees(empid, `name`, sex, title, birthday, depid)
VALUES
  (1001, '张三', '男', '高级工程师', '1975-1-1', 111),
  (1002, '李四', '女', '助工', '1985-1-1', 111),
  (1003, '王五', '女', '工程师', '1978-11-11', 222),
  (1004, '张六', DEFAULT, '工程师', '1999-1-1', 222);

INSERT INTO salary(empid, basesalary, titlesalary, deduction)
VALUES
  (1001, 2200, 1100, 200),
  (1002, 1200, 200, NULL),
  (1003, 2900, 700, 200),
  (1004, 1950, 700, 150);

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM salary;


-- 5、查询出每个雇员的雇员编号，姓名，职称，所在部门名称，应发工资（基本工资+职务工资），实发工资（基本工资+职务工资-扣除）。
SELECT e.empid, e.name, e.title, d.depname, 
  (s.basesalary + s.titlesalary) AS 'Wages salary',
  (s.basesalary + titlesalary - IFNULL(s.deduction, 0)) AS 'Net salary'
FROM employees e JOIN departments d
ON e.depid = d.depid
JOIN salary s
ON e.empid = s.empid;


-- 6、查询销售部门的雇员姓名及其基本工资
SELECT e.name, s.basesalary
FROM salary s JOIN employees e
ON s.empid = e.empid
WHERE e.depid IN (
  SELECT depid
  FROM departments
  WHERE depname = '销售部'
)


-- 7、查询姓“张”且年龄小于40的员工的全部信息和年龄
-- TIMESTAMPDIFF(unit, start_date, end_date) 函数
-- unit：表示差值的单位，可以是以下值之一：MICROSECOND（微秒）、SECOND（秒）、MINUTE（分）、HOUR（小时）、DAY（天）、WEEK（周）、MONTH（月）、QUARTER（季度）或 YEAR（年）
SELECT *, TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE()) AS "age"
FROM employees
WHERE `name` LIKE "张%"
AND TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE()) < 40;


-- 8、查询所有男员工的基本工资和职务工资
SELECT e.*, s.basesalary, s.titlesalary
FROM employees e
JOIN salary s 
ON e.empid = s.empid
WHERE e.sex = '男';


-- 9、查询基本工资低于2000的员工姓名和职称、所在部门名称
SELECT e.*, d.depname, s.basesalary
FROM employees e JOIN departments d
ON e.depid = d.depid
JOIN salary s
ON e.empid = s.empid
WHERE s.basesalary < 2000;


-- 10、查询员工总数
SELECT COUNT(*)
FROM employees e;


-- 11、查询部门总数
SELECT COUNT(*)
FROM departments;


-- 12、查询应发工资的平均工资和最高工资、最低工资
SELECT MAX(basesalary + titlesalary), AVG(basesalary + titlesalary), MIN(basesalary + titlesalary)
FROM salary;


-- 13、按照部门统计应发工资的平均工资
SELECT e.depid, AVG(s.basesalary + s.titlesalary)
FROM employees e JOIN salary s
ON e.empid = s.empid
GROUP BY depid;


-- 14、找出部门基本工资的平均工资低于2000的
SELECT e.depid, AVG(s.basesalary)
FROM employees e JOIN salary s
ON e.empid = s.empid
GROUP BY depid
HAVING AVG(s.basesalary) < 2000;


-- 15、查找员工编号、姓名、基本工资、职务工资、扣除，并按照职务升序排列，如果职务相同，再按照基本工资升序排列
SELECT e.empid, e.name, s.basesalary, s.titlesalary, s.deduction
FROM employees e JOIN salary s
ON e.empid = s.empid
ORDER BY e.title ASC, s.basesalary ASC;


-- 16、查询员工编号、姓名，出生日期，及年龄段。其中，如果80年之前出生的，定为“老年”；80后定为“中年”，90后定为“青壮年”
-- 注意CASE前面的,（逗号），如果没有会出错
SELECT *,
  CASE 
    WHEN YEAR(birthday) < 1980 THEN '老年'
    WHEN YEAR(birthday) > 1990 THEN '青壮年'
    ELSE '中年'
  END
FROM employees;


-- 17、查询所有的员工信息，和他所在的部门名称
SELECT e.*, d.depname
FROM employees e LEFT JOIN departments d
ON e.depid = d.depid;


-- 18、查询所有部门信息，和该部门的员工信息
SELECT d.*, e.*
FROM departments d LEFT JOIN employees e
ON d.depid = e.depid;


-- 19、查询所有职位中含“工程师”的男员工的人数
SELECT COUNT(*)
FROM employees
WHERE title LIKE '%工程师%'
AND sex = '男';


-- 20、查询每个部门的男生和女生的人数和平均基本工资
SELECT d.depid, e.sex, COUNT(*), AVG(s.basesalary)
FROM departments d LEFT JOIN employees e
ON d.depid = e.depid
JOIN salary s
ON e.empid = s.empid
GROUP BY d.depid, e.sex



##########################################################################################



-- 练习2（对应pdf练习4）
-- 1、创建一个数据库：test07_school
CREATE DATABASE IF NOT EXISTS test07_school CHARACTER SET 'utf8';
USE test07_school;

-- 2、创建如下表格
CREATE TABLE IF NOT EXISTS departments(
  depNo INT PRIMARY KEY,
  depName VARCHAR(10) NOT NULL,
  depNote VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS teachers(
  `number` INT PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  sex VARCHAR(4),
  birth DATE,
  depNo INT,
  salary FLOAT,
  `address` VARCHAR(100),
  CONSTRAINT fk_tea_dept_depno FOREIGN KEY(depNo) REFERENCES departments(depNo)
);

SELECT * FROM departments;
SELECT * FROM teachers;


-- 3、添加记录
INSERT INTO departments(depNo, depName, depNote)
VALUES
  (601, '软件技术系', '软件技术等专业'),
  (602, '网络技术系', '多媒体技术等专业'),
  (603, '艺术设计系', '广告艺术设计等专业'),
  (604, '管理工程系', '连锁经营管理等专业');

INSERT INTO teachers(`number`, `name`, sex, birth, depNo, salary, `address`)
VALUES
  (2001, 'Tom', '女', '1970-01-10', 602, 4500, '四川省绵阳市'),
  (2002, 'Lucy', '男', '1983-12-18', 601, 2500, '北京市昌平区'),
  (2003, 'Mike', '男', '1990-06-01', 604, 1500, '重庆市渝中区'),
  (2004, 'James', '女', '1980-10-20', 602, 3500, '四川省成都市'),
  (2005, 'Jack', '男', '1975-05-30', 603, 1200, '重庆市南岸区');


-- 4、用SELECT语句查询Teacher表的所有记录。
SELECT * FROM teachers;


-- 5、找出所有其家庭地址中含有“北京”的教师的教工号及部门名称，要求显示结果中各列标题用中文别名表示。
SELECT tea.`number` AS '教工号', d.depName AS '部门名称', tea.*
FROM teachers tea JOIN departments d
ON tea.depNo = d.depNo
WHERE tea.address LIKE '%北京%';


-- 6、获得Teacher表中工资最高的教工号和姓名。
SELECT *
FROM teachers
ORDER BY salary DESC
LIMIT 0, 1;

SELECT *
FROM teachers
WHERE salary = (
  SELECT MAX(salary)
  FROM teachers
)


-- 7、找出所有收入在2500～4000之间的教工号。
SELECT *
FROM teachers
WHERE salary >= 2500
AND salary <= 4000;


-- 8、查找在网络技术系工作的教师的姓名、性别和工资。
SELECT tea.*, d.depName
FROM teachers tea JOIN departments d
ON tea.depNo = d.depNo
WHERE d.depName = '网络技术系';



##########################################################################################



-- 练习3（对应pdf练习5）
-- 1、建立数据库test08_student
CREATE DATABASE IF NOT EXISTS test08_student CHARACTER SET 'utf8';
USE test08_student;

-- 2、建立以下三张表，并插入记录
CREATE TABLE IF NOT EXISTS classes(
  pro_name VARCHAR(20) NOT NULL,
  grade VARCHAR(10) NOT NULL,
  stu_name VARCHAR(10) NOT NULL,
  gender VARCHAR(4) NOT NULL,
  seat INT NOT NULL
);

CREATE TABLE IF NOT EXISTS scores(
  stu_name VARCHAR(10) NOT NULL,
  en_score INT NOT NULL,
  ma_score INT NOT NULL,
  ch_score INT NOT NULL
);

CREATE TABLE IF NOT EXISTS records(
  stu_name VARCHAR(10) NOT NULL,
  record VARCHAR(10)
);

INSERT INTO classes(pro_name, grade, stu_name, gender, seat)
VALUES
  ('计算机网络', '1班', '张三', '男', 8),
  ('软件工程', '2班', '李四', '男', 12),
  ('计算机维护', '1班', '王五', '男', 9),
  ('计算机网络', '2班', 'LILY', '女', 15),
  ('软件工程', '1班', '小强', '男', 20),
  ('计算机维护', '1班', 'CoCo', '女', 18);

INSERT INTO scores(stu_name, en_score, ma_score, ch_score)
VALUES
  ('张三', 65, 75, 98),
  ('李四', 87, 45, 86),
  ('王五', 98, 85, 65),
  ('LILY', 75, 86, 87),
  ('小强', 85, 60, 58),
  ('CoCo', 96, 87, 70);

INSERT INTO records(stu_name, record)
VALUES
  ('小强', '迟到'),
  ('小强', '事假'),
  ('李四', '旷课'),
  ('李四', '旷课'),
  ('李四', '迟到'),
  ('CoCo', '病假'),
  ('LILY', '事假');

SELECT * FROM classes;
SELECT * FROM scores;
SELECT * FROM records;

-- DELETE FROM scores;

-- 3、写出将张三的语文成绩修改为88的SQL语句。
UPDATE scores
SET ch_score = 88
WHERE stu_name = '张三';


-- 4、搜索出计算机维护1班各门课程的平均成绩。
SELECT *
FROM classes
WHERE pro_name = '计算机维护'
AND grade = '1班';

-- SELECT AVG(en_score), AVG(ma_score), AVG(ch_score),grade_1_service_avg_scores.*
-- FROM scores s JOIN (
--   SELECT *
--   FROM classes
--   WHERE pro_name = '计算机维护'
--   AND grade = '1班'
-- ) grade_1_service_avg_scores
-- WHERE s.stu_name = grade_1_service_avg_scores.stu_name;

SELECT AVG(en_score), AVG(ma_score), AVG(ch_score), cla.grade, cla.pro_name
FROM scores s JOIN classes cla
ON s.stu_name = cla.stu_name
GROUP BY cla.pro_name, cla.grade
HAVING cla.pro_name = '计算机维护' AND cla.grade = '1班';


-- 5、搜索科目有不及格的人的名单。
SELECT cla.*, s.*
FROM classes cla JOIN scores s
ON cla.stu_name = s.stu_name
WHERE s.en_score < 60
OR s.ma_score < 60
OR s.ch_score < 60;



-- 6、查询记录2次以上的学生的姓名和各科成绩。
SELECT DISTINCT s.*
FROM scores s JOIN records r
ON s.stu_name = r.stu_name
WHERE s.stu_name IN (
  SELECT stu_name
  FROM records
  GROUP BY stu_name
  HAVING COUNT(*) > 2
);

SELECT stu_name, COUNT(*)
FROM records
GROUP BY stu_name;

SELECT s.*
FROM scores s JOIN (
  SELECT stu_name, COUNT(*)
  FROM records
  GROUP BY stu_name
  HAVING COUNT(*) > 2
) temp_table
ON s.stu_name = temp_table.stu_name;



##########################################################################################



-- 练习4（对应pdf练习7）
-- 1、建立数据库：test09_library
CREATE DATABASE IF NOT EXISTS test09_library CHARACTER SET 'utf8';
USE test09_library;


-- 2、建立如下三个表： 表一：press 出版社 属性：编号pressid(int)、名称pressname(varchar)、地址address(varchar)
--   表二：sort 种类 属性：编号sortno(int)、数量scount(int)
--   表二：book图书 属性：编号bid(int)、名称 bname(varchar)、种类bsortno(int)、出版社编号pressid(int)
CREATE TABLE IF NOT EXISTS press(
  pressid INT PRIMARY KEY,
  pressname VARCHAR(30),
  `address` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS sort(
  sortno INT PRIMARY KEY,
  scount INT
);

CREATE TABLE IF NOT EXISTS books(
  bid INT PRIMARY KEY,
  bname VARCHAR(50),
  bsortno INT,
  pressid INT,
  CONSTRAINT fk_books_press_pid FOREIGN KEY(pressid) REFERENCES press(pressid)
);

ALTER TABLE books ADD CONSTRAINT fk_books_sort_sortno FOREIGN KEY(bsortno) REFERENCES sort(sortno);

SELECT * FROM information_schema.table_constraints WHERE table_name = 'books';
-- DROP TABLE sort;
-- DROP TABLE books;

SELECT * FROM press;
SELECT * FROM sort;
SELECT * FROM books;


-- 3、给sort表中添加一列属性：描述describes(varchar)
ALTER TABLE sort ADD describes VARCHAR(30);


-- 4、向三个表中各插入几条数据
INSERT INTO press(pressid, pressname, `address`)
VALUES
  (100, '外研社', '上海'),
  (101, '北大出版社', '北京'),
  (102, '教育出版社', '北京');
INSERT INTO sort(sortno, scount, describes)
VALUES
  (11, 50, '小说'),
  (12, 300, '科幻'),
  (13, 100, '神话');
INSERT INTO books(bid, bname, bsortno, pressid)
VALUES
  (1, '红与黑', 11, 100),
  (2, '幻城', 12, 102),
  (3, '希腊神话', 13, 102);


-- 5、查询出版社id为100的书的全部信息
SELECT *
FROM books
WHERE pressid = 100;


-- 6、查询出版社为外研社的书的全部信息
SELECT b.*, pr.pressname
FROM books b JOIN press pr
ON b.pressid = pr.pressid
WHERE pressname = '外研社';


-- 7、查询图书数量（scount）大于100的种类
SELECT *
FROM sort
WHERE scount > 100;


-- 8、查询图书种类最多的出版社信息
SELECT s.*, b.pressid
FROM sort s JOIN books b
ON s.sortno  = b.bsortno
ORDER BY s.scount DESC;

SELECT *
FROM press
WHERE pressid = (
  SELECT b.pressid
  FROM sort s JOIN books b
  ON s.sortno  = b.bsortno
  ORDER BY s.scount DESC
  LIMIT 0,1
 )

SELECT * 
FROM press 
WHERE pressid = (
SELECT pressid
  FROM (
      SELECT pressid,bsortno 
      FROM books 
      GROUP BY pressid,bsortno
    ) temp
    GROUP BY pressid
    ORDER BY COUNT(*) DESC
    LIMIT 0,1
)



##########################################################################################



-- 练习5（对应pdf练习8）
-- 1、建立数据库：test10_tour
CREATE DATABASE IF NOT EXISTS test10_tour CHARACTER SET 'utf8';
USE test10_tour;


-- 2、建立如下两个表：
-- agency旅行社表
-- travel旅行线路表
CREATE TABLE IF NOT EXISTS agency(
  `id` INT PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  area_id INT
);
CREATE TABLE IF NOT EXISTS travel(
  t_id INT PRIMARY KEY,
  t_time VARCHAR(20) NOT NULL,
  t_position VARCHAR(20) NOT NULL,
  t_money DOUBLE(10,2),
  a_id INT,
  t_count INT,
  CONSTRAINT fk_travel_agency_id FOREIGN KEY(a_id) REFERENCES agency(`id`)
);

SELECT * FROM agency;
SELECT * FROM travel;


-- 3、添加记录
INSERT INTO agency(`id`, `name`, `address`)
VALUES
  (101, '青年旅行社', '北京海淀'),
  (102, '天天旅行社', '天津海院');

INSERT INTO travel
VALUES
  (1, '5天', '八达岭', 3000, 101, 10),
  (2, '7天', '水长城', 5000, 101, 14),
  (3, '8天', '水长城', 6000, 102, 11);



-- 4、查出旅行线路最多的旅社
SELECT ag.*, COUNT(*)
FROM agency ag JOIN travel tr
ON ag.id = tr.a_id
GROUP BY ag.id
ORDER BY COUNT(*) DESC
LIMIT 0, 1;


-- 5、查出最热门的旅行线路(也就是查询出报名人数最多的线路)
SELECT *
FROM travel
ORDER BY t_count DESC
LIMIT 0, 1;


-- 6、查询花费少于5000的旅行线路
SELECT *
FROM travel
WHERE t_money < 5000;


-- 7、找到一次旅行花费最昂贵的旅行社名
SELECT ag.*, tr.*
FROM agency ag JOIN travel tr
ON ag.id = tr.a_id
ORDER BY tr.t_money DESC
LIMIT 0, 1;


-- 8、查出青年旅社所有的旅行线路都玩一遍需要多少时间
SELECT ag.*, tr.*
FROM agency ag JOIN travel tr
ON ag.id = tr.a_id
WHERE ag.name = '青年旅行社';

SELECT SUM(t_time) 
FROM travel 
WHERE a_id = (
  SELECT `id` 
  FROM agency 
  WHERE `name`='青年旅行社'
);

