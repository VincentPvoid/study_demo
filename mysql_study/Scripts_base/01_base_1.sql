-- 选择（使用）指定数据库
USE testtable;

-- 查看指定数据库的所有表
SHOW tables;
-- 如果之前没有写use，需要指定数据库
SHOW tables FROM testtable;

-- 这是一个查询语句
-- 查看一个表的所有数据
SELECT * FROM test;

-- 添加一条记录
INSERT INTO test values (2, 'Doll');

-- 查看表的创建信息
SHOW CREATE TABLE test;