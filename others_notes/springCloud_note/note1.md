# SpringCloud 笔记 01 - 09




## 1 Boot和Cloud版本选型
教程所用版本
Java		        Java17+
cloud		        2023.0.0
boot		        3.2.0
cloud alibaba	  2022.0.0.0-RC2
Maven		        3.9+
MySql		        8.0+


### 1.1 Springboot版本选择

#### 1.1.1 git源码地址
https://github.com/spring-projects/spring-boot/releases/

#### 1.1.2 官网查看Boot版本
![image.png](./img/01/2439ff9f8cb84c4992468bddf83a8c58.png)

#### 1.1.3 SpringBoot3.0崛起
https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Release-Notes

通过上面官网发现，Boot官方强烈建议使用Java17+，升级到3.X以上版本
![image.png](./img/01/add71f26fbd94a069f92115c32aac56c.png)


### 1.2 Springcloud版本选择

#### 1.2.1 git源码地址
https://github.com/spring-cloud

#### 1.2.2 官网查看Cloud版本
Cloud命名规则

SpringCloud的版本关系
 Spring Cloud 采用了英国伦敦地铁站的名称来命名，并由地铁站名称字母A-Z依次类推的形式来发布迭代版本

SpringCloud是一个由许多子项目组成的综合项目，各子项目有不同的发布节奏。为了管理SpringCloud与各子项目的版本依赖关系，发布了一个清单，其中包括了某个SpringCloud版本对应的子项目版本。为了避免SpringCloud版本号与子项目版本号混淆，SpringCloud版本采用了名称而非版本号的命名，这些版本的名字采用了伦敦地铁站的名字，根据字母表的顺序来对应版本时间顺序。例如Angel是第一个版本, Brixton是第二个版本。

当SpringCloud的发布内容积累到临界点或者一个重大BUG被解决后，会发布一个"service releases"版本，简称SRX版本，比如Greenwich.SR2就是SpringCloud发布的Greenwich版本的第2个SRX版本。

![image.png](./img/01/5d3cab12fbd5425a925de82dcd8b52ed.png)

springcloud(截至2023.12.12)
![image.png](./img/01/b6840c24ffc34da089661330c160d0de.png)

[Spring Cloud](https://spring.io/projects/spring-cloud#overview)
![image.png](./img/01/d3dc09e93ae7400f8c1b87077a494c5b.png)


### 1.3 Springcloud Alibaba版本选择

#### 1.3.1 Spring官网看SpringCloud Alibaba版本
[Spring Cloud Alibaba](https://spring.io/projects/spring-cloud-alibaba#learn)
![image.png](./img/01/cc2c79e0a101486ca7930f3af89f3324.png)
有延后情况，非最新版（不推荐）

#### 1.3.2 SpringCloud Alibaba官网Github说明
毕业版本依赖关系(推荐使用)
https://github.com/alibaba/spring-cloud-alibaba/wiki/%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E

版本选择
![image.png](./img/01/3d01eb16474c4da7a29b027f3ccd9460.png)

#### 1.3.3 SpringCloud Alibaba版本
[Spring Cloud Alibaba 参考文档](https://spring-cloud-alibaba-group.github.io/github-pages/2022/zh-cn/2022.0.0.0-RC2.html)


### 1.4 本次讲解定稿版

#### 1.4.1 SpringCloud VS SpringBoot VS SpringCloud Alibaba版本三者制约对应关系
若同时用boot和cloud，由cloud决定boot版本
![image.png](./img/01/609dc535e4014030be1f3ba4e6873a7e.png)


Spring cloud Alibaba毕业版本依赖关系(推荐使用)
https://github.com/alibaba/spring-cloud-alibaba/wiki/%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E

![image.png](./img/01/b62396ed806b4e2e9f45853816f14604.png)
![image.png](./img/01/5e7dd65ccec24762b5d0f5d679d03d9a.png)
![image.png](./img/01/8de24301e1b843eaa41919d3cf1c55f3.png)



## 2 关于Cloud各种组件的停更/升级/替换

### 2.1 微服务零基础理论知识入门
通俗地说，微服务架构就是把一个大系统按业务功能分解成多个职责单一的小系统，每一个小模块尽量专一的只做一件事，并利用简单的方法使多个小系统相互协作，组合成一个大系统后再同意对外提供整体服务。

学科一点地说，专注于单一责任小型功能模块为基础，并利用轻量化机制（通常为HTTP RESTful API）实现通信完成复杂业务搭建的一种架构思想。

SpringCloud = 分布式微服务架构的一站式解决方案，是多种微服务架构落地技术的集合体，俗称微服务全家桶


### 2.2 SpringCloud的作用
让程序员专注于业务逻辑，有第3方支援
![image.png](./img/02/4ad097a6f9754bc8a79f421d5de3c809.png)


### 2.3 本次讲解定稿，速通版
![image.png](./img/02/6dd75ac7dd1346a4ac2fa6d93c26f934.png)


### 2.4 本次讲解定稿，详推版
2018第一季
![image.png](./img/02/c947dd3da7ad4a85aa79d89aaa0e55da.png)


**Netflix OSS被移除的原因**
Netflix公司是目前微服务落地中最成功的公司。它开源了如Eureka、Hystrix、Zuul、Feign、Ribbon等广大开发者熟悉的微服务套件，统称为Netflix OSS。在当时Netflix OSS基本成为微服务组件事实上的标准。但是微服务兴起不久，也就是在2018年前后Netflix宣布其核心组件Eureka、Hystrix、Zuul、Ribbon等进入维护状态，不再进行新特性开发，只修BUG。

这直接影响了Spring Cloud项目的发展路线，Spring官方不得不采取应对措施，在2019年的SpringOne 2019大会中，Spring Cloud宣布Spring Cloud Netflix 项目进入维护末世，并在2020年移除相关的Netflix OSS组件。

**Spring Cloud Netflix项目进入维护模式**
停更不停用
被动修复bugs；不再接受合并请求；不再发布新版本

**由停更引发的“升级惨案”**
明细条目
2020第二季
![image.png](./img/02/e7921f869f69451e8aa043da5208eb07.png)

2024第三季
![image.png](./img/02/eba9db6df71b4ee4900247e0a117535c.png)

<font color=red>备注：被remove掉的组件，不再使用</font>
![image.png](./img/02/a8e54285f8934a3181f478868d59d250.png)




## 3 微服务架构编码Base工程模块构建

### 3.1 订单→支付，业务需求说明
![image.png](./img/03/f31a546005a04efeb0c9ec6ce773e6b2.png)

### 3.2 约定 > 配置 > 编码
Just Do It
Only Do It

### 3.3 IDEA新建Project和Maven父工程

#### 3.3.1 微服务cloud整体聚合Maven父工程Project
Maven父工程步骤

1 New Project
![image.png](./img/03/1def744514d849d1bade630ecdffe013.png)

2 聚合总父工程名字
![image.png](./img/03/90b2bd2454764be1959dc054ddfc5426.png)

3 字符编码
![image.png](./img/03/5373ede8896547c4b08495a2669c4640.png)

4 注解生效激活
![image.png](./img/03/edf2ae4862cc4191a2d4281a456d2d5d.png)

5 java编译版本选17
![image.png](./img/03/ab1c2c4de8e249c2ac50ff189eb14f8b.png)

6 File Type过滤
![image.png](./img/03/a8340ef1ae2a40b1bb2620c33805697c.png)

#### 3.3.2 父工程POM文件内容
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
 
    <groupId>com.atguigu.cloud</groupId>
    <artifactId>mscloudV5</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>pom</packaging>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <hutool.version>5.8.22</hutool.version>
        <lombok.version>1.18.26</lombok.version>
        <druid.version>1.1.20</druid.version>
        <mybatis.springboot.version>3.0.2</mybatis.springboot.version>
        <mysql.version>8.0.11</mysql.version>
        <swagger3.version>2.2.0</swagger3.version>
        <mapper.version>4.2.3</mapper.version>
        <fastjson2.version>2.0.40</fastjson2.version>
        <persistence-api.version>1.0.2</persistence-api.version>
        <spring.boot.test.version>3.1.5</spring.boot.test.version>
        <spring.boot.version>3.2.0</spring.boot.version>
        <spring.cloud.version>2023.0.0</spring.cloud.version>
        <spring.cloud.alibaba.version>2022.0.0.0-RC2</spring.cloud.alibaba.version>
    </properties>
 
    <dependencyManagement>
        <dependencies>
            <!--springboot 3.2.0-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-parent</artifactId>
                <version>${spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--springcloud 2023.0.0-->
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring.cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--springcloud alibaba 2022.0.0.0-RC2-->
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>${spring.cloud.alibaba.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--SpringBoot集成mybatis-->
            <dependency>
                <groupId>org.mybatis.spring.boot</groupId>
                <artifactId>mybatis-spring-boot-starter</artifactId>
                <version>${mybatis.springboot.version}</version>
            </dependency>
            <!--Mysql数据库驱动8 -->
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>${mysql.version}</version>
            </dependency>
            <!--SpringBoot集成druid连接池-->
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid-spring-boot-starter</artifactId>
                <version>${druid.version}</version>
            </dependency>
            <!--通用Mapper4之tk.mybatis-->
            <dependency>
                <groupId>tk.mybatis</groupId>
                <artifactId>mapper</artifactId>
                <version>${mapper.version}</version>
            </dependency>
            <!--persistence-->
            <dependency>
                <groupId>javax.persistence</groupId>
                <artifactId>persistence-api</artifactId>
                <version>${persistence-api.version}</version>
            </dependency>
            <!-- fastjson2 -->
            <dependency>
                <groupId>com.alibaba.fastjson2</groupId>
                <artifactId>fastjson2</artifactId>
                <version>${fastjson2.version}</version>
            </dependency>
            <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
            <dependency>
                <groupId>org.springdoc</groupId>
                <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
                <version>${swagger3.version}</version>
            </dependency>
            <!--hutool-->
            <dependency>
                <groupId>cn.hutool</groupId>
                <artifactId>hutool-all</artifactId>
                <version>${hutool.version}</version>
            </dependency>
            <!--lombok-->
            <dependency>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>${lombok.version}</version>
                <optional>true</optional>
            </dependency>
            <!-- spring-boot-starter-test -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-test</artifactId>
                <version>${spring.boot.test.version}</version>
                <scope>test</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>
```

#### 3.3.3 Maven工程落地细节复习
Maven中的DependencyManagement和Dependencies
dependencyManagement

Maven 使用dependencyManagement 元素来提供了一种管理依赖版本号的方式。

通常会在一个组织或者项目的最顶层的父POM 中看到dependencyManagement 元素。
使用pom.xml 中的dependencyManagement 元素能让所有在子项目中引用一个依赖而不用显式的列出版本号。
Maven会沿着父子层次向上走，直到找到一个拥有dependencyManagement 元素的项目，然后它就会使用这个 dependencyManagement 元素中指定的版本号。

![image.png](./img/03/b14a1e2de68e43c2b47828b721f65e9b.png)

这样做的好处就是：如果有多个子项目都引用同一样依赖，则可以避免在每个使用的子项目里都声明一个版本号，
优势：
1. 这样当想升级或切换到另一个版本时，只需要在顶层父容器里更新，而不需要一个一个子项目的修改 ；
2. 另外如果某个子项目需要另外的一个版本，只需要声明version就可。

*   dependencyManagement里只是声明依赖，并不实现引入，因此子项目需要显式的声明需要用的依赖。
*   如果不在子项目中声明依赖，是不会从父项目中继承下来的，只有在子项目中写了该依赖项并且没有指定具体版本，才会从父项目中继承该项且version和scope都读取自父pom;
*   如果子项目中指定了版本号，那么会使用子项目中指定的jar版本。

**maven中跳过单元测试**
1 配置
```xml
<build> <!-- maven 中跳过单元测试  -->
     <plugins>
         <plugin>
             <groupId >org.apache.maven.plugins </groupId>
             <artifactId >maven-surefire-plugin </artifactId>
             <configuration >
                 <skip>true </skip >
             </configuration>
         </plugin>
     </plugins>
</build>
```

2 IDEA工具支持(推荐)
![image.png](./img/03/63491d06e1064b5babd1ac26126ad1a4.png)

#### 3.3.4 mysql驱动说明
Mysql5
```
便笺
# mysql5.7---JDBC四件套
jdbc.driverClass = com.mysql.jdbc.Driver
jdbc.url= jdbc:mysql://localhost:3306/db2024?useUnicode=true&characterEncoding=UTF-8&useSSL=false
jdbc.user = root
jdbc.password =password
 
 
# Maven的POM文件处理
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.47</version>
</dependency>
```

Mysql8
```
# mysql8.0---JDBC四件套
jdbc.driverClass = com.mysql.cj.jdbc.Driver
jdbc.url= jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
jdbc.user = root
jdbc.password =password
 
 
# Maven的POM
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.11</version>
</dependency>
```

### 3.4 Mapper4之一键生成
mybatis-generator
[MyBatis Generator Core – Introduction to MyBatis Generator](https://mybatis.org/generator/)

MyBatis通用Mapper4官网
https://github.com/abel533/Mapper
本次使用Mapper4

下一代：MyBatis 通用 Mapper5官网
https://github.com/mybatis-mapper/mapper


#### 3.4.1 一键生成步骤
SQL

db2024库t_pay支付信息表SQL
```sql
DROP TABLE IF EXISTS `t_pay`;
 
CREATE TABLE `t_pay` ( 
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pay_no` VARCHAR(50) NOT NULL COMMENT '支付流水号', 
  `order_no` VARCHAR(50) NOT NULL COMMENT '订单流水号', 
  `user_id` INT(10) DEFAULT '1' COMMENT '用户账号ID', 
  `amount` DECIMAL(8,2) NOT NULL DEFAULT '9.9' COMMENT '交易金额', 
  `deleted` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '删除标志，默认0不删除，1删除', 
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间', 
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间', 
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='支付交易表';
 
INSERT INTO t_pay(pay_no,order_no) VALUES('pay17203699','6544bafb424a');
 
SELECT * FROM t_pay;
```

Module
![image.png](./img/03/81373a85fce94cd68c126e458c8be4c8.png)


普通Maven工程
mybatis_generator2024

POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
 
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <!--我自己独一份，只是一个普通Maven工程，与boot和cloud无关-->
    <artifactId>mybatis_generator2024</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
    <dependencies>
        <!--Mybatis 通用mapper tk单独使用，自己独有+自带版本号-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.5.13</version>
        </dependency>
        <!-- Mybatis Generator 自己独有+自带版本号-->
        <dependency>
            <groupId>org.mybatis.generator</groupId>
            <artifactId>mybatis-generator-core</artifactId>
            <version>1.4.2</version>
        </dependency>
        <!--通用Mapper-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper</artifactId>
        </dependency>
        <!--mysql8.0-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <!--persistence-->
        <dependency>
            <groupId>javax.persistence</groupId>
            <artifactId>persistence-api</artifactId>
        </dependency>
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
            <exclusions>
                <exclusion>
                    <groupId>org.junit.vintage</groupId>
                    <artifactId>junit-vintage-engine</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
    </dependencies>
 
    <build>
        <resources>
            <resource>
                <directory>${basedir}/src/main/java</directory>
                <includes>
                    <include>**/*.xml</include>
                </includes>
            </resource>
            <resource>
                <directory>${basedir}/src/main/resources</directory>
            </resource>
        </resources>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.mybatis.generator</groupId>
                <artifactId>mybatis-generator-maven-plugin</artifactId>
                <version>1.4.2</version>
                <configuration>
                    <configurationFile>${basedir}/src/main/resources/generatorConfig.xml</configurationFile>
                    <overwrite>true</overwrite>
                    <verbose>true</verbose>
                </configuration>
                <dependencies>
                    <dependency>
                        <groupId>mysql</groupId>
                        <artifactId>mysql-connector-java</artifactId>
                        <version>8.0.33</version>
                    </dependency>
                    <dependency>
                        <groupId>tk.mybatis</groupId>
                        <artifactId>mapper</artifactId>
                        <version>4.2.3</version>
                    </dependency>
                </dependencies>
            </plugin>
        </plugins>
    </build>
</project>
```

配置
src\main\resources路径下新建
config.properties

Mysql5
```properties
# User表包名
package.name=com.atguigu.cloud
# mysql5.7
jdbc.driverClass = com.mysql.jdbc.Driver
jdbc.url= jdbc:mysql://localhost:3306/db2024?useUnicode=true&characterEncoding=UTF-8&useSSL=false
jdbc.user = root
jdbc.password =password
```

Mysql8
```properties
# t_pay表包名
package.name=com.atguigu.cloud
 
# mysql8.0
jdbc.driverClass = com.mysql.cj.jdbc.Driver
jdbc.url= jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
jdbc.user = root
jdbc.password =password
```

generatorConfig.xml
内容
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
 
<generatorConfiguration>
    <properties resource="config.properties"/>
 
    <context id="Mysql" targetRuntime="MyBatis3Simple" defaultModelType="flat">
        <property name="beginningDelimiter" value="`"/>
        <property name="endingDelimiter" value="`"/>
 
        <plugin type="tk.mybatis.mapper.generator.MapperPlugin">
            <property name="mappers" value="tk.mybatis.mapper.common.Mapper"/>
            <property name="caseSensitive" value="true"/>
        </plugin>
 
        <jdbcConnection driverClass="${jdbc.driverClass}"
                        connectionURL="${jdbc.url}"
                        userId="${jdbc.user}"
                        password="${jdbc.password}">
        </jdbcConnection>
 
        <javaModelGenerator targetPackage="${package.name}.entities" targetProject="src/main/java"/>
 
        <sqlMapGenerator targetPackage="${package.name}.mapper" targetProject="src/main/java"/>
 
        <javaClientGenerator targetPackage="${package.name}.mapper" targetProject="src/main/java" type="XMLMAPPER"/>
 
        <table tableName="t_pay" domainObjectName="Pay">
            <generatedKey column="id" sqlStatement="JDBC"/>
        </table>
    </context>
</generatorConfiguration>
 
```

一键生成
双击插件mybatis-generator:gererate，一键生成entity+mapper接口+xml实现SQL
![image.png](./img/03/e1c65b05bb344e249fdbc42bb4fd2fb9.png)



### 3.5 Rest通用Base工程构建

#### 3.5.1 工程V1

##### 3.5.1.1 cloud-provider-payment8001 微服务提供者支付Module模块
微服务小口诀
1 建module
2 改POM
3 写YML
4 主启动
5 业务类

步骤
建module
建普通Maven模块 cloud-provider-payment8001
![image.png](./img/03/1cc9623344194b61bbc076ab60834314.png)
![image.png](./img/03/470da0168ed94f3fbf6e5cffd984006b.png)

创建完成后，回到父工程查看pom文件变化

改POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-provider-payment8001</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--SpringBoot通用依赖模块-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--SpringBoot集成druid连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
        </dependency>
        <!-- Swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
        <!--mybatis和springboot整合-->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
        </dependency>
        <!--Mysql数据库驱动8 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <!--persistence-->
        <dependency>
            <groupId>javax.persistence</groupId>
            <artifactId>persistence-api</artifactId>
        </dependency>
        <!--通用Mapper4-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper</artifactId>
        </dependency>
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!-- fastjson2 -->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.28</version>
            <scope>provided</scope>
        </dependency>
        <!--test-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

写application.yml
```yml
server:
  port: 8001
 
# ==========applicationName + druid-mysql8 driver===================
spring:
  application:
    name: cloud-payment-service
 
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
 
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
```

主启动（修改Main类名为Main8001）
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;
 
/**
 * @auther zzyy
 * @create 2023-11-03 17:54
 */
@SpringBootApplication
@MapperScan("com.atguigu.cloud.mapper") //import tk.mybatis.spring.annotation.MapperScan;
public class Main8001
{
    public static void main(String[] args)
    {
        SpringApplication.run(Main8001.class,args);
    }
}
```

业务类
将之前一键生成的代码直接拷贝进8001模块

entities
主实体Pay
```java
package com.atguigu.cloud.entities;
 
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.*;
 
/**
 * 表名：t_pay
 * 表注释：支付交易表
*/
@Table(name = "t_pay")
public class Pay {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;
 
    /**
     * 支付流水号
     */
    @Column(name = "pay_no")
    private String payNo;
 
    /**
     * 订单流水号
     */
    @Column(name = "order_no")
    private String orderNo;
 
    /**
     * 用户账号ID
     */
    @Column(name = "user_id")
    private Integer userId;
 
    /**
     * 交易金额
     */
    private BigDecimal amount;
 
    /**
     * 删除标志，默认0不删除，1删除
     */
    private Byte deleted;
 
    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;
 
    /**
     * 更新时间
     */
    @Column(name = "update_time")
    private Date updateTime;
 
    /**
     * @return id
     */
    public Integer getId() {
        return id;
    }
 
    /**
     * @param id
     */
    public void setId(Integer id) {
        this.id = id;
    }
 
    /**
     * 获取支付流水号
     *
     * @return payNo - 支付流水号
     */
    public String getPayNo() {
        return payNo;
    }
 
    /**
     * 设置支付流水号
     *
     * @param payNo 支付流水号
     */
    public void setPayNo(String payNo) {
        this.payNo = payNo;
    }
 
    /**
     * 获取订单流水号
     *
     * @return orderNo - 订单流水号
     */
    public String getOrderNo() {
        return orderNo;
    }
 
    /**
     * 设置订单流水号
     *
     * @param orderNo 订单流水号
     */
    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }
 
    /**
     * 获取用户账号ID
     *
     * @return userId - 用户账号ID
     */
    public Integer getUserId() {
        return userId;
    }
 
    /**
     * 设置用户账号ID
     *
     * @param userId 用户账号ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
 
    /**
     * 获取交易金额
     *
     * @return amount - 交易金额
     */
    public BigDecimal getAmount() {
        return amount;
    }
 
    /**
     * 设置交易金额
     *
     * @param amount 交易金额
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
 
    /**
     * 获取删除标志，默认0不删除，1删除
     *
     * @return deleted - 删除标志，默认0不删除，1删除
     */
    public Byte getDeleted() {
        return deleted;
    }
 
    /**
     * 设置删除标志，默认0不删除，1删除
     *
     * @param deleted 删除标志，默认0不删除，1删除
     */
    public void setDeleted(Byte deleted) {
        this.deleted = deleted;
    }
 
    /**
     * 获取创建时间
     *
     * @return createTime - 创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }
 
    /**
     * 设置创建时间
     *
     * @param createTime 创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
 
    /**
     * 获取更新时间
     *
     * @return updateTime - 更新时间
     */
    public Date getUpdateTime() {
        return updateTime;
    }
 
    /**
     * 设置更新时间
     *
     * @param updateTime 更新时间
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
```

传递数值PayDTO
返回可以显示的非私密字段
```java
package com.atguigu.cloud.entities;
 
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
 
import java.io.Serializable;
import java.math.BigDecimal;
 
/**
 * @auther zzyy
 * @create 2023-11-03 18:58
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PayDTO implements Serializable
{
    private Integer id;
    //支付流水号
    private String payNo;
    //订单流水号
    private String orderNo;
    //用户账号ID
    private Integer userId;
    //交易金额
    private BigDecimal amount;
}
```

mapper
Mapper接口PayMapper
```java
package com.atguigu.cloud.mapper;
 
import com.atguigu.cloud.entities.Pay;
import tk.mybatis.mapper.common.Mapper;
 
public interface PayMapper extends Mapper<Pay> {
}
```

映射文件PayMapper.xml
src\main\resources路径下，新建文件夹mapper。拷贝PayMapper.xml进上一步的mapper文件夹
PayMapper.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.atguigu.cloud.mapper.PayMapper">
  <resultMap id="BaseResultMap" type="com.atguigu.cloud.entities.Pay">
    <!--
      WARNING - @mbg.generated
    -->
    <id column="id" jdbcType="INTEGER" property="id" />
    <result column="pay_no" jdbcType="VARCHAR" property="payNo" />
    <result column="order_no" jdbcType="VARCHAR" property="orderNo" />
    <result column="user_id" jdbcType="INTEGER" property="userId" />
    <result column="amount" jdbcType="DECIMAL" property="amount" />
    <result column="deleted" jdbcType="TINYINT" property="deleted" />
    <result column="create_time" jdbcType="TIMESTAMP" property="createTime" />
    <result column="update_time" jdbcType="TIMESTAMP" property="updateTime" />
  </resultMap>
</mapper>
```


service
服务接口PayService
```java
package com.atguigu.cloud.service;
 
import com.atguigu.cloud.entities.Pay;
 
import java.util.List;
 
public interface PayService
{
    public int add(Pay pay);
    public int delete(Integer id);
    public int update(Pay pay);
    
    public Pay   getById(Integer id);
    public List<Pay> getAll();
}
```

实现类PayServiceImpl
```java
package com.atguigu.cloud.service.impl;
 
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.mapper.PayMapper;
import com.atguigu.cloud.service.PayService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
 
import java.util.List;
 
/**
 * @auther zzyy
 * @create 2023-11-03 18:44
 */
@Service
public class PayServiceImpl implements PayService{
    @Resource
    PayMapper payMapper;
    @Override
    public int add(Pay pay){
        return payMapper.insertSelective(pay);
    }
    @Override
    public int delete(Integer id){
        return payMapper.deleteByPrimaryKey(id);
    }
    @Override
    public int update(Pay pay){
        return payMapper.updateByPrimaryKeySelective(pay);
    }
    @Override
    public Pay getById(Integer id){
        return payMapper.selectByPrimaryKey(id);
    }
    @Override
    public List<Pay> getAll(){
        return payMapper.selectAll();
    }
}
```

controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.service.PayService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;
 
/**
 * @auther zzyy
 * @create 2023-11-03 18:55
 */
@RestController
public class PayController{
    @Resource PayService payService;
    @PostMapping(value = "/pay/add")
    public String addPay(@RequestBody Pay pay){
        System.out.println(pay.toString());
        int i = payService.add(pay);
        return "成功插入记录，返回值："+i;
    }
    @DeleteMapping(value = "/pay/del/{id}")
    public Integer deletePay(@PathVariable("id") Integer id) {
        return payService.delete(id);
    }
    @PutMapping(value = "/pay/update")
    public String updatePay(@RequestBody PayDTO payDTO){
        Pay pay = new Pay();
        BeanUtils.copyProperties(payDTO, pay);
 
        int i = payService.update(pay);
        return "成功修改记录，返回值："+i;
    }
    @GetMapping(value = "/pay/get/{id}")
    public Pay getById(@PathVariable("id") Integer id){
        return payService.getById(id);
    }//全部查询getall作为家庭作业
}
```

Swagger3
常用注解
注解列表
![image.png](./img/03/461e761159c845f685dd46d3eaa132a2.png)

Controller
@Tag
![image.png](./img/03/bb0290e6f9c948e2b9334c1769fdd36a.png)

修改PayController
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.service.PayService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;
 
/**
 * @auther zzyy
 * @create 2023-11-03 18:55
 */
@RestController
@Tag(name = "支付微服务模块",description = "支付CRUD")
public class PayController
{
    @Resource
    PayService payService;
 
    @PostMapping(value = "/pay/add")
    @Operation(summary = "新增",description = "新增支付流水方法,json串做参数")
    public String addPay(@RequestBody Pay pay)
    {
        System.out.println(pay.toString());
        int i = payService.add(pay);
        return "成功插入记录，返回值："+i;
    }
 
    @DeleteMapping(value = "/pay/del/{id}")
    @Operation(summary = "删除",description = "删除支付流水方法")
    public Integer deletePay(@PathVariable("id") Integer id) {
        return payService.delete(id);
    }
 
    @PutMapping(value = "/pay/update")
    @Operation(summary = "修改",description = "修改支付流水方法")
    public String updatePay(@RequestBody PayDTO payDTO)
    {
        Pay pay = new Pay();
        BeanUtils.copyProperties(payDTO, pay);
 
        int i = payService.update(pay);
        return "成功修改记录，返回值："+i;
    }
 
    @GetMapping(value = "/pay/get/{id}")
    @Operation(summary = "按照ID查流水",description = "查询支付流水方法")
    public Pay getById(@PathVariable("id") Integer id)
    {
        return payService.getById(id);
    }
 
    //全部查询getall作为家庭作业
}
```

方法
@Operation
![image.png](./img/03/68b103c5d70b4180a40dd30565faa842.png)


entity或者DTO
@Schema
![image.png](./img/03/8870202dc921416db3e60e36ab11a54f.png)


含分组迭代的Config配置类
Swagger3Config
```java
package com.atguigu.cloud.config;
 
import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
/**
 * @auther zzyy
 * @create 2023-11-04 10:40
 */
@Configuration
public class Swagger3Config
{
    @Bean
    public GroupedOpenApi PayApi()
    {
        return GroupedOpenApi.builder().group("支付微服务模块").pathsToMatch("/pay/**").build();
    }
    @Bean
    public GroupedOpenApi OtherApi()
    {
        return GroupedOpenApi.builder().group("其它微服务模块").pathsToMatch("/other/**", "/others").build();
    }
    /*@Bean
    public GroupedOpenApi CustomerApi()
    {
        return GroupedOpenApi.builder().group("客户微服务模块").pathsToMatch("/customer/**", "/customers").build();
    }*/
 
    @Bean
    public OpenAPI docsOpenApi()
    {
        return new OpenAPI()
                .info(new Info().title("cloud2024")
                        .description("通用设计rest")
                        .version("v1.0"))
                .externalDocs(new ExternalDocumentation()
                        .description("www.atguigu.com")
                        .url("https://yiyan.baidu.com/"));
    }
}
```

调用方式
http://localhost:8001/swagger-ui/index.html


##### 3.5.1.2 上述模块存在问题
1 时间格式问题

2 Java如何设计API接口实现统一格式返回？
影响前端/小程序/app等交互体验和开发
void
数值
String
对象entity
Map
......
看看目前程序返回值情况
故意写了多种返回类值

3 全局异常接入返回的标准格式
有统一返回值+全局统一异常


#### 3.5.2 工程V2
cloud-provider-payment8001 微服务提供者支付Module模块V2改进版++

##### 3.5.2.1 解决：时间格式问题
![image.png](./img/03/d5260de9ecb24d5cbe2cec525331e0f0.png)

```java
/**
 * 创建时间
 */
@Column(name = "create_time")
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
private Date createTime;

/**
 * 更新时间
 */
@Column(name = "update_time")
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
private Date updateTime;
```

##### 3.5.2.2 解决：统一返回值
- 思路
**定义返回标准格式，3大标配**
code状态值：由后端统一定义各种返回结果的状态码
message描述：本次接口调用的结果描述
data数据：本次返回的数据

- 扩展
接口调用时间之类
timestamp: 接口调用时间

- 步骤
新建枚举类ReturnCodeEnum
HTTP请求返回的状态码
![image.png](./img/03/c1f9ff72f7104a9ca045e96c04bc0f75.png)

ReturnCodeEnum
```java
package com.atguigu.cloud.resp;
 
import lombok.Getter;
 
import java.util.Arrays;
 
/**
 * @auther zzyy
 * @create 2023-11-04 11:51
 */
@Getter
public enum ReturnCodeEnum {
    // 1 举值
    /**操作失败**/
    RC999("999","操作XXX失败"),
    /**操作成功**/
    RC200("200","success"),
    /**服务降级**/
    RC201("201","服务开启降级保护,请稍后再试!"),
    /**热点参数限流**/
    RC202("202","热点参数限流,请稍后再试!"),
    /**系统规则不满足**/
    RC203("203","系统规则不满足要求,请稍后再试!"),
    /**授权规则不通过**/
    RC204("204","授权规则不通过,请稍后再试!"),
    /**access_denied**/
    RC403("403","无访问权限,请联系管理员授予权限"),
    /**access_denied**/
    RC401("401","匿名用户访问无权限资源时的异常"),
    RC404("404","404页面找不到的异常"),
    /**服务异常**/
    RC500("500","系统异常，请稍后重试"),
    RC375("375","数学运算异常，请稍后重试"),
 
    INVALID_TOKEN("2001","访问令牌不合法"),
    ACCESS_DENIED("2003","没有权限访问该资源"),
    CLIENT_AUTHENTICATION_FAILED("1001","客户端认证失败"),
    USERNAME_OR_PASSWORD_ERROR("1002","用户名或密码错误"),
    BUSINESS_ERROR("1004","业务逻辑异常"),
    UNSUPPORTED_GRANT_TYPE("1003", "不支持的认证模式");
    
    // 定义一个通用的枚举类
    // 举值 - 构造 - 遍历
    
    
    // 2 构造
    /**自定义状态码**/
    private final String code;
    /**自定义描述信息**/
    private final String message;
 
    ReturnCodeEnum(String code, String message){
        this.code = code;
        this.message = message;
    }
    
    // 3 遍历
    // 3.1 传统版；遍历枚举V1
    public static ReturnCodeEnum getReturnCodeEnumV1(String code) {
      for (ReturnCodeEnum element : ReturnCodeEnum.values()) {
        if(element.getCode().equalsIgnoreCase(code)) {
          return element;
        }
      }
      return null;
    }
    // 3.2 Stream流式计算版；遍历枚举V2
    public static ReturnCodeEnum getReturnCodeEnumV2(String code) {
      return Arrays.stream(ReturnCodeEnum.values()).filter(x -> x.getCode().equalsIgnoreCase(code)).findFirst().orElse(null);
    }
 
 
    /*public static void main(String[] args){
      System.out.println(getReturnCodeEnumV2("200"));
      System.out.println(getReturnCodeEnumV2("200").getCode());
      System.out.println(getReturnCodeEnumV2("200").getMessage());
    }*/
}
```

新建统一定义返回对象ResultData
ResultData<T>
```java
package com.atguigu.cloud.resp;
 
import lombok.Data;
import lombok.experimental.Accessors;
 
/**
 * @auther zzyy
 * @create 2023-11-04 11:59
 */
@Data
@Accessors(chain = true)
public class ResultData<T> {
 
    private String code;/** 结果状态 ,具体状态码参见枚举类ReturnCodeEnum.java*/
    private String message;
    private T data;
    private long timestamp ;
 
 
    public ResultData (){
        this.timestamp = System.currentTimeMillis();
    }
 
    public static <T> ResultData<T> success(T data) {
        ResultData<T> resultData = new ResultData<>();
        
        resultData.setCode(ReturnCodeEnum.RC200.getCode());
        resultData.setMessage(ReturnCodeEnum.RC200.getMessage());
        resultData.setData(data);
        return resultData;
    }
 
    public static <T> ResultData<T> fail(String code, String message) {
        ResultData<T> resultData = new ResultData<>();
        resultData.setCode(code);
        resultData.setMessage(message);
 
        return resultData;
    }
}
```

修改PayController
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.service.PayService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;
 
/**
 * @auther zzyy
 * @create 2023-11-12 22:34
 */
@RestController
@Tag(name = "支付微服务模块",description = "支付CRUD")
public class PayController
{
    @Resource
    PayService payService;
 
    @PostMapping(value = "/pay/add")
    @Operation(summary = "新增",description = "新增支付流水方法,json串做参数")
    public ResultData<String> addPay(@RequestBody Pay pay) {
        System.out.println(pay.toString());
        int i = payService.add(pay);
        return ResultData.success("成功插入记录，返回值："+i);
    }
 
    @DeleteMapping(value = "/pay/del/{id}")
    @Operation(summary = "删除",description = "删除支付流水方法")
    public ResultData<Integer> deletePay(@PathVariable("id") Integer id) {
        int i = payService.delete(id);
        return ResultData.success(i);
    }
 
    @PutMapping(value = "/pay/update")
    @Operation(summary = "修改",description = "修改支付流水方法")
    public ResultData<String> updatePay(@RequestBody PayDTO payDTO)
    {
        Pay pay = new Pay();
        BeanUtils.copyProperties(payDTO, pay);
 
        int i = payService.update(pay);
        return ResultData.success("成功修改记录，返回值："+ i);
    }
 
    @GetMapping(value = "/pay/get/{id}")
    @Operation(summary = "按照ID查流水",description = "查询支付流水方法")
    public ResultData<Pay> getById(@PathVariable("id") Integer id)
    {
        Pay pay = payService.getById(id);
        return ResultData.success(pay);
    }
 
    //全部查询getall作为家庭作业
}
```

- 测试
http://localhost:8001/pay/get/1

- 结论
通过ResultData.success()对返回结果进行包装后返回给前端


查询方法写个bug
```java
if(id == -4) throw new RuntimeException("id不能为负数");
```

##### 3.5.2.3 解决：全局异常接入返回的标准格式
为什么需要全局异常处理器
不用再手写try...catch
当然，如果非要try...catch也是可以的。

新建全局异常类GlobalExceptionHandler
```java
package com.atguigu.cloud.exp;
 
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.resp.ReturnCodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
 
/**
 * @auther zzyy
 * @create 2023-11-04 12:20
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler
{
    /**
     * 默认全局异常处理。
     * @param e the e
     * @return ResultData
     */
    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ResultData<String> exception(Exception e) {
        System.out.println("----come in GlobalExceptionHandler");
        log.error("全局异常信息exception:{}", e.getMessage(), e);
        return ResultData.fail(ReturnCodeEnum.RC500.getCode(),e.getMessage());
    }
}
```

修改Controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.resp.ReturnCodeEnum;
import com.atguigu.cloud.service.PayService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;
 
/**
 * @auther zzyy
 * @create 2023-12-12 22:34
 */
@RestController
@Tag(name = "支付微服务模块",description = "支付CRUD")
public class PayController
{
    @Resource
    PayService payService;
 
    @PostMapping(value = "/pay/add")
    @Operation(summary = "新增",description = "新增支付流水方法,json串做参数")
    public ResultData<String> addPay(@RequestBody Pay pay)
    {
        System.out.println(pay.toString());
        int i = payService.add(pay);
        return ResultData.success("成功插入记录，返回值："+i);
    }
 
    @DeleteMapping(value = "/pay/del/{id}")
    @Operation(summary = "删除",description = "删除支付流水方法")
    public ResultData<Integer> deletePay(@PathVariable("id") Integer id) {
        int i = payService.delete(id);
        return ResultData.success(i);
    }
 
    @PutMapping(value = "/pay/update")
    @Operation(summary = "修改",description = "修改支付流水方法")
    public ResultData<String> updatePay(@RequestBody PayDTO payDTO)
    {
        Pay pay = new Pay();
        BeanUtils.copyProperties(payDTO, pay);
 
        int i = payService.update(pay);
        return ResultData.success("成功修改记录，返回值："+i);
    }
 
    @GetMapping(value = "/pay/get/{id}")
    @Operation(summary = "按照ID查流水",description = "查询支付流水方法")
    public ResultData<Pay> getById(@PathVariable("id") Integer id)
    {
        if(id == -4) throw new RuntimeException("id不能为负数");
 
        Pay pay = payService.getById(id);
        return ResultData.success(pay);
    }
 
    //全部查询getall作为家庭作业
 
    @RequestMapping(value = "/pay/error",method = RequestMethod.GET)
    public ResultData<Integer> getPayError()
    {
        Integer i = Integer.valueOf(200);
        try
        {
            System.out.println("--------come here");
            int data = 10/0;
        }catch (Exception e){
            e.printStackTrace();
            return ResultData.fail(ReturnCodeEnum.RC500.getCode(),e.getMessage());
        }
        return ResultData.success(i);
    }
}
```

#### 3.5.3 目前工程目录结构
![image.png](./img/03/c8b82330e9064e7aa09e8515f404f5ac.png)


### 3.6 引入微服务理念，从这里开始
订单微服务80如何才能调用到支付微服务8001？

#### 3.6.1 cloud-consumer-order80微服务调用者订单Module模块

##### 3.6.1.1 建cloud-consumer-order80

##### 3.6.1.2 改POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-consumer-order80</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--web + actuator-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <!--hutool-all-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!--fastjson2-->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

##### 3.6.1.3 写YML
```yaml
server:
  port: 80
```

##### 3.6.1.4 主启动(修改Main类名为Main80)
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
 
@SpringBootApplication
public class Main80
{
    public static void main(String[] args)
    {
        SpringApplication.run(Main80.class,args);
    }
}
```

##### 3.6.1.5 业务类
entities

传递数值PayDTO
```java
package com.atguigu.cloud.entities;
 
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
 
import java.io.Serializable;
import java.math.BigDecimal;
 
/**
 * 一般而言，调用者不应该获悉服务提供者的entity资源并知道表结构关系，所以服务
   提供方给出的接口文档都都应成为DTO
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PayDTO implements Serializable
{
    private Integer id;
    //支付流水号
    private String payNo;
    //订单流水号
    private String orderNo;
    //用户账号ID
    private Integer userId;
    //交易金额
    private BigDecimal amount;
}
```
ResultData统一返回值也从8001拷贝进来

#### RestTemplate
RestTemplate提供了多种便捷访问远程Http服务的方法， 
是一种简单便捷的访问restful服务模板类，是Spring提供的用于访问Rest服务的客户端模板工具集

官网地址
[RestTemplate (Spring Framework 6.0.11 API)](https://docs.spring.io/spring-framework/docs/6.0.11/javadoc-api/org/springframework/web/client/RestTemplate.html)

常用API使用说明
使用说明

使用
使用restTemplate访问restful接口非常的简单粗暴无脑。
(url, requestMap, ResponseBean.class)这三个参数分别代表 **REST请求地址、请求参数、HTTP响应转换被转换成的对象类型**。

![image.png](./img/03/fc03b1df5e204701a3b491f8dbd5c4d8.png)


getForObject方法/getForEntity方法
返回对象为响应体中数据转化成的对象，基本上可以理解为Json
![image.png](./img/03/74e44aadb4414eeabac80e1c10f260ae.png)


返回对象为ResponseEntity对象，包含了响应中的一些重要信息，比如响应头、响应状态码、响应体等
![image.png](./img/03/1f3d60f027a34968a5d682f8d16ac871.png)

postForObject/postForEntity
![image.png](./img/03/7a3514e597bc4bccb32708ce7d388763.png)

GET请求方法
```java
<T> T getForObject(String url, Class<T> responseType, Object... uriVariables);
 
<T> T getForObject(String url, Class<T> responseType, Map<String, ?> uriVariables);
 
<T> T getForObject(URI url, Class<T> responseType);
 
<T> ResponseEntity<T> getForEntity(String url, Class<T> responseType, Object... uriVariables);
 
<T> ResponseEntity<T> getForEntity(String url, Class<T> responseType, Map<String, ?> uriVariables);
 
<T> ResponseEntity<T> getForEntity(URI var1, Class<T> responseType);
```

POST请求方法
```java
<T> T postForObject(String url, @Nullable Object request, Class<T> responseType, Object... uriVariables);
 
<T> T postForObject(String url, @Nullable Object request, Class<T> responseType, Map<String, ?> uriVariables);
 
<T> T postForObject(URI url, @Nullable Object request, Class<T> responseType);
 
<T> ResponseEntity<T> postForEntity(String url, @Nullable Object request, Class<T> responseType, Object... uriVariables);
 
<T> ResponseEntity<T> postForEntity(String url, @Nullable Object request, Class<T> responseType, Map<String, ?> uriVariables);
 
<T> ResponseEntity<T> postForEntity(URI url, @Nullable Object request, Class<T> responseType);
```

config配置类
```java
package com.atguigu.cloud.config;
 
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
 
@Configuration
public class RestTemplateConfig {
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
 
@RestController
public class OrderController{
    public static final String PaymentSrv_URL = "http://localhost:8001";//先写死，硬编码
    @Autowired
    private RestTemplate restTemplate;
 
    /**
     * 一般情况下，通过浏览器的地址栏输入url，发送的只能是get请求
     * 我们底层调用的是post方法，模拟消费者发送get请求，客户端消费者
     * 参数可以不添加@RequestBody
     * @param payDTO
     * @return
     */
    @GetMapping("/consumer/pay/add")
    public ResultData addOrder(PayDTO payDTO){
        return restTemplate.postForObject(PaymentSrv_URL + "/pay/add",payDTO,ResultData.class);
    }
    // 删除+修改操作作为家庭作业，O(∩_∩)O。。。。。。。
    @GetMapping("/consumer/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable("id") Integer id){
        return restTemplate.getForObject(PaymentSrv_URL + "/pay/get/"+id, ResultData.class, id);
    }
}
```

##### 3.6.1.6 Postman测试
http://localhost/consumer/pay/get/1
http://localhost/consumer/pay/add?payNo=1213&orderNo=1213&userId=2&amount=3.33


#### 3.6.2 工程重构

###### 3.6.2.1 观察问题
![image.png](./img/03/27ce9a54ee7b41928e7d2f76777bbbd1.png)
系统中有重复部分，重构 

##### 3.6.2.2 新建Module
cloud-api-commons
对外暴露通用的组件/api/接口/工具类等

##### 3.6.2.3 改POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV6</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-api-commons</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--SpringBoot通用依赖模块-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
    </dependencies>
 
</project>
```

##### 3.6.2.4 entities
![image.png](./img/03/94d665ea0fd64ddc8cd30c02396e4c2d.png)
PayDTO
统一返回

##### 3.6.2.5 全局异常类，可加可不加，酌情

##### 3.6.2.6 maven命令clean install
![image.png](./img/03/739292dec5ad4dbba40b8b03928781f1.png)

##### 3.6.2.7 订单80和支付8001分别改造
删除各自的原先有过的entities和统一返回体等内容

各自粘贴POM内容
```xml
<!-- 引入自己定义的api通用包 -->
<dependency>
    <groupId>com.atguigu.cloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

80
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-consumer-order80</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--web + actuator-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <!--hutool-all-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!--fastjson2-->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

8001
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-provider-payment8001</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--SpringBoot通用依赖模块-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--SpringBoot集成druid连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
        </dependency>
        <!-- Swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
        <!--mybatis和springboot整合-->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
        </dependency>
        <!--Mysql数据库驱动8 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <!--persistence-->
        <dependency>
            <groupId>javax.persistence</groupId>
            <artifactId>persistence-api</artifactId>
        </dependency>
        <!--通用Mapper4-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper</artifactId>
        </dependency>
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!-- fastjson2 -->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.28</version>
            <scope>provided</scope>
        </dependency>
        <!--test-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
 
</project>
```

##### 3.6.2.8 postman测试
http://localhost/consumer/pay/get/1

http://localhost/consumer/pay/add?payNo=1213&orderNo=1213&userId=2&amount=3.33


#### 3.6.3 目前工程样图
![image.png](./img/03/4f4d0172de7b40dc9581ba64235ca92f.png)


#### 3.6.4 引入微服务原因
上一步controller问题

硬编码写死问题
![image.png](./img/03/21ed697700dd492994c7d98fc29b8d77.png)

微服务所在的IP地址和端口号硬编码到订单微服务中，会存在非常多的问题
（1）如果订单微服务和支付微服务的IP地址或者端口号发生了变化，则支付微服务将变得不可用，需要同步修改订单微服务中调用支付微服务的IP地址和端口号。

（2）如果系统中提供了多个订单微服务和支付微服务，则无法实现微服务的负载均衡功能。

（3）如果系统需要支持更高的并发，需要部署更多的订单微服务和支付微服务，硬编码订单微服务则后续的维护会变得异常复杂。

所以，在微服务开发的过程中，**需要引入服务治理功能，实现微服务之间的动态注册与发现，从此刻开始正式进入SpringCloud实战**



## 4 Consul服务注册与发现
![image.png](./img/04/39c909e9ceb541b9b8a3fa53affda255.png)

### 4.1 引入服务注册中心

#### 4.1.1 引入原因
![image.png](./img/04/c0925d2a5fa34b27bd4296e03c15e6cc.png)

微服务所在的IP地址和端口号**硬编码**到订单微服务中，会存在非常多的问题

（1）如果订单微服务和支付微服务的IP地址或者端口号发生了变化，则支付微服务将变得不可用，需要同步修改订单微服务中调用支付微服务的IP地址和端口号。
（2）如果系统中提供了多个订单微服务和支付微服务，则无法实现微服务的负载均衡功能。
（3）如果系统需要支持更高的并发，需要部署更多的订单微服务和支付微服务，硬编码订单微服务则后续的维护会变得异常复杂。

所以，在微服务开发的过程中，**需要引入服务治理功能，实现微服务之间的动态注册与发现，从此刻开始我们正式进入SpringCloud实战**

#### 4.1.2 对照大纲
![image.png](./img/04/39c909e9ceb541b9b8a3fa53affda255.png)

### 4.2 不再使用传统老牌的Eureka的原因

#### 4.2.1 Eureka停更进维
[Home · Netflix/eureka Wiki · GitHub](https://github.com/Netflix/eureka/wiki)

![image.png](./img/04/e8cb403bc9cc4fa5bea7d6768048cbdb.png)

#### 4.2.2 Eureka对初学者不友好
首次看到自我保护机制
![image.png](./img/04/07dfea6e23be4df6890a3ea53e46e672.png)

#### 4.2.3 注册中心独立且和微服务功能解耦
目前主流服务中心，希望单独隔离出来而不是作为一个独立微服务嵌入到系统中
![image.png](./img/04/91a056daec5344bf84a9718ea0bd42af.png)

按照Netflix的之前的思路，注册中心Eureka也是作为一个微服务且需要程序员自己开发部署；

实际情况，
希望微服务和注册中心分离解耦，注册中心和业务无关的，不要混为一谈。
提供类似tomcat一样独立的组件，微服务注册上去使用，是个成品。

#### 4.2.4 阿里巴巴Nacos的崛起
Service discovery and configuration management​


### 4.3 consul简介

#### 4.3.1 consul是什么
consul官网地址：[Consul by HashiCorp](https://www.consul.io/)

What is Consul?
Consul 是一套开源的分布式服务发现和配置管理系统，由 HashiCorp 公司用 **Go 语言开发**。

提供了微服务系统中的服务治理、配置中心、控制总线等功能。这些功能中的每一个都可以根据需要单独使用，也可以一起使用以构建全方位的服务网格，总之Consul提供了一种完整的服务网格解决方案。它具有很多优点。包括： 基于 raft 协议，比较简洁； 支持健康检查, 同时支持 HTTP 和 DNS 协议 支持跨数据中心的 WAN 集群 提供图形界面 跨平台，支持 Linux、Mac、Windows

![image.png](./img/04/604d9c6aa3b548e39064585c260b993a.png)

[What is Consul? | Consul | HashiCorp Developer](https://developer.hashicorp.com/consul/docs/intro)

禁止使用问题
条款链接
![image.png](./img/04/a1e35472d70d4ea28eb1a3951607a3a9.png)

[Terms of Evaluation](https://www.hashicorp.com/terms-of-evaluation)

HashiCorp是一家非常知名的基础软件提供商，很多人可能没听过它的名字，但是其旗下的6款主流软件，Terraform、Consul、Vagrant、Nomad、Vault，Packer 相信不少程序员都听说或使用过，尤其是Consul使用者不尽其数。截止目前为止，从HashiCorp 官网上的声明来看，开源项目其实还是“安全”的，**被禁用的只是Vault企业版** (并且原因是Vault产品目前使用的加密算法在中国不符合法规，另一方面是美国出口管制法在涉及加密相关软件上也有相应规定。因此这两项原因使得HashiCorp不得不在声明中说明风险) **而非其他所有开源产品(Terraform、Consul等)** 。因此，大家可以暂时放下心来，放心使用！

![image.png](./img/04/ae7d5a15e8bc43fc92b5f009928412c7.png)

spring consul
[Spring Cloud Consul](https://docs.spring.io/spring-cloud-consul/docs/current/reference/html/)

#### 4.3.2 Consul作用
Consul 具有如下特性：
![image.png](./img/04/45ff8daf8e84404ea91e8a0736f9cfa1.png)

- 服务发现
提供HTTP和DNS两种发现方式。
- 健康监测
支持多种方式，HTTP、TCP、Docker、Shell脚本定制化监控
- KV存储
Key、Value的存储方式
- 多数据中心
Consul支持多数据中心
- 可视化Web界面 

#### 4.3.3 下载
[Install | Consul | HashiCorp Developer](https://developer.hashicorp.com/consul/install)

#### 4.3.4 使用
[Spring Cloud Consul](https://docs.spring.io/spring-cloud-consul/docs/current/reference/html/)

两大作用
![image.png](./img/04/c29f0dde6a1640d899fabf611acd29ba.png)


### 4.4 安装并运行consul
官网下载
[Install | Consul | HashiCorp Developer](https://developer.hashicorp.com/consul/install)

下载完成后只有一个consul.exe文件，对应全路径下查看版本号信息
![image.png](./img/04/6862028d3396427582bcef263618ef50.png)


使用开发模式启动
consul agent -dev
![image.png](./img/04/ea0b8e91d3c249b3958f7670c32ba149.png)

通过以下地址可以访问Consul的首页：http://localhost:8500


### 4.5 服务注册与发现

#### 4.5.1 服务提供者8001
支付服务provider8001注册进consul
POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-provider-payment8001</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--SpringCloud consul discovery -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--SpringBoot通用依赖模块-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--SpringBoot集成druid连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
        </dependency>
        <!-- Swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
        <!--mybatis和springboot整合-->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
        </dependency>
        <!--Mysql数据库驱动8 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <!--persistence-->
        <dependency>
            <groupId>javax.persistence</groupId>
            <artifactId>persistence-api</artifactId>
        </dependency>
        <!--通用Mapper4-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper</artifactId>
        </dependency>
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!-- fastjson2 -->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.28</version>
            <scope>provided</scope>
        </dependency>
        <!--test-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

配置来源
[Quick Start :: Spring Cloud Consul](https://docs.spring.io/spring-cloud-consul/reference/quickstart.html)

YML
```yml
server:
  port: 8001
 
# ==========applicationName + druid-mysql8 driver===================
spring:
  application:
    name: cloud-payment-service
 
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: ${spring.application.name}
 
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
```

主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import tk.mybatis.spring.annotation.MapperScan;
 
/**
 * @auther zzyy
 * @create 2023-11-03 17:54
 */
@SpringBootApplication
@MapperScan("com.atguigu.cloud.mapper") //import tk.mybatis.spring.annotation.MapperScan;
// 需要以下标注，以将微服务注册到服务注册中心（此处服务注册中心为consul）
@EnableDiscoveryClient
public class Main8001 {
    public static void main(String[] args)
    {
        SpringApplication.run(Main8001.class,args);
    }
}
```

@EnableDiscoveryClient 
开启服务发现
启动8001并查看consul控制台
![image.png](./img/04/43eb5e2606a24a7da4060d4b593f947b.png)


#### 4.5.2 服务消费者80
修改微服务cloud-consumer-order80
POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-consumer-order80</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--SpringCloud consul discovery -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--web + actuator-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <!--hutool-all-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!--fastjson2-->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

YML
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true # 优先使用服务ip进行注册
        service-name: ${spring.application.name}
```

主启动类
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
/**
 * @auther zzyy
 * @create 2023-11-04 15:19
 */
@SpringBootApplication
@EnableDiscoveryClient // 该注解用于向使用consul为注册中心时注册服务
public class Main80
{
    public static void main(String[] args)
    {
        SpringApplication.run(Main80.class,args);
    }
}
```

@EnableDiscoveryClient 
开启服务发现
Controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
 
/**
 * @auther zzyy
 * @create 2023-11-04 16:00
 */
@RestController
public class OrderController
{
    //public static final String PaymentSrv_URL = "http://localhost:8001";//先写死，硬编码
 
    public static final String PaymentSrv_URL = "http://cloud-payment-service";//服务注册中心上的微服务名称
 
    @Resource
    private RestTemplate restTemplate;
 
    /**
     * 一般情况下，通过浏览器的地址栏输入url，发送的只能是get请求
     * 我们模拟消费者发送get请求，but底层调用post方法，客户端消费者参数PayDTO可以不添加@RequestBody
     * @param payDTO
     * @return
     */
    @GetMapping("/consumer/pay/add")
    public ResultData addOrder(PayDTO payDTO)
    {
        return restTemplate.postForObject(PaymentSrv_URL + "/pay/add",payDTO,ResultData.class);
    }
 
    // 删除+修改操作作为家庭作业，O(∩_∩)O。。。。。。。
 
    @GetMapping("/consumer/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable Integer id)
    {
        return restTemplate.getForObject(PaymentSrv_URL + "/pay/get/"+id, ResultData.class, id);
    }
}
```

启动80并查看consul控制台
![image.png](./img/04/65e6983bd35b49c1befe317fb779de80.png)

访问测试地址
http://localhost/consumer/pay/get/10


结果
一个bug
java.net.UnknownHostException: cloud-payment-service
![image.png](./img/04/1b30a51f258e4af1af05a7b70a20e75b.png)

配置修改RestTemplateConfig
```java
package com.atguigu.cloud.config;
 
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
 
/**
 * @auther zzyy
 * @create 2023-11-04 15:57
 */
@Configuration
public class RestTemplateConfig
{
    @Bean
    // 开启负载均衡
    @LoadBalanced
    public RestTemplate restTemplate()
    {
        return new RestTemplate();
    }
}
```
@LoadBalanced注解是Spring Cloud框架中的一个注解，用于标记RestTemplate bean，以便在进行服务调用时实现负载均衡。当使用该注解标记RestTemplate bean后，Spring Cloud会自动为其添加负载均衡的功能，使得在进行服务调用时能够自动选择可用的服务实例。

在使用@LoadBalanced注解后，可以通过服务名来调用其他服务，而不需要指定具体的服务实例的地址。Spring Cloud会根据服务名自动选择可用的服务实例，并进行负载均衡，从而实现服务之间的通信。


#### 4.5.3 三个注册中心异同点
![image.png](./img/04/d105a3436d8749f886c5e971abca2a17.png)

**CAP**
C:Consistency（强一致性）
A:Availability（可用性）
P:Partition tolerance（分区容错性）

**经典CAP图**
<font color="red">最多只能同时较好的满足两个。</font>
CAP理论的核心是：一个分布式系统不可能同时很好的满足一致性，可用性和分区容错性这三个需求，
因此，根据 CAP 原理将 NoSQL 数据库分成了满足 CA 原则、满足 CP 原则和满足 AP 原则三 大类：

CA - 单点集群，满足一致性，可用性的系统，通常在可扩展性上不太强大。
CP - 满足一致性，分区容忍必的系统，通常性能不是特别高。
AP - 满足可用性，分区容忍性的系统，通常可能对一致性要求低一些。
![image.png](./img/04/d38daf5f71924da6ac362597549c5057.png)

**AP(Eureka)**
AP架构
当网络分区出现后，为了保证可用性，系统B **可以返回旧值** ，保证系统的可用性。

当数据出现不一致时，虽然A, B上的注册信息不完全相同，但每个Eureka节点依然能够正常对外提供服务，这会出现查询服务信息时如果请求A查不到，但请求B就能查到。如此保证了可用性但牺牲了一致性 **结论：违背了一致性C的要求，只满足可用性和分区容错，即AP**
![image.png](./img/04/1709aebec7634dbc99b1ab28ba1815fb.png)

**CP(Zookeeper/Consul)**
CP架构
当网络分区出现后，为了保证一致性，**就必须拒接请求**，否则无法保证一致性，<font color="red"> Consul 遵循CAP原理中的CP原则，保证了强一致性和分区容错性，且使用的是Raft算法，比zookeeper使用的Paxos算法更加简单。虽然保证了强一致性，但是可用性就相应下降了，例如服务注册的时间会稍长一些，因为 Consul 的 raft 协议要求必须过半数的节点都写入成功才认为注册成功 ；在leader挂掉了之后，重新选举出leader之前会导致Consul 服务不可用。结论：违背了可用性A的要求，只满足一致性和分区容错，即CP </font>
![image.png](./img/04/0aa92f64b3bd4af7b2e675e08906a619.png)


### 4.6 服务配置与刷新
#### 4.6.1 分布式系统面临的 → 配置问题
微服务意味着要将单体应用中的业务拆分成一个个子服务，每个服务的粒度相对较小，因此系统中会出现大量的服务。由于每个服务都需要必要的配置信息才能运行，所以一套集中式的、动态的配置管理设施是必不可少的。比如某些配置文件中的内容大部分都是相同的，只有个别的配置项不同。就拿数据库配置来说，如果每个微服务使用的技术栈都是相同的，则每个微服务中关于数据库的配置几乎都是相同的，有时候主机迁移了，我希望一次修改，处处生效。

当下我们每一个微服务自己带着一个application.yml，上百个配置文件的管理会非常麻烦且复杂

#### 4.6.2 官网说明
![image.png](./img/04/3d394fbdc22a4783a5799860f4de77e2.png)
![image.png](./img/04/bc805c21957d43009a7f4a7ac554dcbf.png)


#### 4.6.3 服务配置案例步骤
##### 4.6.3.1 需求
通用全局配置信息，直接注册进Consul服务器，从Consul获取
既然从Consul获取自然要遵守Consul的配置规则要求

##### 4.6.3.2 修改cloud-provider-payment8001

##### 4.6.3.3 POM
```xml
<!--SpringCloud consul config-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-consul-config</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-bootstrap</artifactId>
</dependency>
```

##### 4.6.3.4 YML
配置规则说明
![image.png](./img/04/7abff8b7b0d3451e8728be8dc13e7f6e.png)

**新增配置文件bootstrap.yml**
applicaiton.yml是用户级的资源配置项
bootstrap.yml是系统级的，**优先级更加高**

Spring Cloud会创建一个“Bootstrap Context”，作为Spring应用的`Application Context`的 **父上下文** 。初始化的时候，Bootstrap Context负责从 **外部源** 加载配置属性并解析配置。这两个上下文共享一个从外部获取的`Environment`。

`Bootstrap`属性有高优先级，默认情况下，它们不会被本地配置覆盖。 `Bootstrap context`和`Application Context`有着不同的约定，所以新增了一个`bootstrap.yml`文件，保证`Bootstrap Context`和`Application Context`配置的分离。

**application.yml文件改为bootstrap.yml,这是很关键的或者两者共存**

因为bootstrap.yml是比application.yml先加载的。bootstrap.yml优先级高于application.yml

bootstrap.yml
```yml
spring:
  application:
    name: cloud-payment-service
    ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: ${spring.application.name}
      config:
        profile-separator: '-' # default value is ","，we update '-'
        format: YAML
 
# config/cloud-payment-service/data
#       /cloud-payment-service-dev/data
#       /cloud-payment-service-prod/data
```

application.yml
```yaml
server:
  port: 8001
 
# ==========applicationName + druid-mysql8 driver===================
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
  profiles:
    active: dev # 多环境配置加载内容dev/prod,不写就是默认default配置
 
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
```

##### 4.6.3.5 consul服务器key/value配置填写
1 参考规则
![image.png](./img/04/0abc2f3e6b3745cf978dd1f528fda954.png)

2 创建config文件夹，以/结尾
![image.png](./img/04/438ec428b3dc4213a3f8ada85a77591e.png)

3 config文件夹下分别创建其它3个文件夹，以/结尾
![image.png](./img/04/5fcc8f696c3548419a6e36226535dceb.png)
cloud-payment-service
cloud-payment-service-dev
cloud-payment-service-prod

4 上述3个文件夹下分别创建data内容，data不再是文件夹
![image.png](./img/04/8b02e549b03248ed8dbab00a37ab5289.png)


##### 4.6.3.6 controller
```java
@Value("${server.port}")
private String port;
 
@GetMapping(value = "/pay/get/info")
private String getInfoByConsul(@Value("${atguigu.info}") String atguiguInfo) {
    return "atguiguInfo: "+atguiguInfo+"\t"+"port: "+port;
}
```
4.6.3.7 测试
```yaml
spring:
   profiles:
     active: dev  #  多环境配置加载内容dev
     
spring:
   profiles:
     active: prod  #  多环境配置加载内容prod
     
spring:
   profiles:
     active:   #  多环境配置加载内容默认
```
通过修改application.yml里面的激活配置部分，进行内容的验证
http://localhost:8001/pay/get/info


#### 4.6.4 动态刷新案例步骤

##### 4.6.4.1 问题
接上一步，我们在consul的dev配置分支修改了内容
马上访问，结果无效
![image.png](./img/04/14b0a2c1f0bf438cadc47cc0177546ea.png)

会发现还是原来的内容，没有做到及时响应和动态刷新


##### 4.6.4.2 步骤
@RefreshScope主启动类添加
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import tk.mybatis.spring.annotation.MapperScan;
 
/**
 * @auther zzyy
 * @create 2023-11-03 17:54
 */
@SpringBootApplication
@MapperScan("com.atguigu.cloud.mapper") //import tk.mybatis.spring.annotation.MapperScan;
@EnableDiscoveryClient // 服务注册和发现
@RefreshScope // 动态刷新
public class Main8001 {
    public static void main(String[] args) {
        SpringApplication.run(Main8001.class,args);
    }
}
```

bootstrap.yml修改下(只为教学实际别改) spring.cloud.consul.config.watch.wait-time
官网说明
默认间隔为55秒
![image.png](./img/04/da35901ae85c4ebab4b437b2c2ad1eda.png)

修改步骤
```yaml
spring:
  application:
    name: cloud-payment-service
    ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        service-name: ${spring.application.name}
      config:
        profile-separator: '-' # default value is ","，we update '-'
        format: YAML
        watch:
          wait-time: 1
 
# config/cloud-payment-service/data
#       /cloud-payment-service-dev/data
#       /cloud-payment-service-prod/data
```

controller
```java
@Value("${server.port}")
private String port;
 
@GetMapping(value = "/pay/get/info")
private String getInfoByConsul(@Value("${atguigu.info}") String atguiguInfo)
{
    return "atguiguInfo: "+atguiguInfo+"\t"+"port: "+port;
}
 
```

#### 4.6.5 思考
截止到这，服务配置和动态刷新全部通过，假设我重启Consul，之前的配置还在吗？
引出问题——Consul配置持久化



## 5 LoadBalancer负载均衡服务调用
![image.png](./img/05/39c909e9ceb541b9b8a3fa53affda255.png)

### 5.1 Ribbon目前也进入维护模式
#### 5.1.1 是什么
Spring Cloud Ribbon是基于Netflix Ribbon实现的一套 **客户端负载均衡的工具**。

简单的说，Ribbon是Netflix发布的开源项目，主要功能是提供 **客户端的软件负载均衡算法和服务调用**。Ribbon客户端组件提供一系列完善的配置项如连接超时，重试等。简单的说，就是在配置文件中列出Load Balancer（简称LB）后面所有的机器，Ribbon会自动的帮助你基于某种规则（如简单轮询，随机连接等）去连接这些机器。我们很容易使用Ribbon实现自定义的负载均衡算法。


#### 5.1.2 了解维护模式
![image.png](./img/05/e8bd90ed29f14923a42eb3dcd30783c3.png)

https://github.com/Netflix/ribbon

#### 5.1.3 Ribbon未来替换方案
![image.png](./img/05/6d33d30e7cb247ed8abcf54d4bed4b16.png)
spring-cloud-loadbalancer

### 5.2 spring-cloud-loadbalancer概述

#### 5.2.1 官网
![image.png](./img/05/5fafb76ce52a4302bc9e548e0acb8c88.png)

#### 5.2.2 是什么
**LB负载均衡(Load Balance)是什么**
简单的说就是将用户的请求平摊的分配到多个服务上，从而达到系统的HA（高可用），常见的负载均衡有软件Nginx，LVS，硬件 F5等

**spring-cloud-starter-loadbalancer组件是什么**
Spring Cloud LoadBalancer是由SpringCloud官方提供的一个开源的、简单易用的 **客户端负载均衡器**，它包含在SpringCloud-commons中 **用它来替换了以前的Ribbon组件**。相比较于Ribbon，SpringCloud LoadBalancer不仅能够支持RestTemplate，还支持WebClient（WeClient是Spring Web Flux中提供的功能，可以实现响应式异步请求）

![image.png](./img/05/92b4cce6a7ce40b2b5953aca9211f96e.png)

[Spring Cloud LoadBalancer :: Spring Cloud Commons](https://docs.spring.io/spring-cloud-commons/reference/spring-cloud-commons/loadbalancer.html)

#### 5.2.3 面试题
客户端负载 VS 服务器端负载区别

loadbalancer本地负载均衡客户端 VS Nginx服务端负载均衡区别

Nginx是 **服务器负载均衡**，客户端所有请求都会交给nginx，然后由nginx实现转发请求，即负载均衡是由服务端实现的。

loadbalancer **本地负载均衡**，在调用微服务接口时候，会在注册中心上获取注册信息服务列表之后缓存到JVM本地，从而在本地实现RPC远程服务调用技术。


### 5.3 spring-cloud-loadbalancer负载均衡解析

#### 5.3.1 负载均衡演示案例-理论
架构说明:80通过轮询负载访问8001/8002/8003
![image.png](./img/05/48dc790006534742807f4fc4d9ee9eb6.png)

LoadBalancer 在工作时分成两步：
第一步，先选择ConsulServer从服务端查询并拉取服务列表，知道了它有多个服务(上图3个服务)，这3个实现是完全一样的，
默认轮询调用谁都可以正常执行。类似生活中求医挂号，某个科室今日出诊的全部医生，客户端你自己选一个。

第二步，按照指定的负载均衡策略从server取到的服务注册列表中由客户端自己选择一个地址，所以**LoadBalancer是一个客户端的负载均衡器**。

#### 5.3.2 负载均衡演示案例-实操
官网参考如何正确使用？
[Spring Cloud LoadBalancer :: Spring Cloud Commons](https://docs.spring.io/spring-cloud-commons/reference/spring-cloud-commons/loadbalancer.html)

![image.png](./img/05/6a62a71cf1ea47b793454df8653d4095.png)
![image.png](./img/05/65d668f222684018b5e0800ba1914c36.png)

按照8001拷贝后新建8002微服务
启动Consul，将8001/8002启动后注册进微服务

consul agent -dev
将8001/8002启动后注册进微服务

bug
之前的配置完全消失，没有持久化保存

Consul数据持久化配置并且注册为Windows服务
1. D:\devSoft\consul_1.17.0_windows_386目录下新建：
空文件夹mydata，新建文件consul_start.bat后缀为.bat

2. consul_start.bat内容信息
```bat
@echo.服务启动......  
@echo off  
@sc create Consul binpath= "D:\devSoft\consul_1.17.0_windows_386\consul.exe agent -server -ui -bind=127.0.0.1 -client=0.0.0.0 -bootstrap-expect  1  -data-dir D:\devSoft\consul_1.17.0_windows_386\mydata   "
@net start Consul
@sc config Consul start= AUTO  
@echo.Consul start is OK......success
@pause
```
注意：如果报1067错误，把杀毒软件关闭后再执行bat

3. 右键管理员权限打开
![image.png](./img/05/6cd48f62f7ae4a0b8eff42a95d88eb0f.png)

4. 启动结果
![image.png](./img/05/0f9a98b9276d447c95f3bccc7c17a740.png)

5. win后台
![image.png](./img/05/8b79558f018e464ba0a2c39093f3180f.png)

6. 后续consul的配置数据会保存进mydata文件夹，重启有了
后台自启动Consul测试地址
http://localhost:8001/pay/get/info

订单80模块修改POM并注册进consul，新增LoadBalancer组件
![image.png](./img/05/af805ee8bb8f44f2b72fc1fcc53b2321.png)
```xml
<!--loadbalancer-->
<dependency>
  <groupId>org.springframework.cloud </groupId>
  <artifactId>spring-cloud-starter-loadbalancer </artifactId>
</dependency>
```


订单80模块修改Controller并启动80
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
 
@RestController
public class OrderController {
    //public static final String PaymentSrv_URL = "http://localhost:8001";//先写死，硬编码
 
    public static final String PaymentSrv_URL = "http://cloud-payment-service";//服务注册中心上的微服务名称
 
    @Autowired
    private RestTemplate restTemplate;
 
    /**
     * 一般情况下，通过浏览器的地址栏输入url，发送的只能是get请求
     * 我们模拟消费者发送get请求，but底层调用post方法，客户端消费者参数PayDTO可以不添加@RequestBody
     * @param payDTO
     * @return
     */
    @GetMapping("/consumer/pay/add")
    public ResultData addOrder(PayDTO payDTO) {
        return restTemplate.postForObject(PaymentSrv_URL + "/pay/add",payDTO,ResultData.class);
    }
 
    // 删除+修改操作作为家庭作业，O(∩_∩)O。。。。。。。
 
    @GetMapping("/consumer/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable Integer id) {
        return restTemplate.getForObject(PaymentSrv_URL + "/pay/get/"+id, ResultData.class, id);
    }
 
    @GetMapping(value = "/consumer/pay/get/info")
    private String getInfoByConsul(){
        return restTemplate.getForObject(PaymentSrv_URL + "/pay/get/info", String.class);
    }
}
```

目前consul上的服务
![image.png](./img/05/e8c39c1acb5c4e9caff9e2c014242988.png)


测试
http://localhost/consumer/pay/get/info
通过上述地址，交替访问到了8001/8002
![image.png](./img/05/3a76dc7bff444f94934b4b0de39f72fc.png)
![image.png](./img/05/f42fb88e60fe4f83adb2f1df17b4c4c3.png)


#### 5.3.3 负载均衡演示案例-小总结
编码使用DiscoveryClient动态获取所有上线的服务列表
官网地址：https://docs.spring.io/spring-cloud-consul/reference/discovery.html
![image.png](./img/05/93e1e5aed07e4891bfede7cf5acc8df2.png)

代码解释，修改80微服务的Controller
```java
@Resource
private DiscoveryClient discoveryClient;
@GetMapping("/consumer/discovery")
public String discovery() {
    // 获取所有service
    List<String> services = discoveryClient.getServices();
    for (String element : services) {
        System.out.println(element);
    }
 
    System.out.println("===================================");
    
    // 获取名称为cloud-payment-service的service
    List<ServiceInstance> instances = discoveryClient.getInstances("cloud-payment-service");
    for (ServiceInstance element : instances) {
        System.out.println(element.getServiceId()+"\t"+element.getHost()+"\t"+element.getPort()+"\t"+element.getUri());
    }
 
    return instances.get(0).getServiceId()+":"+instances.get(0).getPort();
}
```

结合前面实操，负载选择原理小总结

<font color="red">负载均衡算法：rest接口第几次请求数 % 服务器集群总数量 = 实际调用服务器位置下标  ，每次服务重启动后rest接口计数从1开始。</font>

List<ServiceInstance> instances = discoveryClient.getInstances("cloud-payment-service");

如：List [0] instances = 127.0.0.1:8002
　　List [1] instances = 127.0.0.1:8001

8001+ 8002 组合成为集群，它们共计2台机器，集群总数为2， 按照轮询算法原理：
当总请求数为1时： 1 % 2 =1 对应下标位置为1 ，则获得服务地址为127.0.0.1:8001
当总请求数位2时： 2 % 2 =0 对应下标位置为0 ，则获得服务地址为127.0.0.1:8002
当总请求数位3时： 3 % 2 =1 对应下标位置为1 ，则获得服务地址为127.0.0.1:8001
当总请求数位4时： 4 % 2 =0 对应下标位置为0 ，则获得服务地址为127.0.0.1:8002
如此类推


### 5.4 负载均衡算法原理

#### 5.4.1 默认算法是什么？有几种？
官网load balancing algorithm
[Spring Cloud LoadBalancer :: Spring Cloud Commons](https://docs.spring.io/spring-cloud-commons/reference/spring-cloud-commons/loadbalancer.html#switching-between-the-load-balancing-algorithms)

默认2种
![image.png](./img/05/096197575b094d3694794e4e59183a4a.png)

轮询
![image.png](./img/05/4176cbdf1260412ab5abed727b8d4588.png)

随机
![image.png](./img/05/f2fbb0cdda1b437291abc956fa2919b4.png)

源码流程浅读，不用深入，非重点

org.springframework.cloud.client.loadbalancer.reactive.ReactiveLoadBalancer
接口ReactiveLoadBalancer

#### 5.4.2 算法切换
从默认的轮询，切换为随机算法，修改RestTemplateConfig

```java
@Configuration
@LoadBalancerClient(
        // 下面的value值大小写一定要和consul里面的名字一样；大小写敏感
        value = "cloud-payment-service",configuration = RestTemplateConfig.class)
public class RestTemplateConfig {
    @Bean
    @LoadBalanced //使用@LoadBalanced注解赋予RestTemplate负载均衡的能力
    public RestTemplate restTemplate(){
        return new RestTemplate();
    }
 
    @Bean
    ReactorLoadBalancer<ServiceInstance> randomLoadBalancer(Environment environment,
                                                            LoadBalancerClientFactory loadBalancerClientFactory) {
        String name = environment.getProperty(LoadBalancerClientFactory.PROPERTY_NAME);
 
        return new RandomLoadBalancer(loadBalancerClientFactory.getLazyProvider(name, ServiceInstanceListSupplier.class), name);
    }
}
```

#### 5.4.3 测试
http://localhost/consumer/pay/get/info



## 6 OpenFeign服务接口调用
![image.png](./img/06/39c909e9ceb541b9b8a3fa53affda255.png)

### 6.1 提问
已经有loadbalancer为什么还要学习OpenFeign?
两个都有道理的话，我日常用那个？

### 6.2 是什么
OpenFeign是什么

#### 6.2.1 官网翻译
Feign是一个 **声明性web服务客户端**。它使编写web服务客户端变得更容易。**使用Feign创建一个接口并对其进行注释**。它具有可插入的注释支持，包括Feign注释和JAX-RS注释。Feign还支持可插拔编码器和解码器。Spring Cloud添加了对Spring MVC注释的支持，以及对使用Spring Web中默认使用的HttpMessageConverter的支持。Spring Cloud集成了Eureka、Spring Cloud CircuitBreaker以及Spring Cloud LoadBalancer，以便在使用Feign时提供负载平衡的http客户端。

![image.png](./img/06/3aca96116416468cacb7d3f6f18089d7.png)

[Spring Cloud OpenFeign](https://docs.spring.io/spring-cloud-openfeign/docs/current/reference/html/#spring-cloud-feign)


#### 6.2.2 GitHub
https://github.com/spring-cloud/spring-cloud-openfeign
openfeign是一个声明式的Web服务客户端

#### 6.2.3 一句话
<font color="red">只需创建一个Rest接口并在该接口上添加注解 @FeignClient 即可</font>

![image.png](./img/06/25315a0448ad4e37af464f160b6bcaca.png)

OpenFeign基本上就是当前微服务之间调用的事实标准


### 6.3 能干嘛
OpenFeign能干什么

前面在使用SpringCloud LoadBalancer+RestTemplate时，利用RestTemplate对http请求的封装处理形成了一套模版化的调用方法。但是在实际开发中，

由于对服务依赖的调用可能不止一处，**往往一个接口会被多处调用，所以通常都会针对每个微服务自行封装一些客户端类来包装这些依赖服务的调用**。所以，OpenFeign在此基础上做了进一步封装，由他来帮助我们定义和实现依赖服务接口的定义。在OpenFeign的实现下，**我们只需创建一个接口并使用注解的方式来配置它(在一个微服务接口上面标注一个@FeignClient注解即可)**，即可完成对服务提供方的接口绑定，统一对外暴露可以被调用的接口方法，大大简化和降低了调用客户端的开发量，也即由服务提供者给出调用接口清单，消费者直接通过OpenFeign调用即可。

OpenFeign同时还集成SpringCloud LoadBalancer

可以在使用OpenFeign时提供Http客户端的负载均衡，也可以集成阿里巴巴Sentinel来提供熔断、降级等功能。而与SpringCloud LoadBalancer不同的是，**通过OpenFeign只需要定义服务绑定接口且以声明式的方法**，优雅而简单的实现了服务调用。

1 可插拔的注解支持，包括Feign注解和JAX-RS注解
2 支持可插拔的HTTP编码器和解码器
3 支持Sentinel和它的Fallback
4 支持SpringCloudLoadBalancer的负载均衡
5 支持HTTP请求和响应的压缩


### 6.4 OpenFeign通用步骤

#### 6.4.1 接口+注解
微服务Api接口+@FeignClient注解标签
架构说明图
![image.png](./img/06/0a0cca559aba4ce0a22abbd05777b6ef.png)

>服务消费者80 → 调用含有 **@FeignClient注解的Api服务接口**  → 服务提供者(8001/8002)

#### 6.4.2 流程步骤

##### 6.4.2.1 建Module
cloud-consumer-feign-order80

Feign在消费端使用
![image.png](./img/06/350c057acfb04b65b17c0263efab27d7.png)

##### 6.4.2.2 改POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-consumer-feign-order80</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--openfeign-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <!--SpringCloud consul discovery-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--web + actuator-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <!--hutool-all-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!--fastjson2-->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

引入依赖
```xml
<!--openfeign-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

##### 6.4.2.3 写YML
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
```

##### 6.4.2.4 主启动(修改类名为MainOpenFeign80)
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
 
/**
 * @auther zzyy
 * @create 2023-11-09 15:12
 */
@SpringBootApplication
@EnableDiscoveryClient // 该注解用于向使用consul为注册中心时注册服务
@EnableFeignClients // 启用feign客户端,定义服务+绑定接口，以声明式的方法优雅而简单的实现服务调用
public class MainOpenFeign80 {
    public static void main(String[] args){
        SpringApplication.run(MainOpenFeign80.class,args);
    }
}
```

主启动类上面配置 @EnableFeignClients 表示开启OpenFeign功能并激活
@EnableFeignClients

##### 6.4.2.5 业务类
按照架构说明图进行编码准备

订单模块要去调用支付模块，订单和支付两个微服务，**需要通过Api接口解耦**，一般不要在订单模块写非订单相关的业务，
自己的业务自己做+其它模块走FeignApi接口调用
![image.png](./img/06/b28176d264f54e6a8135cd927507d555.png)
![image.png](./img/06/2a657ab47ae84ce496675bdd0a8efea6.png)

修改cloud-api-commons通用模块
引入openfeign依赖
```xml
<!--openfeign-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```

新建服务接口PayFeignApi，头上配置@FeignClient注解
@FeignClient
![image.png](./img/06/bade540f80e14fcf97cd82b9eab6a3ea.png)

参考微服务8001的Controller层，新建PayFeignApi接口
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
 
/**
 * @auther zzyy
 * @create 2023-11-09 15:29
 */
@FeignClient(value = "cloud-payment-service")
public interface PayFeignApi {
    /**
     * 新增一条支付相关流水记录
     * @param payDTO
     * @return
     */
    @PostMapping("/pay/add")
    public ResultData addPay(@RequestBody PayDTO payDTO);
 
    /**
     * 按照主键记录查询支付流水信息
     * @param id
     * @return
     */
    @GetMapping("/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable("id") Integer id);
 
    /**
     * openfeign天然支持负载均衡演示
     * @return
     */
    @GetMapping(value = "/pay/get/info")
    public String mylb();
}
```

bug提醒一下
![image.png](./img/06/a382fcf3b69c4054a9d69a8be0fc7a54.png)


拷贝之前的80工程进cloud-consumer-feign-order80，记得去掉部分代码和LoadBalancer不相关特性
修改Controller层的调用
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.apis.PayFeignApi;
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
 
/**
 * @auther zzyy
 * @create 2023-11-09 15:49
 */
@RestController
@Slf4j
public class OrderController{
    @Resource
    private PayFeignApi payFeignApi;
 
    @PostMapping("/feign/pay/add")
    public ResultData addOrder(@RequestBody PayDTO payDTO) {
        System.out.println("第一步：模拟本地addOrder新增订单成功(省略sql操作)，第二步：再开启addPay支付微服务远程调用");
        ResultData resultData = payFeignApi.addPay(payDTO);
        return resultData;
    }
 
    @GetMapping("/feign/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable("id") Integer id){
        System.out.println("-------支付微服务远程调用，按照id查询订单支付流水信息");
        ResultData resultData = payFeignApi.getPayInfo(id);
        return resultData;
    }
 
    /**
     * openfeign天然支持负载均衡演示
     *
     * @return
     */
    @GetMapping(value = "/feign/pay/mylb")
    public String mylb(){
        return payFeignApi.mylb();
    }
}
```

#### 6.4.3 测试
先启动Consul服务器
再启动微服务8001
再启动cloud-consumer-feign-order80

PostMan测试
新增 http://localhost/feign/pay/add
查询 http://localhost/feign/pay/get/1 

再启动微服务8002
http://localhost/feign/pay/mylb
OpenFeign默认集成了LoadBalancer

上述官网说明
![image.png](./img/06/e31cc7510b0f4776a2750bc3a08dce1a.png)
![image.png](./img/06/d6b93f4a09f74d448bcc8dd80920a71a.png)
![image.png](./img/06/b18e93411a4a47cc9a996519019e7280.png)

#### 6.4.4 小总结
![image.png](./img/06/b411db3e83264ae2856e1fdeb3e4de49.png)

### 6.5 OpenFeign高级特性

#### 6.5.1 OpenFeign超时控制
本次OpenFeign的版本要注意，最新版和网络上你看到的配置不一样
![image.png](./img/06/6cff250715574e249f0ff0630e9f9545.png)

在Spring Cloud微服务架构中，大部分公司都是利用OpenFeign进行服务间的调用，而比较简单的业务使用默认配置是不会有多大问题的，但是如果是业务比较复杂，服务要进行比较繁杂的业务计算，那后台很有可能会出现Read Timeout这个异常，因此定制化配置超时时间就有必要了。

**超时设置，故意设置超时演示出错情况，自己使坏写bug**

服务提供方cloud-provider-payment8001故意写暂停62秒钟程序
![image.png](./img/06/3a65361116784934b0efb4d88f57c367.png)

服务调用方cloud-consumer-feign-order80写好捕捉超时异常
![image.png](./img/06/3a588b92567a4d1cb5a19ba92e8b7054.png)

code
![image.png](./img/06/3a588b92567a4d1cb5a19ba92e8b7054.png)

```java
@GetMapping("/feign/pay/get/{id}")
public ResultData getPayInfo(@PathVariable("id") Integer id) {
    System.out.println("-------支付微服务远程调用，按照id查询订单支付流水信息");
    ResultData resultData = null;
    try {
        System.out.println("调用开始-----:"+DateUtil.now());
        resultData = payFeignApi.getPayInfo(id);
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("调用结束-----:"+DateUtil.now());
        ResultData.fail(ReturnCodeEnum.RC500.getCode(),e.getMessage());
    }
    return resultData;
}
```

测试
http://localhost/feign/pay/get/1

错误页面
![image.png](./img/06/cc3f06f575e7418b922fcd9215f008e6.png)

结论
OpenFeign默认等待60秒钟，超过后报错​

官网解释+配置处理
两个关键参数
![image.png](./img/06/7ca9ce7dd37a48f7b43a898a12db4ac6.png)

默认OpenFeign客户端 **等待60秒钟**，但是服务端处理超过规定时间会导致Feign客户端返回报错。
为了避免这样的情况，有时候我们需要设置Feign客户端的超时控制，默认60秒太长或者业务时间太短都不好

yml文件中开启配置：
connectTimeout       连接超时时间
readTimeout             请求处理超时时间

超时配置参考官网要求
![image.png](./img/06/d1aa987e38094a9588c40a12bfc0aa3a.png)
修改cloud-consumer-feign-order80，YML文件里需要开启OpenFeign客户端超时控制

官网出处
[Spring Cloud OpenFeign](https://docs.spring.io/spring-cloud-openfeign/docs/current/reference/html/#spring-cloud-feign-overriding-defaults)
![image.png](./img/06/520877ca85f247fab6133df70e1ff51c.png)


全局配置

关键内容
```yml
spring:
  cloud:
    openfeign:
      client:
        config:
          default:
            #连接超时时间
                      connectTimeout: 3000
            #读取超时时间
                     readTimeout: 3000
```

all
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
                service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
            #连接超时时间
                        connectTimeout: 3000
            #读取超时时间
                        readTimeout: 3000
```

3秒测试
![image.png](./img/06/48c1119f53b84ff680753efa9f2e6bad.png)


指定配置
单个服务配置超时时间

```yml
spring:
  cloud:
    openfeign:
      client:
        config:
 
          # default 设置的全局超时时间，指定服务名称可以设置单个服务的超时时间
          default:
             #连接超时时间
             connectTimeout: 4000
             #读取超时时间
             readTimeout: 4000
 
          # 为serviceC这个服务单独配置超时时间，单个配置的超时时间将会覆盖全局配置
 
          serviceC:
             #连接超时时间
             connectTimeout: 2000
             #读取超时时间
             readTimeout: 2000
```

关键内容
```yml
spring:
  cloud:
    openfeign:
      client:
        config:
          cloud-payment-service:
            #连接超时时间
                      connectTimeout: 5000
            #读取超时时间
                      readTimeout: 5000
```

![image.png](./img/06/e9f48e182b8c44e2962bdc9bb0292f47.png)

```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
                service-name: ${spring.application.name}
    openfeign:
      client:
        config:
         #default:
            #connectTimeout: 4000 #连接超时时间
                        #readTimeout: 4000 #读取超时时间
                   cloud-payment-service:
            connectTimeout: 8000 #连接超时时间
                        readTimeout: 8000 #读取超时时间
```

5秒测试
![image.png](./img/06/ba348ecacccb4a659a7eab12a24ea46a.png)


#### 6.5.2 OpenFeign重试机制
步骤
默认重试是关闭的，给了默认值
![image.png](./img/06/e3f5d05d8f21486d918eb22eaed7b97d.png)

默认关闭重试机制，测试看看
http://localhost/feign/pay/get/1
结果，只会调用一次后就结束
![image.png](./img/06/bb7e7065e8ce48e1a797c3e80eb4111e.png)

开启Retryer功能
新增配置类FeignConfig并修改Retryer配置
```java
package com.atguigu.cloud.config;
 
import feign.Retryer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
/**
 * @auther zzyy
 * @create 2023-11-10 11:09
 */
@Configuration
public class FeignConfig {
    @Bean
    public Retryer myRetryer(){
        //return Retryer.NEVER_RETRY; // Feign默认配置是不走重试策略的
 
        // 最大请求次数为3(1+2)，初始间隔时间为100ms，重试间最大间隔时间为1s
        return new Retryer.Default(100,1,3);
    }
}
```

结果，总体调用3次 
![image.png](./img/06/441a991d966649b68fecdb75cdf6fe14.png)
3 = 1(default)+2

补充
如果你觉得效果不明显的同学，后续演示feign 日志功能的时候再演示，
目前控制台没有看到3次重试过程，只看到结果，正常的，正确的，是feign的日志打印问题


#### 6.5.3 OpenFeign默认HttpClient修改
OpenFeign中httpClient

如果不做特殊配置，OpenFeign默认使用JDK自带的HttpURLConnection发送HTTP请求，
由于默认HttpURLConnection没有连接池、性能和效率比较低，如果采用默认，性能上不是最牛B的，所以加到最大。

替换之前，还是按照超时报错的案例
```java
@GetMapping("/feign/pay/get/{id}")
public ResultData getPayInfo(@PathVariable("id") Integer id) {
    System.out.println("-------支付微服务远程调用，按照id查询订单支付流水信息");
    ResultData resultData = null;
    try{
        System.out.println("---调用开始: "+ DateUtil.now());
        resultData = payFeignApi.getPayInfo(id);
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("---调用结束: "+ DateUtil.now());
        return ResultData.fail(ReturnCodeEnum.RC500.getCode(),e.getMessage());
    }
    return resultData;
}
```

替换之前， 默认用的是什么
![image.png](./img/06/636080484dd24215b2bc1e4e1887915e.png)

总之，就是使用Apache HttpClient 5替换 OpenFeign默认的HttpURLConnection

why
![image.png](./img/06/f3f3a55940064e5f8977edcdd4c4d5c2.png)
![image.png](./img/06/b3402886f5cb4db6b1427df4ec1087fb.png)

修改微服务feign80，cloud-consumer-openfeign-order
FeignConfig类里面将Retryer属性修改为默认
```java
package com.atguigu.cloud.config;
 
import feign.Retryer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
/**
 * @auther zzyy
 * @create 2023-11-10 11:09
 */
@Configuration
public class FeignConfig {
    @Bean
    public Retryer myRetryer(){
        return Retryer.NEVER_RETRY; //Feign默认配置是不走重试策略的
    }
}
```

POM修改
```xml
<!-- httpclient5-->
<dependency>
    <groupId>org.apache.httpcomponents.client5</groupId>
    <artifactId>httpclient5</artifactId>
    <version>5.3</version>
</dependency>
<!-- feign-hc5-->
<dependency>
    <groupId>io.github.openfeign</groupId>
    <artifactId>feign-hc5</artifactId>
    <version>13.1</version>
</dependency>
```

Apache HttpClient5  配置开启说明
```yml
#  Apache HttpClient5 配置开启
spring:
  cloud:
    openfeign:
      httpclient:
        hc5:
          enabled: true
```

YML 修改
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
            connectTimeout: 4000 #连接超时时间
                        readTimeout: 4000 #读取超时时间
            httpclient:
          hc5:
            enabled: true
          #cloud-payment-service:
            #connectTimeout: 4000 #连接超时时间
                        #readTimeout: 4000 #读取超时时间
```

替换之前
![image.png](./img/06/d13cca0ec17c4cf2ad10c2995ee7c379.png)

替换之后
![image.png](./img/06/d1cf619eac7244c298e2513a235addb4.png)

#### 6.5.4 OpenFeign请求/响应压缩
官网说明
![image.png](./img/06/4389a79e3cca4cf8a264ae96de210f38.png)

**对请求和响应进行GZIP压缩**
Spring Cloud OpenFeign支持对请求和响应 **进行GZIP压缩**，以减少通信过程中的性能损耗。

通过下面的两个参数设置，就能开启请求与相应的压缩功能：
spring.cloud.openfeign.compression.request.enabled=true
spring.cloud.openfeign.compression.response.enabled=true

**细粒度化设置**
对请求压缩做一些更细致的设置，比如下面的配置内容指定压缩的请求数据类型并设置了请求压缩的大小下限，
只有超过这个大小的请求才会进行压缩：
spring.cloud.openfeign.compression.request.enabled=true
spring.cloud.openfeign.compression.request.mime-types=text/xml,application/xml,application/json # 触发压缩数据类型
spring.cloud.openfeign.compression.request.min-request-size=2048 # 最小触发压缩的大小

YML
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
          #cloud-payment-service:
            #连接超时时间
                        connectTimeout: 4000
            #读取超时时间
                        readTimeout: 4000
      httpclient:
        hc5:
          enabled: true
      compression:
        request:
          enabled: true
          min-request-size: 2048 #最小触发压缩的大小
          mime-types: text/xml,application/xml,application/json #触发压缩数据类型
        response:
          enabled: true
```
压缩效果测试在下一章节体现


#### 6.5.5 OpenFeign日志打印功能
日志打印功能
Feign 提供了日志打印功能，我们可以通过配置来调整日志级别，
从而了解 Feign 中 Http 请求的细节，
说白了就是 **对Feign接口的调用情况进行监控和输出**

日志级别
>NONE：默认的，不显示任何日志；
>BASIC：仅记录请求方法、URL、响应状态码及执行时间；
>HEADERS：除了 BASIC 中定义的信息之外，还有请求和响应的头信息；
>FULL：除了 HEADERS 中定义的信息之外，还有请求和响应的正文及元数据。

![image.png](./img/06/fc300bb3d53d46a5b8134fd56db63816.png)


配置日志bean
```java
package com.atguigu.cloud.config;
 
import feign.Logger;
import feign.Retryer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
/**
 * @auther zzyy
 * @create 2023-04-12 17:24
 */
@Configuration
public class FeignConfig {
    @Bean
    public Retryer myRetryer() {
        return Retryer.NEVER_RETRY; //默认
    }
 
    @Bean
    Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }
}

```
YML文件里需要开启日志的Feign客户端
![image.png](./img/06/daa8ed10db3e4e3bb26c8f8585356bbf.png)


后台日志查看
带着压缩调用
![image.png](./img/06/9d5a8b3699354e7d8a7815a660f6f110.png)

去掉压缩调用
![image.png](./img/06/6500c3ae31f842549cd9562484ee634d.png)


补充实验，重试机制控制台看到3次过程
类FeignConfig
```java
package com.atguigu.cloud.config;
 
import feign.Logger;
import feign.Retryer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
/**
 * @auther zzyy
 * @create 2023-11-10 11:09
 */
@Configuration
public class FeignConfig {
    @Bean
    public Retryer myRetryer(){
        //最大请求次数为3(1+2)，初始间隔时间为100ms，重试间最大间隔时间为1s
        return new Retryer.Default(100,1,3);
    }
    @Bean
    Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }
}
```

YML（看到效果改为2秒）
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
          #cloud-payment-service:
            #连接超时时间
                        connectTimeout: 2000
            #读取超时时间
                        readTimeout: 2000
      httpclient:
        hc5:
          enabled: true
      compression:
        request:
          enabled: true
          min-request-size: 2048
          mime-types: text/xml,application/xml,application/json
        response:
          enabled: true
 
# feign日志以什么级别监控哪个接口
logging:
  level:
    com:
      atguigu:
        cloud:
          apis:
            PayFeignApi: debug
```

测试地址
http://localhost/feign/pay/get/1

控制台3次重试触发效果的过程
![image.png](./img/06/49e0d48245ae47fe9ac88efb56ab04ff.png)


本节内容最后的YML
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
            connectTimeout: 2000 #连接超时时间
                        readTimeout: 2000 #读取超时时间
           httpclient:
        hc5:
          enabled: true
      compression:
         request:
           enabled: true
           min-request-size: 2048
           mime-types: text/xml,application/xml,application/json
         response:
           enabled: true
          #cloud-payment-service:
            #connectTimeout: 4000 #连接超时时间
            #readTimeout: 4000 #读取超时时间
 
# feign日志以什么级别监控哪个接口
logging:
  level:
    com:
      atguigu:
        cloud:
          apis:
            PayFeignApi: debug
```

### 6.6 OpenFeign和Sentinel集成实现fallback服务降级
见后续 springcloud alibaba 篇章




## 7 CircuitBreaker断路器
![image.png](./img/06/39c909e9ceb541b9b8a3fa53affda255.png)

### 7.1 Hystrix目前也进入维护模式

#### 7.1.1 是什么
Hystrix是一个用于处理分布式系统的 **延迟** 和 **容错** 的开源库，在分布式系统里，许多依赖不可避免的会调用失败，比如超时、异常等，Hystrix能够保证在一个依赖出问题的情况下，**不会导致整体服务失败，避免级联故障，以提高分布式系统的弹性**。

了解一下即可，2024年了不再使用Hystrix
![image.png](./img/07/a05906f449344e2cab0fdcfa8b8c4264.png)

#### 7.1.2 Hystrix官宣，停更进维
![image.png](./img/07/9ee96e29ff6f49bf84caa1a664f6cedf.png)

#### 7.1.3 Hystrix未来替换方案
![image.png](./img/07/1174bc6997ca44439e1591cff80c2365.png)
Resilience4j​ 

### 7.2 概述
#### 7.2.1 2023年影响极大的真实生产故障
语雀崩了(2023.10.23)
![image.png](./img/07/550a82eb91074a18bbd34f888c7906b6.png)

阿里系大部分产品(2023.11.12)
![image.png](./img/07/c2922d396ac64004aa088064f9902264.png)

阿里云产品控制台
![image.png](./img/07/01392a8bdcd9467bb18c13e0bcc36de1.png)


#### 7.2.2 分布式系统面临的问题
分布式系统面临的问题

**复杂分布式体系结构中的应用程序有数十个依赖关系，每个依赖关系在某些时候将不可避免地失败**。
![image.png](./img/07/02baa58f3da343f0bd848be972507ebc.png)

**服务雪崩**
多个微服务之间调用的时候，假设微服务A调用微服务B和微服务C，微服务B和微服务C又调用其它的微服务，这就是所谓的“扇出”。如果扇出的链路上某个微服务的调用响应时间过长或者不可用，对微服务A的调用就会占用越来越多的系统资源，进而引起系统崩溃，所谓的“雪崩效应”.

对于高流量的应用来说，单一的后端依赖可能会导致所有服务器上的所有资源都在几秒钟内饱和。比失败更糟糕的是，这些应用程序还可能导致服务之间的延迟增加，备份队列，线程和其他系统资源紧张，导致整个系统发生更多的级联故障。这些都表示需要对故障和延迟进行隔离和管理，以便单个依赖关系的失败，不能取消整个应用程序或系统。

所以，通常当你发现一个模块下的某个实例失败后，这时候这个模块依然还会接收流量，然后这个有问题的模块还调用了其他的模块，这样就会发生级联故障，或者叫雪崩。


#### 7.2.3 我们的诉求
问题：
禁止服务雪崩故障

解决： 
- 有问题的节点，快速熔断（快速返回失败处理或者返回默认兜底数据【服务降级】）。

“断路器”本身是一种开关装置，当某个服务单元发生故障之后，通过断路器的故障监控（类似熔断保险丝），**向调用方返回一个符合预期的、可处理的备选响应(FallBack)，而不是长时间的等待或者抛出调用方无法处理的异常**，这样就保证了服务调用方的线程不会被长时间、不必要地占用，从而避免了故障在分布式系统中的蔓延，乃至雪崩。
一句话，出故障了“保险丝”跳闸，别把整个家给烧了

#### 7.2.4 如何搞定上述问题，避免整个系统大面积故障

**服务熔断**
类比保险丝，保险丝闭合状态(CLOSE)可以正常使用，当达到最大服务访问后，直接拒绝访问跳闸限电(OPEN)，此刻调用方会接受服务降级的处理并返回友好兜底提示
就是家里保险丝，从闭合CLOSE供电状态→跳闸OPEN打开状态

**服务降级**
服务器忙，请稍后再试。
不让客户端等待并立刻返回一个友好提示，fallback
![image.png](./img/07/6e82c6ffc6754b2e88f50073c6b91f98.png)

服务限流
秒杀高并发等操作，严禁一窝蜂的过来拥挤，大家排队，一秒钟N个，有序进行

服务限时

服务预热

接近实时的监控

兜底的处理动作

......

NOW
我们用什么替代？
![image.png](./img/07/8658511505e345f98dd22b84795fabcf.png)
Spring Cloud Circuit Breaker


### 7.3 Circuit Breaker是什么
官网
![image.png](./img/07/d7add7cebe1045e68c6e557e3419d3ae.png)
[Spring Cloud Circuit Breaker](https://spring.io/projects/spring-cloud-circuitbreaker#overview)

实现原理
CircuitBreaker的目的是保护分布式系统免受故障和异常，提高系统的可用性和健壮性。

当一个组件或服务出现故障时，CircuitBreaker会迅速切换到开放OPEN状态(保险丝跳闸断电)，阻止请求发送到该组件或服务从而避免更多的请求发送到该组件或服务。这可以减少对该组件或服务的负载，防止该组件或服务进一步崩溃，并使整个系统能够继续正常运行。同时，CircuitBreaker还可以提高系统的可用性和健壮性，因为它可以在分布式系统的各个组件之间自动切换，从而避免单点故障的问题。

![image.png](./img/07/955f8d4bbd95452eb6062cfd1b2a7ade.png)

一句话
<font color="red">Circuit Breaker只是一套规范和接口，落地实现者是Resilience4J</font>
![image.png](./img/07/88dc048f203c46a088debf8de910121f.png)

### 7.4 Resilience4J
是什么
![image.png](./img/07/d2e3caa27a65400e8c8995c6690ad92a.png)
![image.png](./img/07/818a4b620d5a4468a9ae23374aa0b846.png)

https://github.com/resilience4j/resilience4j#1-introduction

作用
![image.png](./img/07/d01b814d9f3949e9a6173fc4f9307f25.png)
https://github.com/resilience4j/resilience4j#3-overview

使用
官网
[CircuitBreaker](https://resilience4j.readme.io/docs/circuitbreaker)

中文手册
https://github.com/lmhmhl/Resilience4j-Guides-Chinese/blob/main/index.md



### 7.5 案例实战
#### 7.5.1 熔断(CircuitBreaker)(服务熔断+服务降级)
##### 7.5.1.1 断路器3大状态
![image.png](./img/07/1f4157fccf5d4890ad3d919d926a6ec4.png)

##### 7.5.1.2 断路器3大状态之间的转换
![image.png](./img/07/146d0a192864478791e68b5e1d101998.png)

##### 7.5.1.3 断路器所有配置参数参考
英文
https://resilience4j.readme.io/docs/circuitbreaker#create-and-configure-a-circuitbreaker

中文手册
| 配置属性                                          | 默认值                                                       | 描述                                                         |
| ------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| failureRateThreshold                              | 50                                                           | 以百分比配置失败率阈值。当失败率等于或大于阈值时，断路器状态并关闭变为开启，并进行服务降级。 |
| slowCallRateThreshold                             | 100                                                          | 以百分比的方式配置，断路器把调用时间大于`slowCallDurationThreshold`的调用视为满调用，当慢调用比例大于等于阈值时，断路器开启，并进行服务降级。 |
| slowCallDurationThreshold                         | 60000 [ms]                                                   | 配置调用时间的阈值，高于该阈值的呼叫视为慢调用，并增加慢调用比例。 |
| permittedNumberOfCallsInHalfOpenState             | 10                                                           | 断路器在半开状态下允许通过的调用次数。                       |
| maxWaitDurationInHalfOpenState                    | 0                                                            | 断路器在半开状态下的最长等待时间，超过该配置值的话，断路器会从半开状态恢复为开启状态。配置是0时表示断路器会一直处于半开状态，直到所有允许通过的访问结束。 |
| slidingWindowType                                 | COUNT_BASED                                                  | 配置滑动窗口的类型，当断路器关闭时，将调用的结果记录在滑动窗口中。滑动窗口的类型可以是count-based或time-based。如果滑动窗口类型是COUNT_BASED，将会统计记录最近`slidingWindowSize`次调用的结果。如果是TIME_BASED，将会统计记录最近`slidingWindowSize`秒的调用结果。 |
| slidingWindowSize                                 | 100                                                          | 配置滑动窗口的大小。                                         |
| minimumNumberOfCalls                              | 100                                                          | 断路器计算失败率或慢调用率之前所需的最小调用数（每个滑动窗口周期）。例如，如果minimumNumberOfCalls为10，则必须至少记录10个调用，然后才能计算失败率。如果只记录了9次调用，即使所有9次调用都失败，断路器也不会开启。 |
| waitDurationInOpenState                           | 60000 [ms]                                                   | 断路器从开启过渡到半开应等待的时间。                         |
| automaticTransition<br/>FromOpenToHalfOpenEnabled | false                                                        | 如果设置为true，则意味着断路器将自动从开启状态过渡到半开状态，并且不需要调用来触发转换。创建一个线程来监视断路器的所有实例，以便在WaitDurationInOpenstate之后将它们转换为半开状态。但是，如果设置为false，则只有在发出调用时才会转换到半开，即使在waitDurationInOpenState之后也是如此。这里的优点是没有线程监视所有断路器的状态。 |
| recordExceptions                                  | empty                                                        | 记录为失败并因此增加失败率的异常列表。<br/>除非通过ignoreExceptions显式忽略，否则与列表中某个匹配或继承的异常都将被视为失败。<br/>如果指定异常列表，则所有其他异常均视为成功，除非它们被ignoreExceptions显式忽略。 |
| ignoreExceptions                                  | empty                                                        | 被忽略且既不算失败也不算成功的异常列表。<br/>任何与列表之一匹配或继承的异常都不会被视为失败或成功，即使异常是recordExceptions的一部分。 |
| recordException                                   | throwable -> true·<br>By default all exceptions are recored as failures. | 一个自定义断言，用于评估异常是否应记录为失败。<br/>如果异常应计为失败，则断言必须返回true。如果出断言返回false，应算作成功，除非ignoreExceptions显式忽略异常。 |
| ignoreException                                   | throwable -> false<br>By default no exception is ignored.    | 自定义断言来判断一个异常是否应该被忽略，如果应忽略异常，则谓词必须返回true。<br/>如果异常应算作失败，则断言必须返回false。 |

[Resilience4j-Guides-Chinese/core-modules/CircuitBreaker.md at main · lmhmhl/Resilience4j-Guides-Chinese · GitHub](https://github.com/lmhmhl/Resilience4j-Guides-Chinese/blob/main/core-modules/CircuitBreaker.md)

默认CircuitBreaker.java配置类 
io.github.resilience4j.circuitbreaker.CircuitBreakerConfig

中文手册精简版

|   |   |
| ---------------------- | --------------------- |
| failure-rate-threshold | 以百分比配置失败率峰值 |
| sliding-window-type  | 断路器的滑动窗口期类型<br>可以基于“次数”（COUNT_BASED）或者“时间”<br>（TIME_BASED）进行熔断，默认是COUNT_BASED。 |
| sliding-window-size | 若COUNT_BASED，则10次调用中有50%失败（即5次）打开熔断断路器；<br> 若为TIME_BASED则，此时还有额外的两个设置属性，<br>  含义为：在N秒内（sliding-window-size）100%（slow-call-rate-threshold）的请求超过N秒（slow-call-duration-threshold）打开断路器。 |
| slowCallRateThreshold | 以百分比的方式配置，断路器把调用时间大于slowCallDurationThreshold的调用视为慢调用，当慢调用比例大于等于峰值时，断路器开启，并进入服务降级。 |
| slowCallDurationThreshold | 配置调用时间的峰值，高于该峰值的视为慢调用。 |
| permitted-number-of-calls-in-half-open-state | 运行断路器在HALF_OPEN状态下时进行N次调用，如果故障或慢速调用仍然高于阈值，断路器再次进入打开状态。 |
| minimum-number-of-calls | 在每个滑动窗口期样本数，配置断路器计算错误率或者慢调用率的最小调用数。比如设置为5意味着，在计算故障率之前，必须至少调用5次。如果只记录了4次，即使4次都失败了，断路器也不会进入到打开状态。 |
| wait-duration-in-open-state | 从OPEN到HALF_OPEN状态需要等待的时间 |

##### 7.5.1.4 熔断+降级案例需求说明
6次访问中当执行方法的失败率达到50%时CircuitBreaker将进入开启OPEN状态(保险丝跳闸断电)拒绝所有请求。
等待5秒后，CircuitBreaker 将自动从开启OPEN状态过渡到半开HALF_OPEN状态，允许一些请求通过以测试服务是否恢复正常。
如还是异常CircuitBreaker 将重新进入开启OPEN状态；如正常将进入关闭CLOSE闭合状态恢复正常处理请求。

具体时间和频次等属性见具体实际案例，这里只是作为case举例讲解，最下面笔记面试题概览，闲聊大厂面试   
![image.png](./img/07/a4d2c59525e54dae9b3c094e6d2a68e3.png)
![image.png](./img/07/22f320e93d014064ac196471b1b64b23.png)

##### 7.5.1.5 干，按照COUNT_BASED(计数的滑动窗口)
修改cloud-provider-payment8001

新建PayCircuitController
```java
package com.atguigu.cloud.controller;
 
import cn.hutool.core.util.IdUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
import java.util.concurrent.TimeUnit;
 
/**
 * @auther zzyy
 * @create 2023-11-13 14:55
 */
@RestController
public class PayCircuitController {
    //=========Resilience4j CircuitBreaker 的例子
    @GetMapping(value = "/pay/circuit/{id}")
    public String myCircuit(@PathVariable("id") Integer id) {
        if(id == -4) throw new RuntimeException("----circuit id 不能负数");
        if(id == 9999){
            try { TimeUnit.SECONDS.sleep(5); } catch (InterruptedException e) { e.printStackTrace(); }
        }
        return "Hello, circuit! inputId:  "+id+" \t " + IdUtil.simpleUUID();
    }
}
```

修改PayFeignApi接口
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
 
/**
 * @auther zzyy
 * @create 2023-11-09 15:29
 */
@FeignClient(value = "cloud-payment-service")
public interface PayFeignApi {
    /**
     * 新增一条支付相关流水记录
     * @param payDTO
     * @return
     */
    @PostMapping("/pay/add")
    public ResultData addPay(@RequestBody PayDTO payDTO);
 
    /**
     * 按照主键记录查询支付流水信息
     * @param id
     * @return
     */
    @GetMapping("/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable("id") Integer id);
 
    /**
     * openfeign天然支持负载均衡演示
     * @return
     */
    @GetMapping(value = "/pay/get/info")
    public String mylb();
 
    /**
     * Resilience4j CircuitBreaker 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/circuit/{id}")
    public String myCircuit(@PathVariable("id") Integer id);
}
```

修改cloud-consumer-feign-order80
改POM
```xml
<!--resilience4j-circuitbreaker-->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-circuitbreaker-resilience4j</artifactId>
</dependency>
<!-- 由于断路保护等需要AOP实现，所以必须导入AOP包 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-aop</artifactId>
</dependency>
```

写YML
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
            #cloud-payment-service:
            #连接超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            connectTimeout: 20000
            #读取超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            readTimeout: 20000
            #开启httpclient5
      httpclient:
        hc5:
          enabled: true
          #开启压缩特性
      compression:
        request:
          enabled: true
          min-request-size: 2048
          mime-types: text/xml,application/xml,application/json
        response:
          enabled: true
      # 开启circuitbreaker和分组激活 spring.cloud.openfeign.circuitbreaker.enabled
      circuitbreaker:
        enabled: true
        group:
          enabled: true #没开分组永远不用分组的配置。精确优先、分组次之(开了分组)、默认最后
 
 
# feign日志以什么级别监控哪个接口
logging:
  level:
    com:
      atguigu:
        cloud:
          apis:
            PayFeignApi: debug
 
# Resilience4j CircuitBreaker 按照次数：COUNT_BASED 的例子
#  6次访问中当执行方法的失败率达到50%时CircuitBreaker将进入开启OPEN状态(保险丝跳闸断电)拒绝所有请求。
#  等待5秒后，CircuitBreaker 将自动从开启OPEN状态过渡到半开HALF_OPEN状态，允许一些请求通过以测试服务是否恢复正常。
#  如还是异常CircuitBreaker 将重新进入开启OPEN状态；如正常将进入关闭CLOSE闭合状态恢复正常处理请求。
resilience4j:
  circuitbreaker:
    configs:
      default:
        failureRateThreshold: 50 # 设置50%的调用失败时打开断路器，超过失败请求百分⽐CircuitBreaker变为OPEN状态。
        slidingWindowType: COUNT_BASED # 滑动窗口的类型
        slidingWindowSize: 6 # 滑动窗⼝的⼤⼩配置COUNT_BASED表示6个请求，配置TIME_BASED表示6秒
        minimumNumberOfCalls: 6 # 断路器计算失败率或慢调用率之前所需的最小样本(每个滑动窗口周期)。如果minimumNumberOfCalls为10，则必须最少记录10个样本，然后才能计算失败率。如果只记录了9次调用，即使所有9次调用都失败，断路器也不会开启。
        automaticTransitionFromOpenToHalfOpenEnabled: true # 是否启用自动从开启状态过渡到半开状态，默认值为true。如果启用，CircuitBreaker将自动从开启状态过渡到半开状态，并允许一些请求通过以测试服务是否恢复正常
        waitDurationInOpenState: 5s # 从OPEN到HALF_OPEN状态需要等待的时间
        permittedNumberOfCallsInHalfOpenState: 2 # 半开状态允许的最大请求数，默认值为10。在半开状态下，CircuitBreaker将允许最多permittedNumberOfCallsInHalfOpenState个请求通过，如果其中有任何一个请求失败，CircuitBreaker将重新进入开启状态。
        recordExceptions:
        - java.lang.Exception
    instances:
      cloud-payment-service:
        baseConfig: default
```

新建OrderCircuitController
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.apis.PayFeignApi;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
/**
 * @auther zzyy
 * @create 2023-11-13 14:54
 * Resilience4j CircuitBreaker 的例子
 */
@RestController
public class OrderCircuitController{
    @Resource
    private PayFeignApi payFeignApi;
 
    @GetMapping(value = "/feign/pay/circuit/{id}")
    @CircuitBreaker(name = "cloud-payment-service", fallbackMethod = "myCircuitFallback")
    public String myCircuitBreaker(@PathVariable("id") Integer id){
        return payFeignApi.myCircuit(id);
    }
    //myCircuitFallback就是服务降级后的兜底处理方法
        public String myCircuitFallback(Integer id,Throwable t) {
        // 这里是容错处理逻辑，返回备用结果
        return "myCircuitFallback，系统繁忙，请稍后再试-----/(ㄒoㄒ)/~~";
    }
}
```

@CircuitBreaker
系统繁忙，请稍后再试。
不让调用者等待并立刻返回一个友好提示，fallback
![image.png](./img/07/6e82c6ffc6754b2e88f50073c6b91f98.png)

测试(按照错误次数达到多少后开启断路)
自测cloud-consumer-feign-order80
查看YML
![image.png](./img/07/26b7770e5fe04c77b2368abad0cec5af.png)

正确
http://localhost/feign/pay/circuit/11

错误
http://localhost/feign/pay/circuit/-4

一次error一次OK，trytry看看

50%错误后触发熔断并给出服务降级，告知调用者服务不可用
此时就算是输入正确的访问地址也无法调用服务(我明明是正确的也不让用)，它还在断路中(OPEN状态)，一会儿过渡到半开并继续正确地址访问，慢慢切换回CLOSE状态，可以正常访问了链路恢复

多次故意填写错误值（负4）
多次故意填写错误值(负4)，然后慢慢填写正确值(正整数11)，发现刚开始不满足条件，就算是正确的访问地址也不能进行


##### 7.5.1.6 干，按照TIME_BASED(时间的滑动窗口)
基于时间的滑动窗口
![image.png](./img/07/bbd65dbc74f341f99c984c49ba0e9afe.png)

修改cloud-consumer-feign-order80
写YML
```yml

server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
            #cloud-payment-service:
            #连接超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            connectTimeout: 20000
            #读取超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            readTimeout: 20000
            #开启httpclient5
      httpclient:
        hc5:
          enabled: true
          #开启压缩特性
      compression:
        request:
          enabled: true
          min-request-size: 2048
          mime-types: text/xml,application/xml,application/json
        response:
          enabled: true
      #开启circuitbreaker和分组激活
      circuitbreaker:
        enabled: true
        group:
          enabled: true #没开分组永远不用分组的配置。精确优先、分组次之(开了分组)、默认最后
 
 
# feign日志以什么级别监控哪个接口
logging:
  level:
    com:
      atguigu:
        cloud:
          apis:
            PayFeignApi: debug
 
# Resilience4j CircuitBreaker 按照时间：TIME_BASED 的例子
resilience4j:
  timelimiter:
    configs:
      default:
        timeout-duration: 10s #神坑的位置，timelimiter 默认限制远程1s，超于1s就超时异常，配置了降级，就走降级逻辑
  circuitbreaker:
    configs:
      default:
        failureRateThreshold: 50 #设置50%的调用失败时打开断路器，超过失败请求百分⽐CircuitBreaker变为OPEN状态。
        slowCallDurationThreshold: 2s #慢调用时间阈值，高于这个阈值的视为慢调用并增加慢调用比例。
        slowCallRateThreshold: 30 #慢调用百分比峰值，断路器把调用时间⼤于slowCallDurationThreshold，视为慢调用，当慢调用比例高于阈值，断路器打开，并开启服务降级
        slidingWindowType: TIME_BASED # 滑动窗口的类型
        slidingWindowSize: 2 #滑动窗口的大小配置，配置TIME_BASED表示2秒
        minimumNumberOfCalls: 2 #断路器计算失败率或慢调用率之前所需的最小样本(每个滑动窗口周期)。
        permittedNumberOfCallsInHalfOpenState: 2 #半开状态允许的最大请求数，默认值为10。
        waitDurationInOpenState: 5s #从OPEN到HALF_OPEN状态需要等待的时间
        recordExceptions:
          - java.lang.Exception
    instances:
      cloud-payment-service:
        baseConfig: default 
```

为避免影响实验效果，记得关闭FeignConfig自己写的重试3次
![image.png](./img/07/5b4123e0a2b44a71b700e34887f5ad89.png)

测试(慢查询)

一次超时，一次正常访问，同时进行
http://localhost/feign/pay/circuit/9999        故意超时，将会单独报错
http://localhost/feign/pay/circuit/11        可以访问，我是正常的

第1~4个超时，整多一点干4个，一次正常访问，同时进行
http://localhost/feign/pay/circuit/9999

正常访问也受到了牵连，因为服务熔断不能访问了
http://localhost/feign/pay/circuit/11

运气好的话，可以看到全线崩，刺激。

##### 7.5.1.7 小总结
断路器开启或者关闭的条件
![image.png](./img/07/c41cd005a9b344f6994c999980706e4c.png)

当满足一定的峰值和失败率达到一定条件后，断路器将会进入OPEN状态(保险丝跳闸)，服务熔断

当OPEN的时候，所有请求都不会调用主业务逻辑方法，而是直接走fallbackmetnod兜底背锅方法，服务降级

一段时间之后，这个时候断路器会从OPEN进入到HALF_OPEN半开状态，会放几个请求过去探探链路是否通？

如成功，断路器会关闭CLOSE(类似保险丝闭合，恢复可用)；

如失败，继续开启。重复上述

个人建议不要混合用，**推荐按照调用次数count_based**，一家之言仅供参考


#### 7.5.2 隔离(BulkHead)
##### 7.5.2.1 官网
https://resilience4j.readme.io/docs/bulkhead

中文
[Resilience4j-Guides-Chinese/core-modules/bulkhead.md at main · lmhmhl/Resilience4j-Guides-Chinese · GitHub](https://github.com/lmhmhl/Resilience4j-Guides-Chinese/blob/main/core-modules/bulkhead.md)

##### 7.5.2.2 是什么
bulkhead(船的)舱壁/(飞机的)隔板

隔板来自造船行业，床仓内部一般会分成很多小隔舱，一旦一个隔舱漏水因为隔板的存在而不至于影响其它隔舱和整体船。
![image.png](./img/07/4d022c0714a34c4497a20a7c52550c02.png)

##### 7.5.2.3 作用
![image.png](./img/07/f4d49a5466844966956a3df652c7f11a.png)

**依赖隔离&负载保护**：用来限制对于下游服务的最大并发数量的限制

##### 7.5.2.4 Resilience4j提供了如下两种隔离的实现方式，可以限制并发执行的数量
![image.png](./img/07/2d7609c17c9c4aebac27a5da759df8e7.png)

- SemaphoreBulkhead使用了信号量
- FixedThreadPoolBulkhead使用了有界队列和固定大小线程池

SemaphoreBulkhead可以在各种线程和I/O模型上正常工作。与Hystrix不同，它不提供基于shadow的thread选项。由客户端来确保正确的线程池大小与隔离配置一致。

##### 7.5.2.5 实现SemaphoreBulkhead(信号量舱壁)
概述
基本上就是我们JUC信号灯内容的同样思想
![image.png](./img/07/e7c9ae0979324e9a8afb50043cc3a288.png)

信号量舱壁（SemaphoreBulkhead）原理
当信号量有空闲时，进入系统的请求会直接获取信号量并开始业务处理。
当信号量全被占用时，接下来的请求将会进入 **阻塞状态**，SemaphoreBulkhead提供了一个阻塞计时器，
如果阻塞状态的请求在阻塞计时内无法获取到信号量则系统会拒绝这些请求。
若请求在阻塞计时内获取到了信号量，那将直接获取信号量并执行相应的业务处理。

源码分析
io.github.resilience4j.bulkhead.internal.SemaphoreBulkhead
![image.png](./img/07/37c1709d66f445f7bed65b9b32d03f2c.png)

cloud-provider-payment8001支付微服务 修改PayCircuitController
```java
//=========Resilience4j bulkhead 的例子
@GetMapping(value = "/pay/bulkhead/{id}")
public String myBulkhead(@PathVariable("id") Integer id){
    if(id == -4) throw new RuntimeException("----bulkhead id 不能-4");
 
    if(id == 9999){
        try { TimeUnit.SECONDS.sleep(5); } catch (InterruptedException e) { e.printStackTrace(); }
    }
 
    return "Hello, bulkhead! inputId:  "+id+" \t " + IdUtil.simpleUUID();
}
```

PayFeignApi接口新增舱壁api方法
```java
/**
 * Resilience4j Bulkhead 的例子
 * @param id
 * @return
 */
@GetMapping(value = "/pay/bulkhead/{id}")
public String myBulkhead(@PathVariable("id") Integer id);
```

修改cloud-consumer-feign-order80
POM
```xml
<!--resilience4j-bulkhead-->
<dependency>
    <groupId>io.github.resilience4j</groupId>
    <artifactId>resilience4j-bulkhead</artifactId>
</dependency>
```

YML
![image.png](./img/07/e7c4f6bfa8874d97809546cf3830f12d.png)
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
          #cloud-payment-service:
            #连接超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            connectTimeout: 20000
            #读取超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            readTimeout: 20000
            #开启httpclient5
      httpclient:
        hc5:
          enabled: true
          #开启压缩特性
      compression:
        request:
          enabled: true
          min-request-size: 2048
          mime-types: text/xml,application/xml,application/json
        response:
          enabled: true
      #开启circuitbreaker和分组激活
      circuitbreaker:
        enabled: true
        group:
          enabled: true #没开分组永远不用分组的配置。精确优先、分组次之(开了分组)、默认最后
 
 
# feign日志以什么级别监控哪个接口
logging:
  level:
    com:
      atguigu:
        cloud:
          apis:
            PayFeignApi: debug
 
####resilience4j bulkhead 的例子
resilience4j:
  bulkhead:
    configs:
      default:
        maxConcurrentCalls: 2 # 隔离允许并发线程执行的最大数量
        maxWaitDuration: 1s # 当达到并发调用数量时，新的线程的阻塞时间，我只愿意等待1秒，过时不候进舱壁兜底fallback
    instances:
      cloud-payment-service:
        baseConfig: default
  timelimiter:
    configs:
      default:
        timeout-duration: 20s #神坑的位置，timelimiter 默认限制远程1s，超于1s就超时异常，配置了降级，就走降级逻辑
```

业务类
OrderCircuitController
```java
/**
 *(船的)舱壁,隔离
 * @param id
 * @return
 */
@GetMapping(value = "/feign/pay/bulkhead/{id}")
@Bulkhead(name = "cloud-payment-service",fallbackMethod = "myBulkheadFallback",type = Bulkhead.Type.SEMAPHORE)
public String myBulkhead(@PathVariable("id") Integer id){
    return payFeignApi.myBulkhead(id);
}
public String myBulkheadFallback(Throwable t){
    return "myBulkheadFallback，隔板超出最大数量限制，系统繁忙，请稍后再试-----/(ㄒoㄒ)/~~";
}
```
@Bulkhead 
Bulkhead.Type.SEMAPHORE

测试
步骤
浏览器新打开2个窗口，各点一次，分别点击http://localhost/feign/pay/bulkhead/9999
每个请求调用需要耗时5秒，2个线程瞬间达到配置过的最大并发数2
此时第3个请求正常的请求访问，http://localhost/feign/pay/bulkhead/3
直接被舱壁限制隔离了，碰不到8001
等其中一个窗口停止了，再去正常访问，并发数小于2 了，可以OK
http://localhost/feign/pay/bulkhead/9999
http://localhost/feign/pay/bulkhead/3

结果
![image.png](./img/07/31dfc2768bc1437f8f29ae8a766b1395.png)

可以看到因为本案例并发线程数为2（maxConcurrentCalls: 2），只让2个线程进入执行，
其他请求降直接降级。

##### 7.5.2.6 实现FixedThreadPoolBulkhead(固定线程池舱壁)
概述
基本上就是我们JUC-线程池内容的同样思想
![image.png](./img/07/11e2e29badae4d5f881c20a974fc129f.png)

固定线程池舱壁（FixedThreadPoolBulkhead）
FixedThreadPoolBulkhead的功能与SemaphoreBulkhead一样也是 **用于限制并发执行的次数** 的，但是二者的实现原理存在差别而且表现效果也存在细微的差别。FixedThreadPoolBulkhead使用 **一个固定线程池和一个等待队列** 来实现舱壁。

当线程池中存在空闲时，则此时进入系统的请求将直接进入线程池开启新线程或使用空闲线程来处理请求。

当线程池中无空闲时时，接下来的请求将进入等待队列，
   若等待队列仍然无剩余空间时接下来的请求将直接被拒绝，
   在队列中的请求等待线程池出现空闲时，将进入线程池进行业务处理。
另外：ThreadPoolBulkhead只对CompletableFuture方法有效，所以我们必创建返回CompletableFuture类型的方法

源码分析
io.github.resilience4j.bulkhead.internal.FixedThreadPoolBulkhead

底子就是JUC里面的线程池ThreadPoolExecutor
![image.png](./img/07/34759fb8c4d04a999295e80411b09fd7.png)

submit进线程池返回CompletableFuture<T>
![image.png](./img/07/3b7a1d1fbcdb4040a841067a469a16d3.png)

修改cloud-consumer-feign-order80
POM
```xml
<!--resilience4j-bulkhead-->
<dependency>
    <groupId>io.github.resilience4j</groupId>
    <artifactId>resilience4j-bulkhead</artifactId>
</dependency>
```

YML
示例
![image.png](./img/07/7fe1fa84b3a94e028eeeb1847964cefb.png)
![image.png](./img/07/bfce657f9440443480766b1658463ddb.png)

内容
```yml
server:
  port: 80
 
spring:
  application:
    name: cloud-consumer-openfeign-order
  ####Spring Cloud Consul for Service Discovery
  cloud:
    consul:
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true #优先使用服务ip进行注册
        service-name: ${spring.application.name}
    openfeign:
      client:
        config:
          default:
            #cloud-payment-service:
            #连接超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            connectTimeout: 20000
            #读取超时时间，为避免演示出错，讲解完本次内容后设置为20秒
            readTimeout: 20000
            #开启httpclient5
      httpclient:
        hc5:
          enabled: true
          #开启压缩特性
      compression:
        request:
          enabled: true
          min-request-size: 2048
          mime-types: text/xml,application/xml,application/json
        response:
          enabled: true
      #开启circuitbreaker和分组激活
      circuitbreaker:
        enabled: true
#        group:
#          enabled: true # 演示Bulkhead.Type.THREADPOOL时spring.cloud.openfeign.circuitbreaker.group.enabled 设为false新启线程和原来主线程脱离了。
 
 
 
# feign日志以什么级别监控哪个接口
logging:
  level:
    com:
      atguigu:
        cloud:
          apis:
            PayFeignApi: debug
 
####resilience4j bulkhead -THREADPOOL的例子
resilience4j:
  timelimiter:
    configs:
      default:
        timeout-duration: 10s #timelimiter默认限制远程1s，超过报错不好演示效果所以加上10秒
  thread-pool-bulkhead:
    configs:
      default:
        core-thread-pool-size: 1
        max-thread-pool-size: 1
        queue-capacity: 1
    instances:
      cloud-payment-service:
        baseConfig: default
# spring.cloud.openfeign.circuitbreaker.group.enabled 请设置为false 新启线程和原来主线程脱离
```

上述内容解释
![image.png](./img/07/9c7a125340ad44679fb2a24bf94d73d2.png)

controller
```java
/**
 * (船的)舱壁,隔离,THREADPOOL
 * @param id
 * @return
 */
@GetMapping(value = "/feign/pay/bulkhead/{id}")
@Bulkhead(name = "cloud-payment-service",fallbackMethod = "myBulkheadPoolFallback",type = Bulkhead.Type.THREADPOOL)
public CompletableFuture<String> myBulkheadTHREADPOOL(@PathVariable("id") Integer id) {
    System.out.println(Thread.currentThread().getName()+"\t"+"enter the method!!!");
    try { TimeUnit.SECONDS.sleep(3); } catch (InterruptedException e) { e.printStackTrace(); }
    System.out.println(Thread.currentThread().getName()+"\t"+"exist the method!!!");
 
    return CompletableFuture.supplyAsync(() -> payFeignApi.myBulkhead(id) + "\t" + " Bulkhead.Type.THREADPOOL");
}
public CompletableFuture<String> myBulkheadPoolFallback(Integer id,Throwable t) {
    return CompletableFuture.supplyAsync(() -> "Bulkhead.Type.THREADPOOL，系统繁忙，请稍后再试-----");
}
```
Bulkhead.Type.THREADPOOL

测试地址
http://localhost/feign/pay/bulkhead/1 
http://localhost/feign/pay/bulkhead/2 
http://localhost/feign/pay/bulkhead/3 

![image.png](./img/07/6a1328e38e674d78aa6558a4e8730881.png)


#### 7.5.3 限流(RateLimiter)
##### 7.5.3.1 官网
[RateLimiter](https://resilience4j.readme.io/docs/ratelimiter)

中文
https://github.com/lmhmhl/Resilience4j-Guides-Chinese/blob/main/core-modules/ratelimiter.md

##### 7.5.3.2 是什么
限流 就是限制最大访问流量。系统能提供的最大并发是有限的，同时来的请求又太多，就需要限流。 

比如商城秒杀业务，瞬时大量请求涌入，服务器忙不过就只好排队限流了，和去景点排队买票和去医院办理业务排队等号道理相同。

所谓限流，就是通过对并发访问/请求进行限速，或者对一个时间窗口内的请求进行限速，以保护应用系统，一旦达到限制速率则可以拒绝服务、排队或等待、降级等处理。

限流(频率控制)

##### 7.5.3.3 面试题：说说常见限流算法
1 漏斗算法(Leaky Bucket)

漏桶算法 
  一个固定容量的漏桶，按照设定常量固定速率流出水滴，类似医院打吊针，不管你源头流量多大，我设定匀速流出。 
  如果流入水滴超出了桶的容量，则流入的水滴将会溢出了(被丢弃)，而漏桶容量是不变的。
![image.png](./img/07/446510e7b13843c2a37d1b384a426d13.png)

缺点：
这里有两个变量，一个是桶的大小，支持流量突发增多时可以存多少的水（burst），另一个是水桶漏洞的大小（rate）。因为漏桶的漏出速率是固定的参数，所以，即使网络中不存在资源冲突（没有发生拥塞），漏桶算法也不能使流突发（burst）到端口速率。<font color="red">因此，漏桶算法对于存在突发特性的流量来说缺乏效率</font>。
![image.png](./img/07/8e6cee47240f4f3eacb248fdc0c0d5df.png)

2 令牌桶算法(Token Bucket)
![image.png](./img/07/7d8d1fb6444c4556a6204c8b9a07f5bf.png)
SpringCloud默认使用该算法

3 滚动时间窗(tumbling time window)
允许固定数量的请求进入(比如1秒取4个数据相加，超过25值就over)超过数量就拒绝或者排队，等下一个时间段进入。

由于是在一个时间间隔内进行限制，如果用户在上个时间间隔结束前请求（**但没有超过限制**），同时在当前时间间隔刚开始请求（**同样没超过限制**），在各自的时间间隔内，这些请求都是正常的。下图统计了3次，but......
![image.png](./img/07/dca542dcad464e759fa2125b39d37c8f.png)

缺点：间隔临界的一段时间内的请求就会超过系统限制，可能导致系统被压垮
<font color="red">由于计数器算法存在时间临界点缺陷，因此在时间临界点左右的的极短时间段内容易遭到攻击</font>
![image.png](./img/07/cd4f4255d1a244509ed97166eeaf9e95.png)

假如设定1分钟最多可以请求100次某个接口，如12:00:00-12:00:59时间段内没有数据请求但12:00:59-12:01:00时间段内突然并发100次请求，紧接着瞬间跨入下一个计数周期计数器清零；在12:01:00-12:01:01内又有100次请求。那么也就是说在时间临界点左右可能同时有2倍的峰值进行请求，从而造成后台处理请求 **加倍过载** 的bug，导致系统运营能力不足，甚至导致系统崩溃

double kill

4 滑动时间窗口(sliding time window)
滑动时间窗口（sliding time window）
顾名思义，该时间窗口是滑动的。所以，从概念上讲，这里有两个方面的概念需要理解： 

- 窗口：需要定义窗口的大小
- 滑动：需要定义在窗口中滑动的大小，但理论上讲滑动的大小不能超过窗口大小

滑动窗口算法是把固定时间片进行划分并且随着时间移动，移动方式为开始时间点变为时间列表中的第2个时间点，结束时间点增加一个时间点，

不断重复，通过这种方式可以巧妙的避开计数器的临界点的问题。下图统计了5次
![image.png](./img/07/f910950dadf147b9a2f09de15bc15540.png)

##### 7.5.3.4 cloud-provider-payment8001支付微服务修改PayCircuitController新增myRatelimit方法
```java
//=========Resilience4j ratelimit 的例子
@GetMapping(value = "/pay/ratelimit/{id}")
public String myRatelimit(@PathVariable("id") Integer id) {
    return "Hello, myRatelimit欢迎到来 inputId:  "+id+" \t " + IdUtil.simpleUUID();
}
```

##### 7.5.3.5 PayFeignApi接口新增限流api方法
```java
/**
 * Resilience4j Ratelimit 的例子
 * @param id
 * @return
 */
@GetMapping(value = "/pay/ratelimit/{id}")
public String myRatelimit(@PathVariable("id") Integer id);
```

##### 7.5.3.6 修改cloud-consumer-feign-order80
POM
```xml
<!--resilience4j-ratelimiter-->
<dependency>
    <groupId>io.github.resilience4j</groupId>
    <artifactId>resilience4j-ratelimiter</artifactId>
</dependency>
```

YML
```yml
####resilience4j ratelimiter 限流的例子
resilience4j:
  ratelimiter:
    configs:
      default:
        limitForPeriod: 2 # 在一次刷新周期内，允许执行的最大请求数
        limitRefreshPeriod: 1s # 限流器每隔limitRefreshPeriod刷新一次，将允许处理的最大请求数量重置为limitForPeriod
        timeout-duration: 1 # 线程等待权限的默认等待时间
    instances:
        cloud-payment-service:
          baseConfig: default
```

order的controller
```java
@GetMapping(value = "/feign/pay/ratelimit/{id}")
@RateLimiter(name = "cloud-payment-service",fallbackMethod = "myRatelimitFallback")
public String myBulkhead(@PathVariable("id") Integer id) {
    return payFeignApi.myRatelimit(id);
}
public String myRatelimitFallback(Integer id,Throwable t) {
    return "你被限流了，禁止访问/(ㄒoㄒ)/~~";
}
```
@RateLimiter 

##### 7.5.3.7 测试
http://localhost/feign/pay/ratelimit/11

结果
![image.png](./img/07/9069b43021414cf881bf65cd9a0e354c.png)
刷新上述地址，正常后F5按钮狂刷一会儿，停止刷新看到被限流的效果


## 8 Sleuth(Micrometer)+ZipKin分布式链路追踪
![image.png](./img/08/39c909e9ceb541b9b8a3fa53affda255.png)

### 8.1 Sleuth目前也进入维护模式
Sleuth官宣，改头换面
![image.png](./img/08/90c0d59ae4ed4328aa5cc02a1f465f38.png)

Sleuth未来替换方案
Micrometer Tracing​

### 8.2 分布式链路追踪概述
#### 8.2.1 为什么会出现这个技术？需要解决哪些问题？
在微服务框架中，一个由客户端发起的请求在后端系统中会经过多个不同的的服务节点调用来协同产生最后的请求结果，每一个前段请求都会形成一条复杂的分布式服务调用链路，链路中的任何一环出现高延时或错误都会引起整个请求最后的失败。
![image.png](./img/08/62cc12ccf9f54c3cb6bb75514e33fe37.png)

#### 8.2.2 问题的复杂化+微服务的增多+调用链条的变长

#### 8.2.3 在分布式与微服务场景下需要解决的问题
在分布式与微服务场景下，我们需要解决如下问题：
在大规模分布式与微服务集群下，如何实时观测系统的整体调用链路情况。
在大规模分布式与微服务集群下，如何快速发现并定位到问题。
在大规模分布式与微服务集群下，如何尽可能精确的判断故障对系统的影响范围与影响程度。
在大规模分布式与微服务集群下，如何尽可能精确的梳理出服务之间的依赖关系，并判断出服务之间的依赖关系是否合理。
在大规模分布式与微服务集群下，如何尽可能精确的分析整个系统调用链路的性能与瓶颈点。
在大规模分布式与微服务集群下，如何尽可能精确的分析系统的存储瓶颈与容量规划。

上述问题就是我们的落地议题答案：
分布式链路追踪技术要解决的问题，分布式链路追踪（Distributed Tracing），就是将一次分布式请求还原成调用链路，进行日志记录，性能监控并将一次分布式请求的调用情况集中展示。比如各个服务节点上的耗时、请求具体到达哪台机器上、每个服务节点的请求状态等等。

### 8.3 新一代Spring Cloud Sleuth：Micrometer
#### 8.3.1 (官网重要提示)
新一代Sleuth
sleuth被micrometer替代
![image.png](./img/08/bed37052c31844beadc146a1c002f413.png)

官网
[Spring Cloud Sleuth](https://spring.io/projects/spring-cloud-sleuth#overview)

github：
https://github.com/spring-cloud/spring-cloud-sleuth

说明
老项目还能用Sleuth开发吗
![image.png](./img/08/a680c84950cb438094f54c5ddcfc44f7.png)

版本注意
![image.png](./img/08/d6565974502d4f29968471f1b81943fd.png)
![image.png](./img/08/f18280f2e5394488b425c3828bf43f27.png)

#### 8.3.2 zipkin那？
Spring Cloud Sleuth(micrometer)提供了一套完整的分布式链路追踪（Distributed Tracing）解决方案且兼容支持了zipkin展现
![image.png](./img/08/cc1f38d3b6d74a34b1f65b00f85dfe6b.png)

#### 8.3.3 小总结
将一次分布式请求还原成调用链路，进行日志记录和性能监控，并将一次分布式请求的调用情况集中web展示

#### 8.3.4 行业内比较成熟的其它分布式链路追踪技术解决方案
![image.png](./img/08/d2bbec1b69f64d89918191a61f11c2cd.png)


### 8.4 分布式链路追踪原理
假定三个微服务调用的链路如下图所示：Service 1 调用 Service 2，Service 2 调用 Service 3 和 Service 4。
![image.png](./img/08/6b1d53a153174b4b8a7c3d581d0369df.png)

上一步完整的调用链路​
**那么一条链路追踪会在每个服务调用的时候加上Trace ID 和 Span ID**

链路通过TraceId唯一标识，
Span标识发起的请求信息，各span通过parent id 关联起来 (Span:表示调用链路来源，通俗的理解span就是一次请求信息)
![image.png](./img/08/f2b5e02c89024530a155262e612c0de3.png)

彻底把链路追踪整明白
一条链路通过Trace Id唯一标识，Span标识发起的请求信息，各span通过parent id 关联起来
![image.png](./img/08/57bbd13adc9244e3820f40abae497c94.png)

<table>
  <tr>
    <td>1</td> 
    <td>第一个节点：Span ID = A，Parent ID = null，Service 1 接收到请求。</td>
  </tr>
  <tr>
    <td>2</td> 
    <td>第二个节点：Span ID = B，Parent ID= A，Service 1 发送请求到 Service 2 返回响应给Service 1 的过程。</td>
  </tr>
  <tr>
    <td>3</td> 
    <td>第三个节点：Span ID = C，Parent ID= B，Service 2 的 中间解决过程。</td>
  </tr>
  <tr>
    <td>4</td> 
    <td>第四个节点：Span ID = D，Parent ID= C，Service 2 发送请求到 Service 3 返回响应给Service 2 的过程。</td>
  </tr>
  <tr>
    <td>5</td> 
    <td>第五个节点：Span ID = E，Parent ID= D，Service 3 的中间解决过程。</td>
  </tr>
  <tr>
    <td>6</td> 
    <td>第六个节点：Span ID = F，Parent ID= C，Service 3 发送请求到 Service 4 返回响应给 Service 3 的过程。</td>
  </tr>
  <tr>
    <td>7</td> 
    <td>第七个节点：Span ID = G，Parent ID= F，Service 4 的中间解决过程。</td>
  </tr>
  <tr>
    <td>8</td> 
    <td>通过 Parent ID 就可找到父节点，整个链路即可以进行跟踪追溯了。</td>
  </tr>
</table>


### 8.5 Zipkin
#### 8.5.1 官网
[OpenZipkin · A distributed tracing system](https://zipkin.io/)

#### 8.5.2 ZipKin概述
Zipkin是一种分布式链路跟踪系统**图形化的工具**，Zipkin 是 Twitter 开源的分布式跟踪系统，能够收集微服务运行过程中的实时调用链路信息，并能够将这些调用链路信息展示到Web图形化界面上供开发人员分析，开发人员能够从ZipKin中分析出调用链路中的性能瓶颈，识别出存在问题的应用程序，进而定位问题和解决问题。
![image.png](./img/08/4aac8f9b5d89482a9142615665ced565.png)

#### 8.5.3 Zipkin出现原因
单有Sleuth(Micrometer)行不行？
![image.png](./img/08/13309afc2fe5481890f6fca34b3f9daf.png)

说明：
当没有配置 Sleuth 链路追踪的时候，INFO 信息里面是 [passjava-question,,,]，后面跟着三个空字符串。

当配置了 Sleuth 链路追踪的时候，追踪到的信息是 [passjava-question,504a5360ca906016,e55ff064b3941956,false] ，第一个是 Trace ID，第二个是 Span ID。**只有日志没有图，观看不方便，不美观**，所以引入图形化Zipkin链路监控。

#### 8.5.4 下载+安装+运行一套带走
下载主页
[Quickstart · OpenZipkin](https://zipkin.io/pages/quickstart)

支持3个方式
![image.png](./img/08/f2627695c4124663a74123b6e916810b.png)

下载地址
![image.png](./img/08/2b373e3b6b744d2ca170e556b2cff38f.png)

2023.12，版本名称
zipkin-server-3.0.0-rc0-exec.jar

运行jar
![image.png](./img/08/617daaf8765d42218a0842511ca3de4c.png)

运行控制台
http://localhost:9411/zipkin/

### 8.6 Micrometer+ZipKin搭建链路监控案例步骤
#### 8.6.1 Micrometer+ZipKin两者各自的分工
Micrometer
数据采样

ZipKin
图形展示

#### 8.6.2 步骤
总体父工程POM

本案例​​​​​​​
```xml
<!--micrometer-tracing-bom导入链路追踪版本中心  1-->
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-tracing-bom</artifactId>
    <version>${micrometer-tracing.version}</version>
    <type>pom</type>
    <scope>import</scope>
</dependency>
<!--micrometer-tracing指标追踪  2-->
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-tracing</artifactId>
    <version>${micrometer-tracing.version}</version>
</dependency>
<!--micrometer-tracing-bridge-brave适配zipkin的桥接包 3-->
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-tracing-bridge-brave</artifactId>
    <version>${micrometer-tracing.version}</version>
</dependency>
<!--micrometer-observation 4-->
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-observation</artifactId>
    <version>${micrometer-observation.version}</version>
</dependency>
<!--feign-micrometer 5-->
<dependency>
    <groupId>io.github.openfeign</groupId>
    <artifactId>feign-micrometer</artifactId>
    <version>${feign-micrometer.version}</version>
</dependency>
<!--zipkin-reporter-brave 6-->
<dependency>
    <groupId>io.zipkin.reporter2</groupId>
    <artifactId>zipkin-reporter-brave</artifactId>
    <version>${zipkin-reporter-brave.version}</version>
</dependency>
```

引入的jar包分别是什么意思​​​​​​​
由于Micrometer Tracing是一个门面工具自身并没有实现完整的链路追踪系统，具体的链路追踪另外需要引入的是第三方链路追踪系统的依赖：
<table>
  <tr>
    <td>1</td> 
    <td>micrometer-tracing-bom</td>
    <td>导入链路追踪版本中心，体系化说明</td>
  </tr>
  <tr>
    <td>2</td> 
    <td>micrometer-tracing</td>
    <td>指标追踪</td>
  </tr>
  <tr>
    <td>3</td> 
    <td>micrometer-tracing-bridge-brave</td>
    <td>一个Micrometer模块，用于与分布式跟踪工具 Brave 集成，以收集应用程序的分布式跟踪数据。Brave是一个开源的分布式跟踪工具，它可以帮助用户在分布式系统中跟踪请求的流转，它使用一种称为"跟踪上下文"的机制，将请求的跟踪信息存储在请求的头部，然后将请求传递给下一个服务。在整个请求链中，Brave会将每个服务处理请求的时间和其他信息存储到跟踪数据中，以便用户可以了解整个请求的路径和性能。</td>
  </tr>
  <tr>
    <td>4</td> 
    <td>micrometer-observation</td>
    <td>一个基于度量库 Micrometer的观测模块，用于收集应用程序的度量数据。</td>
  </tr>
  <tr>
    <td>5</td> 
    <td>feign-micrometer</td>
    <td>一个Feign HTTP客户端的Micrometer模块，用于收集客户端请求的度量数据。</td>
  </tr>
  <tr>
    <td>6</td> 
    <td>zipkin-reporter-brave</td>
    <td>一个用于将 Brave 跟踪数据报告到Zipkin 跟踪系统的库。</td>
  </tr>
</table>

补充包：spring-boot-starter-actuator   SpringBoot框架的一个模块用于监视和管理应用程序
all
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
 
    <groupId>com.atguigu.cloud</groupId>
    <artifactId>mscloudV6</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>pom</packaging>
    <modules>
        <module>cloud-provider-payment8001</module>
        <module>cloud-consumer-order80</module>
        <module>cloud-api-commons</module>
        <module>cloud-provider-payment8002</module>
        <module>cloud-consumer-feign-order80</module>
    </modules>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <hutool.version>5.8.22</hutool.version>
        <lombok.version>1.18.26</lombok.version>
        <druid.version>1.1.20</druid.version>
        <mybatis.springboot.version>3.0.2</mybatis.springboot.version>
        <mysql.version>8.0.11</mysql.version>
        <swagger3.version>2.2.0</swagger3.version>
        <mapper.version>4.2.3</mapper.version>
        <fastjson2.version>2.0.41</fastjson2.version>
        <persistence-api.version>1.0.2</persistence-api.version>
        <spring.boot.test.version>3.1.5</spring.boot.test.version>
        <spring.boot.version>3.2.0</spring.boot.version>
        <spring.cloud.version>2023.0.0</spring.cloud.version>
        <spring.cloud.alibaba.version>2022.0.0.0-RC2</spring.cloud.alibaba.version>
        <micrometer-tracing.version>1.2.0</micrometer-tracing.version>
        <micrometer-observation.version>1.12.0</micrometer-observation.version>
        <feign-micrometer.version>12.5</feign-micrometer.version>
        <zipkin-reporter-brave.version>2.17.0</zipkin-reporter-brave.version>
    </properties>
 
    <dependencyManagement>
        <dependencies>
            <!--springboot 3.2.0-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-parent</artifactId>
                <version>${spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--springcloud 2023.0.0-->
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>${spring.cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--springcloud alibaba 2022.0.0.0-RC2-->
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>${spring.cloud.alibaba.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--SpringBoot集成mybatis-->
            <dependency>
                <groupId>org.mybatis.spring.boot</groupId>
                <artifactId>mybatis-spring-boot-starter</artifactId>
                <version>${mybatis.springboot.version}</version>
            </dependency>
            <!--Mysql数据库驱动8 -->
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>${mysql.version}</version>
            </dependency>
            <!--SpringBoot集成druid连接池-->
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid-spring-boot-starter</artifactId>
                <version>${druid.version}</version>
            </dependency>
            <!--通用Mapper4之tk.mybatis-->
            <dependency>
                <groupId>tk.mybatis</groupId>
                <artifactId>mapper</artifactId>
                <version>${mapper.version}</version>
            </dependency>
            <!--persistence-->
            <dependency>
                <groupId>javax.persistence</groupId>
                <artifactId>persistence-api</artifactId>
                <version>${persistence-api.version}</version>
            </dependency>
            <!-- fastjson2 -->
            <dependency>
                <groupId>com.alibaba.fastjson2</groupId>
                <artifactId>fastjson2</artifactId>
                <version>2.0.40</version>
            </dependency>
            <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
            <dependency>
                <groupId>org.springdoc</groupId>
                <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
                <version>${swagger3.version}</version>
            </dependency>
            <!--hutool-->
            <dependency>
                <groupId>cn.hutool</groupId>
                <artifactId>hutool-all</artifactId>
                <version>${hutool.version}</version>
            </dependency>
            <!--lombok-->
            <dependency>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>${lombok.version}</version>
                <optional>true</optional>
            </dependency>
            <!-- spring-boot-starter-test -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-test</artifactId>
                <version>${spring.boot.test.version}</version>
                <scope>test</scope>
            </dependency>
            <!--micrometer-tracing-bom导入链路追踪版本中心  1-->
            <dependency>
                <groupId>io.micrometer</groupId>
                <artifactId>micrometer-tracing-bom</artifactId>
                <version>${micrometer-tracing.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--micrometer-tracing指标追踪  2-->
            <dependency>
                <groupId>io.micrometer</groupId>
                <artifactId>micrometer-tracing</artifactId>
                <version>${micrometer-tracing.version}</version>
            </dependency>
            <!--micrometer-tracing-bridge-brave适配zipkin的桥接包 3-->
            <dependency>
                <groupId>io.micrometer</groupId>
                <artifactId>micrometer-tracing-bridge-brave</artifactId>
                <version>${micrometer-tracing.version}</version>
            </dependency>
            <!--micrometer-observation 4-->
            <dependency>
                <groupId>io.micrometer</groupId>
                <artifactId>micrometer-observation</artifactId>
                <version>${micrometer-observation.version}</version>
            </dependency>
            <!--feign-micrometer 5-->
            <dependency>
                <groupId>io.github.openfeign</groupId>
                <artifactId>feign-micrometer</artifactId>
                <version>${feign-micrometer.version}</version>
            </dependency>
            <!--zipkin-reporter-brave 6-->
            <dependency>
                <groupId>io.zipkin.reporter2</groupId>
                <artifactId>zipkin-reporter-brave</artifactId>
                <version>${zipkin-reporter-brave.version}</version>
            </dependency>
 
        </dependencies>
    </dependencyManagement>
</project>
```

服务提供者8001
cloud-provider-payment8001​​​​​​​
POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV6</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-provider-payment8001</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
 
    <dependencies>
        <!--micrometer-tracing指标追踪  1-->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-tracing</artifactId>
        </dependency>
        <!--micrometer-tracing-bridge-brave适配zipkin的桥接包 2-->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-tracing-bridge-brave</artifactId>
        </dependency>
        <!--micrometer-observation 3-->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-observation</artifactId>
        </dependency>
        <!--feign-micrometer 4-->
        <dependency>
            <groupId>io.github.openfeign</groupId>
            <artifactId>feign-micrometer</artifactId>
        </dependency>
        <!--zipkin-reporter-brave 5-->
        <dependency>
            <groupId>io.zipkin.reporter2</groupId>
            <artifactId>zipkin-reporter-brave</artifactId>
        </dependency>
        <!--SpringCloud consul config-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-config</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-bootstrap</artifactId>
        </dependency>
        <!--SpringCloud consul discovery -->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--SpringBoot通用依赖模块-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--SpringBoot集成druid连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
        </dependency>
        <!-- Swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
        <!--mybatis和springboot整合-->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
        </dependency>
        <!--Mysql数据库驱动8 -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <!--persistence-->
        <dependency>
            <groupId>javax.persistence</groupId>
            <artifactId>persistence-api</artifactId>
        </dependency>
        <!--通用Mapper4-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper</artifactId>
        </dependency>
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!-- fastjson2 -->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.28</version>
            <scope>provided</scope>
        </dependency>
        <!--test-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
 
</project>
```

YML
```yml
server:
  port: 8001
 
# ==========applicationName + druid-mysql8 driver===================
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
  profiles:
    active: dev # 多环境配置加载内容dev/prod,不写就是默认default配置
 
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
 
 
# ========================zipkin===================
management:
  zipkin:
    tracing:
      endpoint: http://localhost:9411/api/v2/spans
  tracing:
    sampling:
      probability: 1.0 #采样率默认为0.1(0.1就是10次只能有一次被记录下来)，值越大收集越及时。
```

新建业务类PayMicrometerController
```java
package com.atguigu.cloud.controller;
 
import cn.hutool.core.util.IdUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class PayMicrometerController {
    /**
     * Micrometer(Sleuth)进行链路监控的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/micrometer/{id}")
    public String myMicrometer(@PathVariable("id") Integer id) {
        return "Hello, 欢迎到来myMicrometer inputId:  "+id+" \t    服务返回:" + IdUtil.simpleUUID();
    }
}
```

Api接口PayFeignApi
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import io.github.resilience4j.bulkhead.annotation.Bulkhead;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
 
@FeignClient(value = "cloud-payment-service")
public interface PayFeignApi {
    /**
     * 新增一条支付相关流水记录
     * @param payDTO
     * @return
     */
    @PostMapping("/pay/add")
    public ResultData addPay(@RequestBody PayDTO payDTO);
 
    /**
     * 按照主键记录查询支付流水信息
     * @param id
     * @return
     */
    @GetMapping("/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable("id") Integer id);
 
    /**
     * openfeign天然支持负载均衡演示
     * @return
     */
    @GetMapping(value = "/pay/get/info")
    public String mylb();
 
    /**
     * Resilience4j CircuitBreaker 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/circuit/{id}")
    public String myCircuit(@PathVariable("id") Integer id);
 
    /**
     * Resilience4j Bulkhead 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/bulkhead/{id}")
    public String myBulkhead(@PathVariable("id") Integer id);
 
    /**
     * Resilience4j Ratelimit 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/ratelimit/{id}")
    public String myRatelimit(@PathVariable("id") Integer id);
 
 
    /**
     * Micrometer(Sleuth)进行链路监控的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/micrometer/{id}")
    public String myMicrometer(@PathVariable("id") Integer id);
}
```

服务调用者80
cloud-consumer-feign-order80
POM
```xml
<!--micrometer-tracing指标追踪  1-->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-tracing</artifactId>
    </dependency>
    <!--micrometer-tracing-bridge-brave适配zipkin的桥接包 2-->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-tracing-bridge-brave</artifactId>
    </dependency>
    <!--micrometer-observation 3-->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-observation</artifactId>
    </dependency>
    <!--feign-micrometer 4-->
    <dependency>
        <groupId>io.github.openfeign</groupId>
        <artifactId>feign-micrometer</artifactId>
    </dependency>
    <!--zipkin-reporter-brave 5-->
    <dependency>
        <groupId>io.zipkin.reporter2</groupId>
        <artifactId>zipkin-reporter-brave</artifactId>
    </dependency>
```

all
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV6</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-consumer-feign-order80</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--micrometer-tracing指标追踪  1-->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-tracing</artifactId>
        </dependency>
        <!--micrometer-tracing-bridge-brave适配zipkin的桥接包 2-->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-tracing-bridge-brave</artifactId>
        </dependency>
        <!--micrometer-observation 3-->
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-observation</artifactId>
        </dependency>
        <!--feign-micrometer 4-->
        <dependency>
            <groupId>io.github.openfeign</groupId>
            <artifactId>feign-micrometer</artifactId>
        </dependency>
        <!--zipkin-reporter-brave 5-->
        <dependency>
            <groupId>io.zipkin.reporter2</groupId>
            <artifactId>zipkin-reporter-brave</artifactId>
        </dependency>
        <!--resilience4j-ratelimiter-->
        <dependency>
            <groupId>io.github.resilience4j</groupId>
            <artifactId>resilience4j-ratelimiter</artifactId>
        </dependency>
        <!--resilience4j-bulkhead-->
        <dependency>
            <groupId>io.github.resilience4j</groupId>
            <artifactId>resilience4j-bulkhead</artifactId>
        </dependency>
        <!--resilience4j-circuitbreaker-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-circuitbreaker-resilience4j</artifactId>
        </dependency>
        <!-- 由于断路保护等需要AOP实现，所以必须导入AOP包 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>
        <!-- httpclient5-->
        <dependency>
            <groupId>org.apache.httpcomponents.client5</groupId>
            <artifactId>httpclient5</artifactId>
            <version>5.3</version>
        </dependency>
        <!-- feign-hc5-->
        <dependency>
            <groupId>io.github.openfeign</groupId>
            <artifactId>feign-hc5</artifactId>
            <version>13.1</version>
        </dependency>
        <!--openfeign-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <!--SpringCloud consul discovery-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
        <!-- 引入自己定义的api通用包 -->
        <dependency>
            <groupId>com.atguigu.cloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <!--web + actuator-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <!--hutool-all-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
        </dependency>
        <!--fastjson2-->
        <dependency>
            <groupId>com.alibaba.fastjson2</groupId>
            <artifactId>fastjson2</artifactId>
        </dependency>
        <!-- swagger3 调用方式 http://你的主机IP地址:5555/swagger-ui/index.html -->
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

YML
```yml
# zipkin图形展现地址和采样率设置
management:
  zipkin:
    tracing:
      endpoint: http://localhost:9411/api/v2/spans
  tracing:
    sampling:
      probability: 1.0 #采样率默认为0.1(0.1就是10次只能有一次被记录下来)，值越大收集越及时。
```

新建业务类​​​​​​​​​​​​​​OrderMicrometerController
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.apis.PayFeignApi;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
/**
 * Micrometer 替代 Sleuth
 */
@RestController
@Slf4j
public class OrderMicrometerController {
    @Resource
    private PayFeignApi payFeignApi;
 
    @GetMapping(value = "/feign/micrometer/{id}")
    public String myMicrometer(@PathVariable("id") Integer id) {
        return payFeignApi.myMicrometer(id);
    }
}
```


#### 8.6.3 测试
本次案例，默认已经成功启动Zipkin
依次启动8001/80两个微服务并注册进入Consul

测试地址
http://localhost/feign/micrometer/1

打开浏览器访问：http://localhost:9411
会出现以下界面
![image.png](./img/08/1272d603b5234760a7798f85dd47e2c3.png)

点击【SHOW】按钮查看
![image.png](./img/08/371cf89d504b4251b0e79b94f413935c.png)

查看依赖关系
![image.png](./img/08/ec515049e10649f285f7a55bb97d4aa3.png)





## 9 Gateway新一代网关 
### 9.1 概述
![image.png](./img/09/39c909e9ceb541b9b8a3fa53affda255.png)

#### 9.1.1 是什么
官网
Gateway是在Spring生态系统之上构建的API网关服务，基于Spring6，Spring Boot 3和Project Reactor等技术。它旨在为微服务架构提供一种简单有效的 <font color="red">统一的 API 路由管理方式</font>，并为它们提供跨领域的关注点，例如：安全性、监控/度量和恢复能力。
![image.png](./img/09/5d20f588e8c745ea9206f371c4e72daf.png)

[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/4.0.4/reference/html/)

体系定位
Cloud全家桶中有个很重要的组件就是网关，在1.x版本中都是采用的Zuul网关；
但在2.x版本中，zuul的升级一直跳票，SpringCloud最后自己研发了一个网关 **SpringCloud Gateway** 替代Zuul，
**那就是SpringCloud Gateway** 一句话：**gateway是原zuul1.x版的替代**
![image.png](./img/09/0e726f2e9a2c4c9c9c17bc5a74ba4f07.png)

#### 9.1.2 微服务架构中网关在哪里
![image.png](./img/09/f4d2fd4e01704b13968090acfacf7d21.png)

#### 9.1.3 能干嘛
反向代理
鉴权
流量控制
熔断
日志监控

#### 9.1.4 总结
Spring Cloud Gateway组件的核心是一系列的过滤器，通过这些过滤器可以将客户端发送的请求转发(路由)到对应的微服务。 Spring Cloud Gateway是加在整个微服务最前沿的防火墙和代理器，隐藏微服务结点IP端口信息，从而加强安全保护。Spring Cloud Gateway本身也是一个微服务，需要注册进服务注册中心。
![image.png](./img/09/072578de33ac4856803da0d874df47a7.png)

### 9.2 Gateway三大核心
1 总述官网
![image.png](./img/09/16e7f0cd701b4d85b8786ee94c0f510d.png)

2 分
**Route(路由)**
路由是构建网关的基本模块，它由ID，目标URI，一系列的断言和过滤器组成，如果断言为true则匹配该路由

**Predicate(断言)**
参考的是Java8的java.util.function.Predicate
开发人员可以匹配HTTP请求中的所有内容(例如请求头或请求参数)，<font color="red">如果请求与断言相匹配则进行路由</font>

**Filter(过滤)**
指的是Spring框架中GatewayFilter的实例，使用过滤器，可以在请求被路由前或者之后对请求进行修改。

3 总结
![image.png](./img/09/7d5234dc0ce143889c4785b2e2498d68.png)

web前端请求，通过一些匹配条件，定位到真正的服务节点。并在这个转发过程的前后，进行一些精细化控制。
predicate就是我们的匹配条件；
filter，就可以理解为一个无所不能的拦截器。有了这两个元素，再加上目标uri，就可以实现一个具体的路由了

### 9.3 Gateway工作流程
官网总结
![image.png](./img/09/7b06d8d3d5054135bbceb2699e145967.png)
![image.png](./img/09/8fd80ee0fafb4c5280e2c61169647275.png)

客户端向 Spring Cloud Gateway 发出请求。然后在 Gateway Handler Mapping 中找到与请求相匹配的路由，将其发送到 Gateway Web Handler。Handler 再通过指定的过滤器链来将请求发送到我们实际的服务执行业务逻辑，然后返回。

过滤器之间用虚线分开是因为过滤器可能会在发送代理请求之前(Pre)或之后(Post)执行业务逻辑。

在“pre”类型的过滤器可以做参数校验、权限校验、流量监控、日志输出、协议转换等;

在“post”类型的过滤器中可以做响应内容、响应头的修改，日志的输出，流量监控等有着非常重要的作用。

核心逻辑
<font color="red">路由转发+断言判断+执行过滤器链 </font>


### 9.4 入门配置
建Module
cloud-gateway9527
改POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV5</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-gateway9527</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--gateway-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>
        <!--服务注册发现consul discovery,网关也要注册进服务注册中心统一管控-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-consul-discovery</artifactId>
        </dependency>
        <!-- 指标监控健康检查的actuator,网关是响应式编程删除掉spring-boot-starter-web dependency-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

写YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
```

主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
/**
 * @auther zzyy
 * @create 2023-11-20 12:38
 */
@SpringBootApplication
@EnableDiscoveryClient // 服务注册和发现
public class Main9527 {
    public static void main(String[] args) {
        SpringApplication.run(Main9527.class,args);
    }
}
```

业务类
无，不写任何业务代码，网关和业务无关

测试
先启动8500服务中心Consul
再启动9527网关入驻
![image.png](./img/09/af406c042e0e424e9b25dab9b6e09f81.png)

### 9.5 9527网关如何做路由映射
##### 9.5.1 9527网关如何做路由映射
诉求
我们目前不想暴露8001端口，希望在8001真正的支付微服务外面套一层9527网关
8001新建PayGateWayController
```java
package com.atguigu.cloud.controller;
 
import cn.hutool.core.util.IdUtil;
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.service.PayService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
import java.util.concurrent.TimeUnit;
 
@RestController
public class PayGateWayController {
    @Resource
    PayService payService;
 
    @GetMapping(value = "/pay/gateway/get/{id}")
    public ResultData<Pay> getById(@PathVariable("id") Integer id) {
        Pay pay = payService.getById(id);
        return ResultData.success(pay);
    }
 
    @GetMapping(value = "/pay/gateway/info")
    public ResultData<String> getGatewayInfo() {
        return ResultData.success("gateway info test："+ IdUtil.simpleUUID());
    }
}
```

启动8001支付
8001自测通过
http://localhost:8001/pay/gateway/get/1
http://localhost:8001/pay/gateway/info

#### 9.5.2 9527网关YML新增配置
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: http://localhost:8001                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
 
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: http://localhost:8001                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```
#### 9.5.3 测试1
启动Consul8500服务
启动8001支付
启动9527网关

访问说明
添加网关前​​​​​​​
http://localhost:8001/pay/gateway/get/1
http://localhost:8001/pay/gateway/info

隐真示假，映射说明
![image.png](./img/09/e03b30a6679944e186614dea01fed7ca.png)

添加网关后
http://localhost:9527/pay/gateway/get/1
http://localhost:9527/pay/gateway/info

目前8001支付微服务前面添加GateWay成功
![image.png](./img/09/4ff0ce8743bf49269aa0b4115e7f334b.png)

GateWay9527 → Pay8001

#### 9.5.4 测试2
##### 9.5.4.1启动订单微服务测试，看看是否通过网关？
我们启动80订单微服务，它从Consul注册中心通过微服务名称找到8001支付微服务进行调用，
80 → 9527 → 8001
**要求访问9527网关后才能访问8001**，如果我们此时启动80订单，可以做到吗？

1 修改cloud-api-commons
PayFeignApi接口
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import io.github.resilience4j.bulkhead.annotation.Bulkhead;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
 
/**
 * @auther zzyy
 * @create 2023-11-09 15:29
 */
@FeignClient(value = "cloud-payment-service")
public interface PayFeignApi {
    /**
     * 新增一条支付相关流水记录
     * @param payDTO
     * @return
     */
    @PostMapping("/pay/add")
    public ResultData addPay(@RequestBody PayDTO payDTO);
 
    /**
     * 按照主键记录查询支付流水信息
     * @param id
     * @return
     */
    @GetMapping("/pay/get/{id}")
    public ResultData getPayInfo(@PathVariable("id") Integer id);
 
    /**
     * openfeign天然支持负载均衡演示
     * @return
     */
    @GetMapping(value = "/pay/get/info")
    public String mylb();
 
    /**
     * Resilience4j CircuitBreaker 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/circuit/{id}")
    public String myCircuit(@PathVariable("id") Integer id);
 
    /**
     * Resilience4j Bulkhead 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/bulkhead/{id}")
    public String myBulkhead(@PathVariable("id") Integer id);
 
    /**
     * Resilience4j Ratelimit 的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/ratelimit/{id}")
    public String myRatelimit(@PathVariable("id") Integer id);
 
 
    /**
     * Micrometer(Sleuth)进行链路监控的例子
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/micrometer/{id}")
    public String myMicrometer(@PathVariable("id") Integer id);
 
    /**
     * GateWay进行网关测试案例01
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/gateway/get/{id}")
    public ResultData getById(@PathVariable("id") Integer id);
 
    /**
     * GateWay进行网关测试案例02
     * @return
     */
    @GetMapping(value = "/pay/gateway/info")
    public ResultData<String> getGatewayInfo();
 
}
```

2 修改cloud-consumer-feign-order80​​​​​​​
新建OrderGateWayController​​​​​​​
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.apis.PayFeignApi;
import com.atguigu.cloud.resp.ResultData;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
/**
 * @auther zzyy
 * @create 2023-11-20 16:48
 */
@RestController
public class OrderGateWayController {
    @Resource
    private PayFeignApi payFeignApi;
 
    @GetMapping(value = "/feign/pay/gateway/get/{id}")
    public ResultData getById(@PathVariable("id") Integer id){
        return payFeignApi.getById(id);
    }
 
    @GetMapping(value = "/feign/pay/gateway/info")
    public ResultData<String> getGatewayInfo(){
        return payFeignApi.getGatewayInfo();
    }
}
```

3 网关开启
测试通过
http://localhost/feign/pay/gateway/get/1
http://localhost/feign/pay/gateway/info

4 网关关闭
测试通过
http://localhost/feign/pay/gateway/get/1
http://localhost/feign/pay/gateway/info

5 结论
9527网关是否启动，毫无影响
目前的配置来看，网关被绕开了

##### 9.5.4.2 正确做法
同一家公司自己人，系统内环境，直接找微服务
```java
@FeignClient(value = "cloud-payment-service")//自己人内部，自己访问自己，写微服务名字OK
public interface PayFeignApi {
    /**
     * GateWay进行网关测试案例01
     * @param id
     * @return
     */
    @GetMapping(value = "/pay/gateway/get/{id}")
    public ResultData getById(@PathVariable("id") Integer id);
 
    /**
     * GateWay进行网关测试案例02
     * @return
     */
    @GetMapping(value = "/pay/gateway/info")
    public ResultData<String> getGatewayInfo();
}
```

不同家公司有外人，系统外访问，先找网关再服务
![image.png](./img/09/852681bce9dd4ebcb7e3cca952c06c97.png)
![image.png](./img/09/5ec39ffbf5514181a88d14ebce92df20.png)

刷新feign接口jar包
重启80订单微服务
有网关正常success
![image.png](./img/09/345fde770e6e49779435f1d3df3ef539.png)

#### 9.5.​​​​​​​5 存在问题
网关9527的yml配置，映射写死问题
![image.png](./img/09/6e22eb7049814c7daa4634c6f33d7a25.png)

### 9.6 GateWay高级特性
#### 9.6.1 Route以微服务名-动态获取服务URI​​​​​​​
痛点
![image.png](./img/09/6e22eb7049814c7daa4634c6f33d7a25.png)

是什么
![image.png](./img/09/3c1d4317f21a456b9b6ec3aba3fb507b.png)

解决uri地址写死问题
9527修改前YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: http://localhost:8001                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: http://localhost:8001                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

9527修改后YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

测试1
重启网关9527，80/8001保持不变
http://localhost/feign/pay/gateway/get/1

测试2
如果将8001微服务yml文件端口修改为8007，照样访问。我实际启动的程序是main8001，但是端口名改为8007
![image.png](./img/09/81a2040906fd499eb92ac09c015f9810.png)

我们依据微服务名字，匹配查找即可
uri: lb://cloud-payment-service

#### 9.6.2 Predicate断言(谓词)
##### 9.6.2.1 是什么
[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/4.0.4/reference/html/#gateway-request-predicates-factories)

Route Predicate Factories是什么
![image.png](./img/09/1618a10a0c4946f3bee8a1e72fd8913b.png)

##### 9.6.2.2 启动微服务gateway9527，看看IDEA后台的输出
![image.png](./img/09/72accbaa3ff447cc9de56f955f31a20e.png)

##### 9.6.2.3 整体架构概述
![image.png](./img/09/2c7b58bc9ccc4bf7acb567eacd8c2380.png)

##### 9.6.2.4 常用的内置Route Predicate
1 配置语法总体概述
两种配置，二选一​​​​​​​
![image.png](./img/09/ca4c935ff580482586e9f7cf6576a944.png)

[Configuring Route Predicate Factories and Gateway Filter Factories :: Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/reference/spring-cloud-gateway/configuring-route-predicate-factories-and-filter-factories.html)

Most examples below use the shortcut way

Shortcut Configuration
![image.png](./img/09/fc4873e907174746a2f23e057e454d91.png)

Fully Expanded Arguments
![image.png](./img/09/edc88044a3904a60848a20f0b4e65ef7.png)

2 测试地址
http://localhost:9527/pay/gateway/get/1

3 常用断言api
```
#id：我们自定义的路由 ID，保持唯一
##uri：目标服务地址
##predicates：路由条件，Predicate接受一个输入参数返回一个布尔值。
##            该属性包含多种默认方法来将Predicate组合成其他复杂的逻辑(比如：与，或，非)
```

1 After Route Predicate
![image.png](./img/09/828153641c4b4820a827f82dcd3a7335.png)
我们的问题是：上述这个After好懂，这个时间串串？？？对应的格式如何获得？

如何获得ZonedDateTime
```java
package com.atguigu.test;


import java.time.ZoneId;
import java.time.ZonedDateTime;

/**
 * @auther zzyy
 * @create 2019-12-02 17:37
 */
public class ZonedDateTimeDemo {
     public static void main(String[] args) {
        ZonedDateTime zbj = ZonedDateTime. now();  //  默认时区
              System. out.println(zbj);
    }
}
```
![image.png](./img/09/9595e9a8124547a2b2326952de480b2a.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

2 Before Route Predicate(家庭作业)​​​​​​​
![image.png](./img/09/9924eb70bb564e9c8914a11502b72072.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-11-27T15:25:06.424566300+08:00[Asia/Shanghai] #超过规定时间不可访问
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

3 Between Route Predicate(家庭作业)
![image.png](./img/09/f6e08c39d8f343098b2420432573dc7c.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Before=2023-11-20T17:58:13.586918800+08:00[Asia/Shanghai]
            - Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

4 Cookie Route Predicate
![image.png](./img/09/7a55ad2f109342b2a29be09cafb7b3aa.png)
> Cookie Route Predicate需要两个参数，一个是 Cookie name ,一个是正则表达式。
路由规则会通过获取对应的 Cookie name 值和正则表达式去匹配，如果匹配上就会执行路由，如果没有匹配上则不执行

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            - Cookie=username,zzyy
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

方法1，原生命令
不带cookie参数   curl http://localhost:9527/pay/gateway/get/1
![image.png](./img/09/3c2a10750a1744a48e49ee08345117b1.png)

自带cookie参数  curl http://localhost:9527/pay/gateway/get/1 --cookie "username=zzyy"
![image.png](./img/09/e760e3cc98bf4b32ab2a227518931b06.png)

方法2，postman
![image.png](./img/09/9a297a026c1444ce95fdb216cdebbc58.png)

方法3，chrome浏览器
![image.png](./img/09/54f3cf48ea8745c7a937958953ce4c20.png)

5 Header Route Predicate
![image.png](./img/09/4c64a5aa72cf4479b9ac78bee3b3861f.png)
两个参数：一个是属性名称和一个正则表达式，这个属性值和正则表达式匹配则执行。

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            - Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

方法1，原生命令
![image.png](./img/09/abcfc15c2f344b44b4e4b49a8d290819.png)
curl http://localhost:9527/pay/gateway/get/1 -H  "X-Request-Id:password"
curl http://localhost:9527/pay/gateway/get/1 -H  "X-Request-Id:abcd"

方法2，postman
上图正确，下图错误验证
![image.png](./img/09/936bad401d6a43a291e75a0aa0f3838e.png)
>===================================================================
![image.png](./img/09/c4aebc5ec3d74980b811a6c52733c8ea.png)

6 Host Route Predicate
![image.png](./img/09/edf76aed5e7a4f59ae7f6c6099dd7e6d.png)

Host Route Predicate 接收一组参数，一组匹配的域名列表，这个模板是一个 ant 分隔的模板，用.号作为分隔符。
它通过参数中的主机地址作为匹配规则。

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            - Host=**.atguigu.com
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

方法1，原生命令
![image.png](./img/09/27f28c220d7d49c197b21f38ffc29315.png)

正确：     curl http://localhost:9527/pay/gateway/get/3 -H  "Host:www.atguigu.com"
正确：     curl http://localhost:9527/pay/gateway/get/3 -H  "Host:java.atguigu.com"
错误：     curl http://localhost:9527/pay/gateway/get/3 -H  "Host:java.atguigu.net"

方法2，postman
![image.png](./img/09/09d2d731e63f41eea1090d7d0b74a181.png)

7 Path Route Predicate
![image.png](./img/09/cd0cd7be425749dfabc0b41028419f96.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            - Host=**.atguigu.com
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

8 Query Route Predicate
![image.png](./img/09/91eac1bf6aac4242a3a8d9778050c51a.png)
支持传入两个参数，一个是属性名，一个为属性值，**属性值可以是正则表达式**。

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            - Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

测试
http://localhost:9527/pay/gateway/get/3?username=aaa
http://localhost:9527/pay/gateway/get/3?username=abc 要有参数名username并且值还要是整数才能路由
![image.png](./img/09/7f7efde78a254200ac1e32597d1321e9.png)

9 RemoteAddr route predicate
![image.png](./img/09/a22f8a4f645e46679db52233a5c6eb2e.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            - RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

CIDR网络IP划分(无类别域间路由Classless Inter-Domain Routing缩写)
![image.png](./img/09/3a8c505b69864a53bdbfb24d57d1ee83.png)

10 Method Route Predicate(家庭作业)
![image.png](./img/09/c9ac0d857d104a6982872512254748d3.png)
配置某个请求地址，只能用Get/Post方法访问，方法限制

4 上述配置小总结
All
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```
Predicate就是为了实现一组匹配规则，让请求过来找到对应的Route进行处理。

##### 9.6.2.5 自定义断言，XXXRoutePredicateFactory规则
痛点
原有的断言配置不满足业务怎么办？
看看AfterRoutePredicateFactory

源代码：
![image.png](./img/09/52c0dcd899304cafbafdfbb4018d0a85.png)
```java
public abstract class AbstractRoutePredicateFactory<C> extends AbstractConfigurable<C> implements RoutePredicateFactory<C> {
  public AbstractRoutePredicateFactory(Class<C> configClass) {
    super(configClass);
  }
}
```

架构概述
![image.png](./img/09/3375203281a342118303c88c377538c4.png)

模板套路
要么继承AbstractRoutePredicateFactory抽象类
要么实现RoutePredicateFactory接口
开头任意取名，但是必须以RoutePredicateFactory后缀结尾

自定义路由断言规则步骤套路
需求说明：自定义配置会员等级userTpye，按照钻/金/银和yml配置的会员等级，以适配是否可以访问

编写步骤​​​​​​​
1 新建类名XXX需要以RoutePredicateFactory结尾并继承AbstractRoutePredicateFactory类​​​​​​​
```java
@Component // 标注不可忘
public class MyRoutePredicateFactory extends AbstractRoutePredicateFactory<MyRoutePredicateFactory.Config> {
    
}
```

2 重写apply方法
```java
@Override
public Predicate<ServerWebExchange> apply(MyRoutePredicateFactory.Config config) {
    return null;
}
```

3 新建apply方法所需要的静态内部类MyRoutePredicateFactory.Config，
**这个Config类就是我们的路由断言规则，重要**
```java
// 这个Config类就是我们的路由断言规则，重要
@Validated
public static class Config{
    @Setter
    @Getter
    @NotEmpty
    private String userType; // 钻、金、银等用户等级
}
```

4 空参构造方法，内部调用super
```java
public MyRoutePredicateFactory(){
    super(MyRoutePredicateFactory.Config.class);
}
```

5 重写apply方法第二版
```java
@Override
public Predicate<ServerWebExchange> apply(MyRoutePredicateFactory.Config config){
    return new Predicate<ServerWebExchange>(){
        @Override
        public boolean test(ServerWebExchange serverWebExchange){
            //检查request的参数里面，userType是否为指定的值，符合配置就通过
            String userType = serverWebExchange.getRequest().getQueryParams().getFirst("userType");
 
            if (userType == null) return false;
 
            //如果说参数存在，就和config的数据进行比较
            if(userType.equals(config.getUserType())) {
                return true;
            }
 
            return false;
        }
    };
}
```

完整代码V1
```java
package com.atguigu.cloud.mygateway;
 
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.cloud.gateway.handler.predicate.AbstractRoutePredicateFactory;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.server.ServerWebExchange;
 
import java.util.function.Predicate;
 
@Component
public class MyRoutePredicateFactory extends AbstractRoutePredicateFactory<MyRoutePredicateFactory.Config>{
    public MyRoutePredicateFactory() {
        super(MyRoutePredicateFactory.Config.class);
    }
 
    @Validated
    public static class Config{
        @Setter
        @Getter
        @NotEmpty
        private String userType; //钻、金、银等用户等级
    }
 
    @Override
    public Predicate<ServerWebExchange> apply(MyRoutePredicateFactory.Config config){
        return new Predicate<ServerWebExchange>(){
            @Override
            public boolean test(ServerWebExchange serverWebExchange){
                //检查request的参数里面，userType是否为指定的值，符合配置就通过
                String userType = serverWebExchange.getRequest().getQueryParams().getFirst("userType");
 
                if (userType == null) return false;
 
                //如果说参数存在，就和config的数据进行比较
                if(userType.equals(config.getUserType())) {
                    return true;
                }
 
                return false;
            }
        };
    }
}
```

测试1
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

启动后
故障现象
![image.png](./img/09/e5a62b7b1f844c828069c666b03361a9.png)
Caused by: org.springframework.boot.context.properties.bind.validation.BindValidationException: Binding validation errors on 

导致原因
为什么Shortcut Configuration不生效？
![image.png](./img/09/3590cca20c294ab9b3d866a24687d8aa.png)

解决方案
先解决问题，让我们自定义的能用
Fully Expanded Arguments

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            #- My=diamond
            - name: My
              args:
                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

http://localhost:9527/pay/gateway/get/1?userType=diamond
success
![image.png](./img/09/fc66f277fcbb42cf8b1195e275f34a69.png)
![image.png](./img/09/6797abad9e5a48658705b45046633f3f.png)

bug分析
缺少shortcutFieldOrder方法的实现，所以不支持短格式
![image.png](./img/09/23fe5bea21d4477fae1c92324766e8f7.png)

测试2
完整代码02
```java
package com.atguigu.cloud.mygateway;
 
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.cloud.gateway.handler.predicate.AbstractRoutePredicateFactory;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.server.ServerWebExchange;
 
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;
 
/**
 * @auther zzyy
 * @create 2023-04-23 18:30
 */
@Component
public class MyRoutePredicateFactory extends AbstractRoutePredicateFactory<MyRoutePredicateFactory.Config>{
    public MyRoutePredicateFactory()    {
        super(MyRoutePredicateFactory.Config.class);
    }
 
    @Validated
    public static class Config{
        @Setter
        @Getter
        @NotEmpty
        private String userType; //钻、金、银等用户等级
    }
 
    @Override
    public Predicate<ServerWebExchange> apply(MyRoutePredicateFactory.Config config){
        return new Predicate<ServerWebExchange>(){
            @Override
            public boolean test(ServerWebExchange serverWebExchange){
                //检查request的参数里面，userType是否为指定的值，符合配置就通过
                String userType = serverWebExchange.getRequest().getQueryParams().getFirst("userType");
 
                if (userType == null) return false;
 
                //如果说参数存在，就和config的数据进行比较
                if(userType.equals(config.getUserType())) {
                    return true;
                }
 
                return false;
            }
        };
    }
 
@Override
public List<String> shortcutFieldOrder() {
  return Collections.singletonList("userType");
}
}
```

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=diamond
            #- name: My
            #  args:
            #    userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
```

重启9527并测试
http://localhost:9527/pay/gateway/get/1?userType=diamond

#### 9.6.3 Filter过滤
##### 9.6.3.1 概述
官网
[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gatewayfilter-factories)

一句话
**SpringMVC里面的的拦截器Interceptor，Servlet的过滤器​​​​​​​**

“pre”和 “post” 分别会在请求被执行前调用和被执行后调用，用来修改请求和响应信息
![image.png](./img/09/7c1a82dd40a14448b062e017c9fc350c.png)

作用：
请求鉴权
异常处理
记录接口调用时长统计，重点，大厂面试设计题
...


类型
1 全局默认过滤器Global Filters
[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#global-filters)

gateway出厂默认已有的，直接用即可，主要作用于所有的路由
不需要在配置文件中配置，作用在所有的路由上，实现GlobalFilter接口即可

2 单一内置过滤器GatewayFilter
[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/4.0.4/reference/html/#gatewayfilter-factories)
也可以称为网关过滤器，这种过滤器主要是作用于单一路由或者某个路由分组

3 自定义过滤器

##### 9.6.3.2 Gateway内置的过滤器
1 是什么
官网​​​​​​​
[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gatewayfilter-factories)

单一内置过滤器GatewayFilter
![image.png](./img/09/51ec5d0e4c6948a48a51a893c64a3bfe.png)

2 只讲解常见和通用的，Not All
3 常用的内置过滤器

1 请求头(RequestHeader)相关组

6.1. The AddRequestHeader GatewayFilter Factory​​​​​​​
指定请求头内容ByName​​​​​​​
8001微服务PayGateWayController新增方法
```java
package com.atguigu.cloud.controller;
 
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.atguigu.cloud.entities.Pay;
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.service.PayService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
import java.util.Enumeration;
import java.util.concurrent.TimeUnit;
 
@RestController
public class PayGateWayController{
    @Resource
    PayService payService;
 
    @GetMapping(value = "/pay/gateway/get/{id}")
    public ResultData<Pay> getById(@PathVariable("id") Integer id){
        Pay pay = payService.getById(id);
        return ResultData.success(pay);
    }
 
    @GetMapping(value = "/pay/gateway/info")
    public ResultData<String> getGatewayInfo(){
        return ResultData.success("gateway info test："+ IdUtil.simpleUUID());
    }
 
    @GetMapping(value = "/pay/gateway/filter")
    public ResultData<String> getGatewayFilter(HttpServletRequest request){
        String result = "";
        Enumeration<String> headers = request.getHeaderNames();
        while(headers.hasMoreElements()){
            String headName = headers.nextElement();
            String headValue = request.getHeader(headName);
            System.out.println("请求头名: " + headName +"\t\t\t"+"请求头值: " + headValue);
            if(headName.equalsIgnoreCase("X-Request-atguigu1")
                    || headName.equalsIgnoreCase("X-Request-atguigu2")) {
                result = result+headName + "\t " + headValue +" ";
            }
        }
        return ResultData.success("getGatewayFilter 过滤器 test： "+result+" \t "+ DateUtil.now());
    }
}
```

9527网关YML添加过滤内容
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
```

重启9527和8001并再次调用地址
http://localhost:9527/pay/gateway/filter


6.18. The RemoveRequestHeader GatewayFilter Factory
删除请求头ByName
修改前
![image.png](./img/09/3afd9af779cf4b228cb779f0daa19d32.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
            - RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
```

重启9527和8001并再次调用地址
http://localhost:9527/pay/gateway/filter

修改后
![image.png](./img/09/2d7d2906926b4a249baf4e804973023e.png)

6.29. The SetRequestHeader GatewayFilter Factory
修改请求头ByName
修改前(sec-fetch-mode​​​​​​​)
![image.png](./img/09/b04968ec7ca24e41b6700ba3fcd42888.png)

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
            - RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            - SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
```

重启9527和8001并再次调用地址
http://localhost:9527/pay/gateway/filter

修改后
![image.png](./img/09/df88a7f7d0664d2db2a98a956443698b.png)

2 请求参数(RequestParameter)相关组
6.3. The AddRequestParameter GatewayFilter Factory​​​​​​​
6.19. The RemoveRequestParameter GatewayFilter Factory
上述两个合一块
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
            - RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            - SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            - AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            - RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
```

修改PayGateWayController
```java
@GetMapping(value = "/pay/gateway/filter")
public ResultData<String> getGatewayFilter(HttpServletRequest request){
    String result = "";
    Enumeration<String> headers = request.getHeaderNames();
    while(headers.hasMoreElements()){
        String headName = headers.nextElement();
        String headValue = request.getHeader(headName);
        System.out.println("request headName:" + headName +"---"+"request headValue:" + headValue);
 
        if(headName.equalsIgnoreCase("X-Request-atguigu1")
                || headName.equalsIgnoreCase("X-Request-atguigu2")) {
            result = result+headName + "\t " + headValue +" ";
        }
    }
 
    System.out.println("=============================================");
    String customerId = request.getParameter("customerId");
    System.out.println("request Parameter customerId: "+customerId);
 
    String customerName = request.getParameter("customerName");
    System.out.println("request Parameter customerName: "+customerName);
    System.out.println("=============================================");
 
    return ResultData.success("getGatewayFilter 过滤器 test： "+result+" \t "+ DateUtil.now());
}
```

测试
http://localhost:9527/pay/gateway/filter
![image.png](./img/09/f6ea4cd045bb431b9b4313fd501fd1b6.png)

http://localhost:9527/pay/gateway/filter?customerId=9999&customerName=z3
![image.png](./img/09/32c0e596c3f04db8b6431551292f0e81.png)

3 回应头(ResponseHeader)相关组
开启配置前，按照地址chrome查看一下​​​​​​​
http://localhost:9527/pay/gateway/filter
![image.png](./img/09/dd69fb6a1b5241f5978fce904658f84f.png)

6.4. The AddResponseHeader GatewayFilter Factory
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
            - RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            - SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            - AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            - RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            - AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
```

6.30. The SetResponseHeader GatewayFilter Factory
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
            - RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            - SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            - AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            - RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            - AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
            - SetResponseHeader=Date,2099-11-11 # 设置回应头Date值为2099-11-11
```

6.20. The RemoveResponseHeader GatewayFilter Factory
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            - AddRequestHeader=X-Request-atguigu2,atguiguValue2
            - RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            - SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            - AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            - RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            - AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
            - SetResponseHeader=Date,2099-11-11 # 设置回应头Date值为2099-11-11
            - RemoveResponseHeader=Content-Type # 将默认自带Content-Type回应属性删除
```

开启配置后，上面三个配置打包一块上
![image.png](./img/09/1baa6c8fbd0642a99aacb12443a73740.png)

4 前缀和路径相关组
6.14. The PrefixPath GatewayFilter Factory​​​​​​​

自动添加路径前缀​​​​​​​
之前的正确地址
http://localhost:9527/pay/gateway/filter

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24。
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            #- Path=/pay/gateway/filter/**   # 被分拆为: PrefixPath + Path
 
            - Path=/gateway/filter/**              # 断言，为配合PrefixPath测试过滤，暂时注释掉/pay
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  #请求头kv，若一头含有多参则重写一行设置
            #- AddRequestHeader=X-Request-atguigu2,atguiguValue2
            #- RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            #- SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            #- AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            #- RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            #- AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
            #- SetResponseHeader=Date,2099-11-11 # 设置回应头Date值为2099-11-11
            #- RemoveResponseHeader=Content-Type # 将默认自带Content-Type回应属性删除
            - PrefixPath=/pay # http://localhost:9527/pay/gateway/filter
```

分拆说明
![image.png](./img/09/9d222c779cea4d4abdd4a0b90ee48c63.png)
<table>
  <tr>
    <td>之前完整正确地址：</td>
    <td>http://localhost:9527/pay/gateway/filter</td>
  </tr>
  <tr>
    <td>现在完整组合地址：</td>
    <td>PrefixPath + Path</td>
  </tr>
  <tr>
    <td>实际调用地址：</td>
    <td>http://localhost:9527/gateway/filter <font color="red">相当于说前缀被过滤器统一管理了。</font> </td>
  </tr>
</table>

Chrome测试
![image.png](./img/09/4332168b98d34266bdc0369dd68cfd93.png)

6.29. The SetPath GatewayFilter Factory
访问路径修改​​​​​​​
测试
YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.1.196/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24。
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            #- Path=/pay/gateway/filter/** # 真实地址
            #- Path=/gateway/filter/**              # 断言，为配合PrefixPath测试过滤，暂时注释掉/pay
            - Path=/XYZ/abc/{segment}           # 断言，为配合SetPath测试，{segment}的内容最后被SetPath取代
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  #请求头kv，若一头含有多参则重写一行设置
                        #- AddRequestHeader=X-Request-atguigu2,atguiguValue2
            #- RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            #- SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            #- AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            #- RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            #- AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
            #- SetResponseHeader=Date,2099-11-11 # 设置回应头Date值为2099-11-11
            #- RemoveResponseHeader=Content-Type # 将默认自带Content-Type回应属性删除
                        #- PrefixPath=/pay # http://localhost:9527/pay/gateway/filter
            - SetPath=/pay/gateway/{segment}  # {segment}表示占位符，你写abc也行但要上下一致
```

说明：
![image.png](./img/09/9d0e473daebc4fe6929811eaf26c9b86.png)

浏览器访问地址: http://localhost:9527/XYZ/abc/filter
实际微服务地址：http://localhost:9527/pay/gateway/filter
http://localhost:9527/XYZ/abc/filter

结果
![image.png](./img/09/83e68411d02d41fea516286ff9849224.png)
![image.png](./img/09/0c8d84d8057e4990a556e85055d9b8b8.png)

6.16. The RedirectTo GatewayFilter Factory
重定向到某个页面
http://localhost:9527/pay/gateway/filter

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service          #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            #- After=2023-11-20T17:38:13.586918800+08:00[Asia/Shanghai]
            - Before=2023-12-29T17:58:13.586918800+08:00[Asia/Shanghai]
            #- Between=2023-11-21T17:38:13.586918800+08:00[Asia/Shanghai],2023-11-22T17:38:13.586918800+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            #- Header=X-Request-Id, \d+  # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.1.196/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24。
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/** # 真实地址
            #- Path=/gateway/filter/**              # 断言，为配合PrefixPath测试过滤，暂时注释掉/pay
            #- Path=/XYZ/abc/{segment}           # 断言，为配合SetPath测试，{segment}的内容最后被SetPath取代
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  #请求头kv，若一头含有多参则重写一行设置
            #- AddRequestHeader=X-Request-atguigu2,atguiguValue2
            #- RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            #- SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            #- AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            #- RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            #- AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
            #- SetResponseHeader=Date,2099-11-11 # 设置回应头Date值为2099-11-11
            #- RemoveResponseHeader=Content-Type # 将默认自带Content-Type回应属性删除
            #- PrefixPath=/pay # http://localhost:9527/pay/gateway/filter
            - RedirectTo=302, http://www.atguigu.com/ # 访问http://localhost:9527/pay/gateway/filter跳转到http://www.atguigu.com/
```

5 其它
6.38. Default Filters
配置在此处相当于全局通用，自定义秒变Global
![image.png](./img/09/b54f87a82dda43959f04acd631658376.png)

本次案例全部YML配置全集
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
            #- Cookie=username,zzyy
            # - Header=X-Request-Id, \d+ # 请求头要有X-Request-Id属性并且值为整数的正则表达式
            #- Host=**.atguigu.com
            #- Query=username, \d+  # 要有参数名username并且值还要是整数才能路由
            #- RemoteAddr=192.168.124.1/24 # 外部访问我的IP限制，最大跨度不超过32，目前是1~24它们是 CIDR 表示法。
            - My=gold
#            - name: My
#              args:
#                userType: diamond
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          #uri: http://localhost:8001                #匹配后提供服务的路由地址
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由，默认正确地址
            #- Path=/gateway/filter/**              # 断言，为配合PrefixPath测试过滤，暂时注释掉/pay
            #- Path=/XYZ/abc/{segment}           # 断言，为配合SetPath测试，{segment}的内容最后被SetPath取代
          filters:
            - RedirectTo=302, http://www.atguigu.com/ # 访问http://localhost:9527/pay/gateway/filter跳转到http://www.atguigu.com/
            #- SetPath=/pay/gateway/{segment}  # {segment}表示占位符，你写abc也行但要上下一致
            #- PrefixPath=/pay # http://localhost:9527/pay/gateway/filter  被分拆为: PrefixPath + Path
            #- AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
            #- AddRequestHeader=X-Request-atguigu2,atguiguValue2
            #- RemoveRequestHeader=sec-fetch-site      # 删除请求头sec-fetch-site
            #- SetRequestHeader=sec-fetch-mode, Blue-updatebyzzyy # 将请求头sec-fetch-mode对应的值修改为Blue-updatebyzzyy
            #- AddRequestParameter=customerId,9527001 # 新增请求参数Parameter：k ，v
            #- RemoveRequestParameter=customerName   # 删除url请求参数customerName，你传递过来也是null
            #- AddResponseHeader=X-Response-atguigu, BlueResponse # 新增请求参数X-Response-atguigu并设值为BlueResponse
            #- SetResponseHeader=Date,2099-11-11 # 设置回应头Date值为2099-11-11
            #- RemoveResponseHeader=Content-Type # 将默认自带Content-Type回应属性删除
```

##### 9.6.3.3 Gateway自定义过滤器
1 自定义全局Filter

1.1 面试题
统计接口调用耗时情况，如何落地，谈谈设计思路
通过自定义全局过滤器搞定上述需求

1.2 案例
自定义接口调用耗时统计的全局过滤器
知识出处
[Spring Cloud Gateway](https://docs.spring.io/spring-cloud-gateway/docs/current/reference/html/#gateway-combined-global-filter-and-gatewayfilter-ordering)

步骤
新建类MyGlobalFilter并实现GlobalFilter，Ordered两个接口
```java
package com.atguigu.cloud.mygateway;
 
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
 
@Component //不要忘记
@Slf4j
public class MyGlobalFilter implements GlobalFilter, Ordered{
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain){
        return null;
    }
 
    @Override
    public int getOrder(){
        return 0;
    }
}
```

YML
```yml
server:
  port: 9527
 
spring:
  application:
    name: cloud-gateway #以微服务注册进consul或nacos服务列表内
  cloud:
    consul: #配置consul地址
      host: localhost
      port: 8500
      discovery:
        prefer-ip-address: true
        service-name: ${spring.application.name}
    gateway:
      routes:
        - id: pay_routh1 #pay_routh1                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/get/**              # 断言，路径相匹配的进行路由
            - After=2023-12-30T23:02:39.079979400+08:00[Asia/Shanghai]
 
        - id: pay_routh2 #pay_routh2                #路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: lb://cloud-payment-service
          predicates:
            - Path=/pay/gateway/info/**              # 断言，路径相匹配的进行路由
 
        - id: pay_routh3 #pay_routh3
          uri: lb://cloud-payment-service                #匹配后提供服务的路由地址
          predicates:
            - Path=/pay/gateway/filter/**              # 断言，路径相匹配的进行路由，默认正确地址
          filters:
            - AddRequestHeader=X-Request-atguigu1,atguiguValue1  # 请求头kv，若一头含有多参则重写一行设置
```

code
```java
package com.atguigu.cloud.mygateway;
 
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
 
@Component
@Slf4j
public class MyGlobalFilter implements GlobalFilter, Ordered{
 
    /**
     * 数字越小优先级越高
     * @return
     */
    @Override
    public int getOrder(){
        return 0;
    }
 
    private static final String BEGIN_VISIT_TIME = "begin_visit_time";//开始访问时间
    /**
     *第2版，各种统计
     * @param exchange
     * @param chain
     * @return
     */
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        //先记录下访问接口的开始时间
        exchange.getAttributes().put(BEGIN_VISIT_TIME, System.currentTimeMillis());
 
        return chain.filter(exchange).then(Mono.fromRunnable(()->{
            Long beginVisitTime = exchange.getAttribute(BEGIN_VISIT_TIME);
            if (beginVisitTime != null){
                log.info("访问接口主机: " + exchange.getRequest().getURI().getHost());
                log.info("访问接口端口: " + exchange.getRequest().getURI().getPort());
                log.info("访问接口URL: " + exchange.getRequest().getURI().getPath());
                log.info("访问接口URL参数: " + exchange.getRequest().getURI().getRawQuery());
                log.info("访问接口时长: " + (System.currentTimeMillis() - beginVisitTime) + "ms");
                log.info("我是美丽分割线: ###################################################");
                System.out.println();
            }
        }));
    }
 
}
```

测试
http://localhost:9527/pay/gateway/info
![image.png](./img/09/ef2fd32d02294a3dbe6ebd051ebf0fa1.png)

http://localhost:9527/pay/gateway/get/1
![image.png](./img/09/8a731f34ad8b43798be546161854caa4.png)

http://localhost:9527/pay/gateway/filter
![image.png](./img/09/0fad95df74504fe291cea6749d6be2aa.png)

2 自定义条件Filter
自定义，单一内置过滤器GatewayFilter

先参考GateWay内置出厂默认的
for example：
SetStatusGatewayFilterFactory
SetPathGatewayFilterFactory
AddResponseHeaderGatewayFilterFactory
......

自定义网关过滤器规则步骤套路 
新建类名XXX需要以GatewayFilterFactory结尾并继承AbstractGatewayFilterFactory类​​​​​​​
```java
@Component//标注不可忘
public class MyGatewayFilterFactory extends AbstractGatewayFilterFactory<MyGatewayFilterFactory.Config>{
 
}
```

新建XXXGatewayFilterFactory.Config内部类
```java
@Component
public class MyGatewayFilterFactory extends AbstractGatewayFilterFactory<MyGatewayFilterFactory.Config>{
    public static class Config {
        @Setter @Getter
        private String status;//设定一个状态值/标志位，它等于多少，匹配和才可以访问
    }
}
```

重写apply方法
```java
package com.atguigu.cloud.mygateway;
 
import lombok.Getter;
import lombok.Setter;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
 
@Component
public class MyGatewayFilterFactory extends AbstractGatewayFilterFactory<MyGatewayFilterFactory.Config>{
    @Override
    public GatewayFilter apply(MyGatewayFilterFactory.Config config){
        return new GatewayFilter() {
            @Override
            public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
                ServerHttpRequest request =  exchange.getRequest();
                System.out.println("进入自定义网关过滤器MyGatewayFilterFactory，status===="+config.getStatus());
                if(request.getQueryParams().containsKey("atguigu")) {
                    return chain.filter(exchange);
                }else {
                    exchange.getResponse().setStatusCode(HttpStatus.BAD_REQUEST);
                    return exchange.getResponse().setComplete();
                }
            }
        };
    }
 
    public static class Config {
        @Setter @Getter
        private String status;
    }
}
```

重写shortcutFieldOrder
```java
@Override
public List<String> shortcutFieldOrder() {
    List<String> list = new ArrayList<String>();
    list.add("status");
    return list;
}
```

空参构造方法，内部调用super
```java
public MyGatewayFilterFactory() {
    super(MyGatewayFilterFactory.Config.class);
}
```

完整代码01
```java
package com.atguigu.cloud.mygateway;
 
import lombok.Getter;
import lombok.Setter;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.cloud.gateway.filter.factory.SetPathGatewayFilterFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
 
import java.util.Arrays;
import java.util.List;
 
@Component
public class MyGatewayFilterFactory extends AbstractGatewayFilterFactory<MyGatewayFilterFactory.Config>{
    public MyGatewayFilterFactory(){
        super(MyGatewayFilterFactory.Config.class);
    }
 
 
    @Override
    public GatewayFilter apply(MyGatewayFilterFactory.Config config){
        return new GatewayFilter(){
            @Override
            public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
                ServerHttpRequest request = exchange.getRequest();
                System.out.println("进入了自定义网关过滤器MyGatewayFilterFactory，status："+config.getStatus());
                if(request.getQueryParams().containsKey("atguigu")){
                    return chain.filter(exchange);
                }else{
                    exchange.getResponse().setStatusCode(HttpStatus.BAD_REQUEST);
                    return exchange.getResponse().setComplete();
                }
            }
        };
    }
 
    @Override
    public List<String> shortcutFieldOrder() {
        return Arrays.asList("status");
    }
 
    public static class Config{
        @Getter@Setter
        private String status;//设定一个状态值/标志位，它等于多少，匹配和才可以访问
    }
}
//单一内置过滤器GatewayFilter
```

YML
My补充说明：
出厂默认
![image.png](./img/09/b9ffcc81e62f459d931df34c41cbf2f1.png)

自己定制My
![image.png](./img/09/139327989b48417783a97ccbe31d08c4.png)
![image.png](./img/09/46d4fb7d75b34bce9c5e30124ce6f86e.png)

测试
✖  ​​​​​​​
✔ ?atguigu=java
![image.png](./img/09/6f16c99691e5425795c625be0be60de5.png)

### 9.7 GateWay整合阿里巴巴Sentinel实现容错
见后续springcloud alibaba篇章
























