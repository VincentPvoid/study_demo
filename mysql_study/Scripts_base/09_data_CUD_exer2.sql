-- 数据处理增删改 练习2


-- 1. 使用现有数据库dbtest11
USE dbtest11;


-- 2. 创建表格pet
CREATE TABLE IF NOT EXISTS pet(
  `name` VARCHAR(20),
  `owner` VARCHAR(20),
  species VARCHAR(20),
  sex CHAR(1),
  birth YEAR,
  death YEAR
);


-- 3. 添加记录
-- 分别插入
INSERT INTO pet(`name`, `owner`, species, sex, birth, death)
VALUES('Fluffy', 'harold', 'Cat', 'f', '2003', '2010');
INSERT INTO pet(`name`, `owner`, species, sex, birth)
VALUES('Claws', 'gwen', 'Cat', 'm', '2004');
INSERT INTO pet(`name`, species, sex, birth)
VALUES('Buffy', 'Dog', 'f', '2009');
INSERT INTO pet(`name`, `owner`, species, sex, birth)
VALUES('Fang', 'benny', 'Dog', 'm', '2000');
INSERT INTO pet(`name`, `owner`, species, sex, birth, death)
VALUES('bowser', 'diane', 'Dog', 'm', '2003', '2009');
INSERT INTO pet(`name`, species, sex, birth)
VALUES('Chirpy', 'Bird', 'f', '2008');

-- 同时插入，无数据的对应位置可以填充为NULL
INSERT INTO pet(`name`, `owner`, species, sex, birth, death)
VALUES
  ('Fluffy', 'harold', 'Cat', 'f', '2003', '2010'),
  ('Claws', 'gwen', 'Cat', 'm', '2004', NULL),
  ('Buffy', NULL, 'Dog', 'f', '2009', NULL),
  ('Fang', 'benny', 'Dog', 'm', '2000', NULL),
  ('bowser', 'diane', 'Dog', 'm', '2003', '2009'),
  ('Chirpy', NULL, 'Bird', 'f', '2008', '2010');

SELECT * FROM pet;


-- 4. 添加字段:主人的生日owner_birth DATE类型。
ALTER TABLE pet 
ADD owner_birth DATE;


-- 5. 将名称为Claws的猫的主人改为kevin
UPDATE pet
SET `owner` = 'kevin'
WHERE `name` = 'Claws'
AND species = 'Cat';


-- 6. 将没有死的狗的主人改为duck
UPDATE pet
SET `owner` = 'duck'
WHERE death IS NULL
AND species = 'Dog';


-- 7. 查询没有主人的宠物的名字；
SELECT `name`
FROM pet
WHERE `owner` IS NULL;


-- 8. 查询已经死了的cat的姓名，主人，以及去世时间；
SELECT `name`, `owner`, death
FROM pet
WHERE death IS NOT NULL
AND species = 'Cat';


-- 9. 删除已经死亡的狗
SET autocommit = FALSE;

DELETE FROM pet
WHERE death IS NOT NULL
AND species = 'Dog';

ROLLBACK;


-- 10. 查询所有宠物信息
SELECT * FROM pet;


DELETE FROM pet;
