# SpringCloud 笔记 10 - 13



## 10 SpringCloud Alibaba入门简介
![image.png](./img/10/39c909e9ceb541b9b8a3fa53affda255.png)

### 10.1 概念
诞生
2018.10.31，Spring Cloud Alibaba 正式入驻了 Spring Cloud 官方孵化器，并在 Maven 中央库发布了第一个版本。
![image.png](./img/10/5dadb2a38d4e4d2ca191413bef3ec2d2.png)

[Spring Cloud Alibaba](https://spring.io/projects/spring-cloud-alibaba)
![image.png](./img/10/7cccbcc1c8544ed2b82185e2933084aa.png)

介绍
![image.png](./img/10/2e7831456c044e48bdefccd480450e35.png)

### 10.2 作用
https://github.com/alibaba/spring-cloud-alibaba/blob/2022.x/README-zh.md
![image.png](./img/10/ef2762261a7d44a88cd2fe3fef4f00ec.png)

### 10.3 下载
官网定义：
https://github.com/alibaba/spring-cloud-alibaba/wiki
https://github.com/alibaba/spring-cloud-alibaba/blob/2022.x/README-zh.md

### 10.4 使用
![image.png](./img/10/aa8e6f91bc9e4bae81fc5427742ec5e3.png)
![image.png](./img/10/8dd65f82953c4b339d13785bde4882ee.png)

### 10.5 毕业版本依赖关系(推荐使用)
https://github.com/alibaba/spring-cloud-alibaba/wiki/%E7%89%88%E6%9C%AC%E8%AF%B4%E6%98%8E

![image.png](./img/10/877e07d03c544fa89eac82798e74fa04.png)

### 10.6 SpringCloud Alibaba开发参考文档
英文
[Spring Cloud Alibaba Reference Documentation](https://spring-cloud-alibaba-group.github.io/github-pages/2022/en-us/2022.0.0.0-RC2.html)

中文
[Spring Cloud Alibaba 参考文档](https://spring-cloud-alibaba-group.github.io/github-pages/2022/zh-cn/2022.0.0.0-RC2.html)



## 11 SpringCloud Alibaba Nacos服务注册和配置中心
![image.png](./img/10/39c909e9ceb541b9b8a3fa53affda255.png)

### 11.1 总体介绍
![image.png](./img/11/da013bc92ef44fb8950a20c109744ea2.png)

### 11.2 Nacos简介
#### 11.2.1 为什么叫Nacos这个名字
![image.png](./img/11/f7ce5a24298d451aae94886bc4bd6339.png)

Nacos: Dynamic Naming and Configuration Service
前四个字母分别为Naming和Configuration的前两个字母，最后的s为Service

#### 11.2.2 概念
https://nacos.io/
![image.png](./img/11/22915282922a46a6b04baedd5ee500f5.png)

一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。
一句话
**Nacos就是注册中心 + 配置中心的组合**

等价于
Nacos = Eureka+Config +Bus
Nacos = Spring Cloud Consul

#### 11.2.3 作用
替代Eureka/Consul做服务注册中心
替代(Config+Bus)/Consul 做服务配置中心和满足动态刷新广播通知

#### 11.2.4 下载
https://nacos.io/

![image.png](./img/11/d2a57709f0094a3bbd61609acdde7ed3.png)

#### 11.2.5 各种注册中心比较
注：CAP原则又称CAP定理，指的是在一个分布式系统中， Consistency（一致性）、 Availability（可用性）、Partition tolerance（分区容错性），三者不可得兼。
![image.png](./img/11/21b407c6280844f0b1e83575159b5343.png)

据说 Nacos 在阿里巴巴内部有超过 10 万的实例运行，已经过了类似双十一等各种大型流量的考验，Nacos默认是AP模式，
但也可以调整切换为CP，我们一般用默认AP即可。

### 11.3 Nacos下载安装
#### 11.3.1 本地Java17+Maven环境已经OK
注意Nacos版本
注意Nacos版本
注意Nacos版本

#### 11.3.2 先从官网下载Nacos
https://nacos.io/
![image.png](./img/11/75be2159ab0e4fe494afe00ce42e5f89.png)

[Nacos 快速开始](https://nacos.io/zh-cn/docs/v2/quickstart/quick-start.html)

![image.png](./img/11/777e11f47c6d40bf84567868087b6c94.png)

https://github.com/alibaba/nacos/releases

![image.png](./img/11/6bdaf6f18bd24f789acc601566df5ea8.png)


#### 11.3.3 解压安装包，直接运行bin目录下的startup.cmd
![image.png](./img/11/4c3857eebb3040ccb9c761c3e0af36ad.png)

startup.cmd -m standalone

#### 11.3.4 命令运行成功后直接访问
http://localhost:8848/nacos
默认账号密码都是nacos

#### 11.3.5 结果页面
![image.png](./img/11/29727a3e8fd8474a8803e2e273282fe0.png)

#### 11.3.6 关闭服务器
shutdown.cmd

### 11.4 Nacos Discovery服务注册中心
#### 11.4.1 概述
[Nacos 融合 Spring Cloud，成为注册配置中心](https://nacos.io/zh-cn/docs/v2/ecology/use-nacos-with-spring-cloud.html)


#### 11.4.2 SpringCloud Alibaba参考中文文档
[Spring Cloud Alibaba 参考文档](https://spring-cloud-alibaba-group.github.io/github-pages/2022/zh-cn/2022.0.0.0-RC2.html)

#### 11.4.3 基于Nacos的服务提供者
##### 11.4.3.1 新建Module
cloudalibaba-provider-payment9001

##### 11.4.3.2 POM
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
 
    <artifactId>cloudalibaba-provider-payment9001</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
 
    <dependencies>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
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
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
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

##### 11.4.3.3 YML
```yml
server:
   port:  9001

spring:
   application:
     name: nacos-payment-provider
   cloud:
     nacos:
       discovery:
         server-addr: localhost:8848  # 配置 Nacos 地址
```
![image.png](./img/11/26bfe51070a54ac9b42f3f0bc2f2fc12.png)

##### 11.4.3.4 主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
@SpringBootApplication
@EnableDiscoveryClient
public class Main9001 {
    public static void main(String[] args){
        SpringApplication.run(Main9001.class,args);
    }
}
```

##### 11.4.3.5 业务类
```java
package com.atguigu.cloud.controller;
 
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class PayAlibabaController{
    @Value("${server.port}")
    private String serverPort;
 
    @GetMapping(value = "/pay/nacos/{id}")
    public String getPayInfo(@PathVariable("id") Integer id) {
        return "nacos registry, serverPort: "+ serverPort+"\t id"+id;
    }
}
```

##### 11.4.3.6 测试
http://localhost:9001/pay/nacos/11

nacos控制台
![image.png](./img/11/bc31b90f7d114447a413a4db5b007989.png)

http://localhost:8848/nacos
nacos8848注册中心+服务提供者pay9001都OK了

#### 11.4.4 基于Nacos的服务消费者
##### 11.4.4.1 新建Module
cloudalibaba-consumer-nacos-order83

##### 11.4.4.2 POM
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
 
    <artifactId>cloudalibaba-consumer-nacos-order83</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!--loadbalancer-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-loadbalancer</artifactId>
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

##### 11.4.4.3 YML
![image.png](./img/11/f23e3950cf8f4b7981f2c9782153e37f.png)
```yml
server:
   port:  83

spring:
   application:
     name: nacos-order-consumer
   cloud:
     nacos:
       discovery:
         server-addr: localhost:8848
# 消费者将要去访问的微服务名称 (nacos 微服务提供者叫什么你写什么 )
service-url:
  nacos-user-service: http://nacos-payment-provider
```

##### 11.4.4.4 主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
@EnableDiscoveryClient
@SpringBootApplication
public class Main83 {
    public static void main(String[] args) {
        SpringApplication.run(Main83.class,args);
    }
}
```

##### 11.4.4.5 业务类
配置config
```java
package com.atguigu.cloud.config;
 
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
 
@Configuration
public class RestTemplateConfig{
    @Bean
    @LoadBalanced //赋予RestTemplate负载均衡的能力
    public RestTemplate restTemplate(){
        return new RestTemplate();
    }
}
```

OrderNacosController
```java
package com.atguigu.cloud.controller;
 
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
 
@RestController
public class OrderNacosController{
    @Resource
    private RestTemplate restTemplate;
 
    @Value("${service-url.nacos-user-service}")
    private String serverURL;
 
    @GetMapping("/consumer/pay/nacos/{id}")
    public String paymentInfo(@PathVariable("id") Integer id) {
        String result = restTemplate.getForObject(serverURL + "/pay/nacos/" + id, String.class);
        return result+"\t"+"    我是OrderNacosController83调用者。。。。。。";
    }
}
```

##### 11.4.4.6 测试
nacos控制台
![image.png](./img/11/75f036d8540b4e888a0c44739564d49b.png)
http://localhost:83/consumer/pay/nacos/14

#### 11.4.5 负载均衡
参照9001新建9002
要么老实新建，cloudalibaba-provider-payment9002；要么取巧不想新建重复体力劳动，直接拷贝虚拟端口映射

步骤：
1
![image.png](./img/11/d2f99c0ae84648c2aeccfee69e9afc9e.png)

2
![image.png](./img/11/238003fedf964a8786827b79ecb7e005.png)
-DServer.port=9002

3
![image.png](./img/11/9af7b8994a04404eb361e695a720dd1f.png)
![image.png](./img/11/6fb37b60b9894f5c9d34474295ff4a2f.png)

测试
http://localhost:83/consumer/pay/nacos/14

看到端口号9001/9002交替出现，负载均衡达到

### 11.5 Nacos Config服务配置中心
#### 11.5.1 概述
之前案例Consul8500服务配置动态变更功能可以被Nacos取代
通过Nacos和spring-cloud-starter-alibaba-nacos-config实现中心化全局配置的动态变更

#### 11.5.2 官网文档
[Nacos 融合 Spring Cloud，成为注册配置中心](https://nacos.io/zh-cn/docs/v2/ecology/use-nacos-with-spring-cloud.html)
![image.png](./img/11/be65fcf6189c43bc9a1963411bb4d772.png)

SpringCloud Alibaba参考中文文档
[Spring Cloud Alibaba 参考文档](https://spring-cloud-alibaba-group.github.io/github-pages/2022/zh-cn/2022.0.0.0-RC2.html#_spring_cloud_alibaba_nacos_config)

#### 11.5.3 Nacos作为配置中心配置步骤
##### 11.5.3.1 建Module
cloudalibaba-config-nacos-client3377

##### 11.5.3.2 POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>mscloudV3</artifactId>
        <groupId>com.atguigu.cloud</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
 
    <artifactId>cloudalibaba-config-nacos-client3377</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
 
 
    <dependencies>
        <!--bootstrap-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-bootstrap</artifactId>
        </dependency>
        <!--nacos-config-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
        </dependency>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
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

##### 11.5.3.3 YML
why配置两个
Nacos同Consul一样，在项目初始化时，要保证先从配置中心进行配置拉取，
拉取配置之后，才能保证项目的正常启动，为了满足动态刷新和全局广播通知

springboot中配置文件的加载是存在优先级顺序的，bootstrap优先级高于application

YML2024
bootstrap.yml
![image.png](./img/11/34b26b96e9014477ae32a3d666c6519b.png)

```yml
# nacos 配置
spring:
   application:
     name: nacos-config-client
   cloud:
     nacos:
       discovery:
         server-addr: localhost:8848  # Nacos 服务注册 中心地址
       config:
         server-addr: localhost:8848  # Nacos 作为 配置中心 地址
         file-extension: yaml  # 指定 yaml 格式的配置

# nacos 端配置文件 DataId 的命名规则是：
# ${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
#  本案例的 DataID 是 :nacos-config-client-dev.yaml
```

application
```yml
server:
  port: 3377
 
spring:
  profiles:
    active: dev # 表示开发环境
       #active: prod # 表示生产环境
       #active: test # 表示测试环境
```

##### 11.5.3.4 主启动
```java
package com.atguigu.cloudalibaba;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
/**
 * @auther zzyy
 * @create 2023-05-20 15:59
 */
@EnableDiscoveryClient
@SpringBootApplication
public class NacosConfigClient3377{
    public static void main(String[] args){
        SpringApplication.run(NacosConfigClient3377.class,args);
    }
}
```

##### 11.5.3.5 业务类
NacosConfigClientController
```java
package com.atguigu.cloud.controller;
 
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@RefreshScope //在控制器类加入@RefreshScope注解使当前类下的配置支持Nacos的动态刷新功能。
public class NacosConfigClientController{
    @Value("${config.info}")
    private String configInfo;
 
    @GetMapping("/config/info")
    public String getConfigInfo() {
        return configInfo;
    }
}
```

@RefreshScope
![image.png](./img/11/56b919fde40743a1bf0e1f1d6ad52e6f.png)

##### 11.5.3.6 在Nacos中添加配置信息(重点)
Nacos中的匹配规则

设置DataId理论

Nacos中的dataid的组成格式及与SpringBoot配置文件中的匹配规则

官网
[Nacos 融合 Spring Cloud，成为注册配置中心](https://nacos.io/zh-cn/docs/v2/ecology/use-nacos-with-spring-cloud.html)
![image.png](./img/11/d0caf28a69814c118c0738e4ad841154.png)

配置DataId实操

公式：
${spring.application.name}-${spring.profiles.active}.${spring.cloud.nacos.config.file-extension}

prefix 默认为 spring.application.name 的值
spring.profile.active 即为当前环境对应的 profile，可以通过配置项 spring.profile.active 来配置。
file-exetension 为配置内容的数据格式，可以通过配置项 spring.cloud.nacos.config.file-extension 来配置

小总结说明
![image.png](./img/11/02070f6f281f43bd844be2f33e917b31.png)

案例步骤
查看YML
![image.png](./img/11/73b821eb56bc4e8a9e3a305279cd135d.png)

创建配置
![image.png](./img/11/1a44decc93b74d5ca037d11a54f087fa.png)

配置DataId和对应文件
Data ID：nacos-config-client-dev.yaml
三码合一
![image.png](./img/11/750bc50ba00a4aa4a567e6c5ccaf9667.png)

##### 11.5.3.7 测试
启动Nacos且在nacos后台管理-配置列表下已经存在对应的yaml配置文件
![image.png](./img/11/99605ce324da4d6da4e1783bfd119759.png)

运行cloud-config-nacos-client3377的主启动类
调用接口查看配置信息
http://localhost:3377/config/info

##### 11.5.3.8 自带动态刷新
修改下Nacos中的yaml配置文件，再次调用查看配置的接口，就会发现配置已经刷新

##### 11.5.3.9 历史配置
Nacos会记录配置文件的历史版本默认保留30天，此外还有一键回滚功能，回滚操作将会触发配置更新

回滚：
![image.png](./img/11/ff2c5411a4174b0b96c10859c9a261a8.png)

### 11.6 Nacos数据模型之Namespace-Group-DataId
#### 11.6.1 问题
多环境多项目管理

问题1：
实际开发中，通常一个系统会准备
dev开发环境
test测试环境
prod生产环境
如何保证指定环境启动时服务能正确读取到Nacos上相应环境的配置文件呢？

问题2：
一个大型分布式微服务系统会有很多微服务子项目，
每个微服务项目又都会有相应的开发环境、测试环境、预发环境、正式环境......
那怎么对这些微服务配置进行分组和命名空间管理呢？

#### 11.6.2 官网
[Nacos 架构](https://nacos.io/zh-cn/docs/architecture.html)

#### 11.6.3 Namespace+Group+DataId三者关系？为什么这么设计？
![image.png](./img/11/a2258fb5093e4e6299f76469f5069157.png)

三者说明
![image.png](./img/11/497d0564f12a4551be17898c199d390c.png)

<table>
  <tr>
    <td>1 是什么</td> 
    <td>类似Java里面的package名和类名，最外层的Namespace是可以用于区分部署环境的，Group和DataID逻辑上区分两个目标对象</td>
  </tr>
  <tr>
    <td>2 默认值</td> 
    <td>默认情况：Namespace=public，Group=DEFAULT_GROUP
Nacos默认的命名空间是public，Namespace主要用来实现隔离。比方说我们现在有三个环境：开发、测试、生产环境，我们就可以创建三个Namespace，不同的Namespace之间是隔离的。Group默认是DEFAULT_GROUP，Group可以把不同的微服务划分到同一个分组里面去</td>
  </tr>
  <tr>
    <td>Service就是微服务</td> 
    <td>一个Service可以包含一个或者多个Cluster（集群），Nacos默认Cluster是DEFAULT，Cluster是对指定微服务的一个虚拟划分。见下一节：服务领域模型-补充说明</td>
  </tr>
</table>

![image.png](./img/11/8be141477e15452eb5e72ba2b50821b0.png)

#### 11.6.4 Nacos的图形化管理界面
命名空间Namespace
![image.png](./img/11/3abe29f88ddf4e41a6bb149fe6cf20a7.png)

配置管理
![image.png](./img/11/93b8a5f459b64fbb85e37f848e7d4fbf.png)

#### 11.6.5 三种方案加载配置
##### 11.6.5.1 DataID方案
指定spring.profile.active和配置文件的DataID来使不同环境下读取不同的配置

①默认空间public+默认分组DEFAULT_GROUP + **新建DataID**

1 新建test配置DataID
![image.png](./img/11/a6bb14c27ff643b997b461555092a3eb.png)
nacos-config-client-test.yaml

2 nacos后台
![image.png](./img/11/c4a62b9d389c4a02bbe6c2cc7fff2d87.png)

修改YML
通过spring.profile.active属性就能进行多环境下配置文件的读取
![image.png](./img/11/6ced1f069ec049e5bdd06ef1ee498d26.png)

bootstrap.yml
```yml
# nacos配置 第一种:默认空间+默认分组+新建DataID
spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 #Nacos服务注册中心地址
      config:
        server-addr: localhost:8848 #Nacos作为配置中心地址
        file-extension: yaml #指定yaml格式的配置
 
# nacos端配置文件DataId的命名规则是：
# ${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
# 本案例的DataID是:nacos-config-client-dev.yaml
```

application.yml
```yml
server:
  port: 3377
 
spring:
  profiles:
    #active: dev # 表示开发环境
    active: test # 表示测试环境
    #active: prod # 表示生产环境
```

test 
测试
http://localhost:3377/config/info

配置是什么就加载什么
test

##### 11.6.5.2 Group方案
通过Group实现环境区分

②默认空间public+新建PROD_GROUP+新建DataID

1 新建prod配置DataID
![image.png](./img/11/f91981ed1528479e978cf5e22049f55b.png)
nacos-config-client-prod.yaml

2 新建Group
![image.png](./img/11/1e394f5293ff4c96ac705dd7f3a6df7d.png)
PROD_GROUP

3 nacos后台
![image.png](./img/11/d08eb6a6596142f2abb175ad4f147511.png)

修改YML
在config下增加一条group的配置即可。可配置为PROD_GROUP
bootstrap.yml
```yml
# nacos配置 第2种:默认空间+新建分组+新建DataID
spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 #Nacos服务注册中心地址
      config:
        server-addr: localhost:8848 #Nacos作为配置中心地址
        file-extension: yaml #指定yaml格式的配置
        group: PROD_GROUP
 
# nacos端配置文件DataId的命名规则是：
# ${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
# 本案例的DataID是:nacos-config-client-dev.yaml
```

application.yml
```yml
server:
  port: 3377
 
spring:
  profiles:
    #active: dev # 表示开发环境
    #active: test # 表示测试环境
    active: prod # 表示生产环境
```

prod 
测试
http://localhost:3377/config/info

配置是什么就加载什么
prod 
![image.png](./img/11/7cce331548514dd8923a39f8ca52ce8e.png)

##### 11.6.5.3 Namespace方案
通过Namespace实现命名空间环境区分

新建Namespace：Prod_Namespace
![image.png](./img/11/42be67c739934eccb2ad57161b239677.png)

新建Namespace但命名空间ID不填(系统自动生成)：Prod2_Namespace
![image.png](./img/11/0ccb932a7aaf41e2b7da31834c0782d9.png)
![image.png](./img/11/4ed475b8ebfd4bbd91aacc5f675194e5.png)

后台
![image.png](./img/11/a9c7afe012544e5e874a01044cd0d8c2.png)

③Prod_Namespace+PROD_GROUP+DataID(nacos-config-client-prod.yaml)

选定Prod_Namespace后新建
1
![image.png](./img/11/a95d89f35feb4b2a892bb6477d9c334d.png)

2
![image.png](./img/11/6f914f42170442bda02b5ead9a087a22.png)

命名空间
Prod_Namespace

Data ID
nacos-config-client-prod.yaml

GROUP
PROD_GROUP

效果
![image.png](./img/11/9efec6cb84a24ff9a9901218ae999b8d.png)

后台
![image.png](./img/11/3c138f7f4d1d437e8df90e9ddf7619f4.png)

修改YML
在config下增加一条 namespace: Prod_Namespace
bootstrap.yml
```yml
# nacos配置 第3种:新建空间+新建分组+新建DataID
spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 #Nacos服务注册中心地址
      config:
        server-addr: localhost:8848 #Nacos作为配置中心地址
        file-extension: yaml #指定yaml格式的配置
        group: PROD_GROUP
        namespace: Prod_Namespace
 
# nacos端配置文件DataId的命名规则是：
# ${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
# 本案例的DataID是:nacos-config-client-dev.yaml
```

application.yml
```yml
server:
  port: 3377
 
spring:
  profiles:
    #active: dev # 表示开发环境
    #active: test # 表示测试环境
    active: prod # 表示生产环境
```

prod 
测试
http://localhost:3377/config/info

配置是什么就加载什么
prod
![image.png](./img/11/e4880c33b3354f938aadadd30d566e5a.png)



## 12 SpringCloud Alibaba Sentinel实现熔断与限流
![image.png](./img/10/39c909e9ceb541b9b8a3fa53affda255.png)

### 12.1 Sentinel
#### 12.1.1 官网
https://sentinelguard.io/zh-cn/
![image.png](./img/12/e3a5793d1b0a400ebe3c4a4dfbebe5e2.png)

等价对标
Spring Cloud Circuit Breaker

#### 12.1.2 概念
![image.png](./img/12/62ad9e7484344c728253139e2f9b47e2.png)
[主页 · alibaba/Sentinel Wiki · GitHub](https://github.com/alibaba/Sentinel/wiki/%E4%B8%BB%E9%A1%B5)

#### 12.1.3 下载
[Releases · alibaba/Sentinel · GitHub](https://github.com/alibaba/Sentinel/releases)

#### 12.1.4 作用
Sentinel的特征

丰富的应用场景：Sentinel 承接了阿里巴巴近 10 年的双十一大促流量的核心场景，例如秒杀（即突发流量控制在系统容量可以承受的范围）、消息削峰填谷、集群流量控制、实时熔断下游不可用应用等。

完备的实时监控：Sentinel 同时提供实时的监控功能。您可以在控制台中看到接入应用的单台机器秒级数据，甚至 500 台以下规模的集群的汇总运行情况。

广泛的开源生态：Sentinel 提供开箱即用的与其它开源框架/库的整合模块，例如与 Spring Cloud、Apache Dubbo、gRPC、Quarkus 的整合。您只需要引入相应的依赖并进行简单的配置即可快速地接入 Sentinel。同时 Sentinel 提供 Java/Go/C++ 等多语言的原生实现。

完善的 SPI 扩展机制：Sentinel 提供简单易用、完善的 SPI 扩展接口。您可以通过实现扩展接口来快速地定制逻辑。例如定制规则管理、适配动态数据源等。

Sentinel的主要特性
![image.png](./img/12/eb1bf2eaec15449f8d40e9bfc86296fd.png)
从流量路由、流量控制、流量整形、熔断降级、系统自适应过载保护、热点流量防护等多个维度来帮助开发者保障微服务的稳定性

#### 12.1.5 使用(面试题)
##### 12.1.5.1 讲讲什么是缓存穿透？击穿？雪崩？如何解决？
[123_redis高级篇之缓存预热雪崩穿透击穿面试题简介_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV13R4y1v7sP/?p=password)

##### 12.1.5.2 服务雪崩
**服务雪崩**
多个微服务之间调用的时候，假设微服务A调用微服务B和微服务C，微服务B和微服务C又调用其它的微服务，这就是所谓的“扇出”。如果扇出的链路上某个微服务的调用响应时间过长或者不可用，对微服务A的调用就会占用越来越多的系统资源，进而引起系统崩溃，所谓的“雪崩效应”。对于高流量的应用来说，单一的后端依赖可能会导致所有服务器上的所有资源都在几秒钟内饱和。比失败更糟糕的是，这些应用程序还可能导致服务之间的延迟增加，备份队列，线程和其他系统资源紧张，导致整个系统发生更多的级联故障。这些都表示需要对故障和延迟进行隔离和管理，以便单个依赖关系的失败，不能取消整个应用程序或系统。

所以，通常当你发现一个模块下的某个实例失败后，这时候这个模块依然还会接收流量，然后这个有问题的模块还调用了其他的模块，这样就会发生级联故障，或者叫雪崩。**复杂分布式体系结构中的应用程序有数十个依赖关系，每个依赖关系在某些时候将不可避免地失败**。

![image.png](./img/12/68dab81279b248bbb2ad978cdc9f103d.png)

##### 12.1.5.3 服务降级
服务降级，说白了就是一种服务托底方案，如果服务无法完成正常的调用流程，就使用默认的托底方案来返回数据。
例如，在商品详情页一般都会展示商品的介绍信息，一旦商品详情页系统出现故障无法调用时，会直接获取缓存中的商品介绍信息返回给前端页面。

##### 12.1.5.4 服务熔断
在分布式与微服务系统中，如果下游服务因为访问压力过大导致响应很慢或者一直调用失败时，上游服务为了保证系统的整体可用性，会暂时断开与下游服务的调用连接。这种方式就是熔断。**类比保险丝达到最大服务访问后，直接拒绝访问，拉闸限电，然后调用服务降级的方法并返回友好提示**。

服务熔断一般情况下会有三种状态：闭合、开启和半熔断;

闭合状态(保险丝闭合通电OK)：服务一切正常，没有故障时，上游服务调用下游服务时，不会有任何限制。

开启状态(保险丝断开通电Error)：上游服务不再调用下游服务的接口，会直接返回上游服务中预定的方法。

半熔断状态：处于开启状态时，上游服务会根据一定的规则，尝试恢复对下游服务的调用。此时，上游服务会以有限的流量来调用下游服务，同时，会监控调用的成功率。如果成功率达到预期，则进入关闭状态。如果未达到预期，会重新进入开启状态。

##### 12.1.5.5 服务限流
服务限流就是限制进入系统的流量，以防止进入系统的流量过大而压垮系统。其主要的作用就是保护服务节点或者集群后面的数据节点，防止瞬时流量过大使服务和数据崩溃（如前端缓存大量实效），造成不可用；还可用于平滑请求，类似秒杀高并发等操作，严禁一窝蜂的过来拥挤，大家排队，一秒钟N个，有序进行。

限流算法有两种，一种就是简单的请求总量计数，一种就是时间窗口限流（一般为1s），如令牌桶算法和漏牌桶算法就是时间窗口的限流算法。

##### 12.1.5.6 服务隔离
有点类似于系统的垂直拆分，就按照一定的规则将系统划分成多个服务模块，并且每个服务模块之间是互相独立的，不会存在强依赖的关系。如果某个拆分后的服务发生故障后，能够将故障产生的影响限制在某个具体的服务内，不会向其他服务扩散，自然也就不会对整体服务产生致命的影响。

互联网行业常用的服务隔离方式有：线程池隔离和信号量隔离。

##### 12.1.5.7 服务超时
整个系统采用分布式和微服务架构后，系统被拆分成一个个小服务，就会存在服务与服务之间互相调用的现象，从而形成一个个调用链。

形成调用链关系的两个服务中，主动调用其他服务接口的服务处于调用链的上游，提供接口供其他服务调用的服务处于调用链的下游。服务超时就是在上游服务调用下游服务时，设置一个最大响应时间，如果超过这个最大响应时间下游服务还未返回结果，则断开上游服务与下游服务之间的请求连接，释放资源。


### 12.2 安装Sentinel
#### 12.2.1 sentinel组件由2部分构成
![image.png](./img/12/5c5727c993b640b3a88118f8d53e75cc.png)
[介绍 · alibaba/Sentinel Wiki · GitHub](https://github.com/alibaba/Sentinel/wiki/%E4%BB%8B%E7%BB%8D)

后台8719默认
前台8080开启

#### 12.2.2 安装步骤
下载
[Releases · alibaba/Sentinel · GitHub](https://github.com/alibaba/Sentinel/releases)

本次下载2023.11.27
![image.png](./img/12/af38be4c17404551b0c0c98385b4fbdd.png)

下载到本地sentinel-dashboard-1.8.6.jar

运行命令
前提
Java环境OK
8080端口不能被占用

命令
java -jar sentinel-dashboard-1.8.6.jar

访问sentinel管理界面
登录账号密码均为sentinel
http://localhost:8080

![image.png](./img/12/8e4f098ac19843b0bbb2d793d9c364a1.png)

### 12.3 微服务8401整合Sentinel入门案例
#### 12.3.1 启动Nacos8848成功
startup.cmd -m standalone
http://localhost:8848/nacos/#/login

#### 12.3.2 启动Sentinel8080成功
java -jar sentinel-dashboard-1.8.6.jar

#### 12.3.3 新建微服务8401
cloudalibaba-sentinel-service8401
将被哨兵纳入管控的8401微服务提供者
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
 
    <artifactId>cloudalibaba-sentinel-service8401</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--SpringCloud alibaba sentinel -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
        </dependency>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
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
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
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
  port: 8401
 
spring:
  application:
    name: cloudalibaba-sentinel-service
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848         #N acos服务注册中心地址
    sentinel:
      transport:
        dashboard: localhost:8080 # 配置Sentinel dashboard控制台服务地址
        port: 8719 # 默认8719端口，假如被占用会自动从8719开始依次+1扫描，直至找到未被占用的端口
```

主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
/**
 * @auther zzyy
 * @create 2023-11-27 18:17
 */
@EnableDiscoveryClient
@SpringBootApplication
public class Main8401{
    public static void main(String[] args){
        SpringApplication.run(Main8401.class,args);
    }
}
```

业务类FlowLimitController
```java
package com.atguigu.cloudalibaba.controller;
 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class FlowLimitController{
 
    @GetMapping("/testA")
    public String testA(){
        return "------testA";
    }
 
    @GetMapping("/testB")
    public String testB(){
        return "------testB";
    }
}
```
启动微服务8401并访问

#### 12.3.4 启动8401微服务后查看sentienl控制台
空空如也，啥都没有
![image.png](./img/12/7649ae5a28b3437fb61ff7f14d855c23.png)

Sentinel采用的懒加载说明

注意
想使用Sentinel对某个接口进行限流和降级等操作，一定要先访问下接口，使Sentinel检测出相应的接口

执行一次访问即可
http://localhost:8401/testA
http://localhost:8401/testB

效果
![image.png](./img/12/9884062a7b7a47a8bc858daec66348d4.png)

### 12.4 流控规则
#### 12.4.1 基本介绍
![image.png](./img/12/b8c8d9236cd54752ba85398d70c44419.png)

概述
Sentinel能够对流量进行控制，主要是监控应用的QPS流量或者并发线程数等指标，如果达到指定的阈值时，就会被流量进行控制，以避免服务被瞬时的高并发流量击垮，保证服务的高可靠性。参数见最下方：
![image.png](./img/12/1fc5df348d8144c6aeb77c20701e0334.png)

<table>
  <tr>
    <td>1资源名</td> 
    <td>资源的唯一名称，默认就是请求的接口路径，可以自行修改，但是要保证唯一。</td>
  </tr>
  <tr>
    <td>2针对来源</td> 
    <td>具体针对某个微服务进行限流，默认值为default，表示不区分来源，全部限流。</td>
  </tr>
  <tr>
    <td>3阈值类型</td> 
    <td>QPS表示通过QPS进行限流，并发线程数表示通过并发线程数限流。</td>
  </tr>
  <tr>
    <td>4单机阈值</td> 
    <td>与阈值类型组合使用。如果阈值类型选择的是QPS，表示当调用接口的QPS达到阈值时，进行限流操作。如果阈值类型选择的是并发线程数，则表示当调用接口的并发线程数达到阈值时，进行限流操作。</td>
  </tr>
  <tr>
    <td>5是否集群</td> 
    <td>选中则表示集群环境，不选中则表示非集群环境。</td>
  </tr>
</table>

#### 12.4.2 流控模式
![image.png](./img/12/3aeeb215916c44988c8866b44a323e37.png)

##### 12.4.2.1 直接
默认的流控模式，当接口达到限流条件时，直接开启限流功能。

配置及说明
>表示1秒钟内查询1次就是OK，若超过次数1，就直接-快速失败，报默认错误

![image.png](./img/12/a3683aa9693a4da093549c387ae5cdeb.png)

测试
快速点击访问http://localhost:8401/testA

结果
Blocked by Sentinel (flow limiting)

思考？？？
直接调用默认报错信息，技术方面OK
but,是否应该有我们自己的后续处理?
类似有个fallback的兜底方法？

##### 12.4.2.2 关联
概念
当关联的资源达到阈值时，就限流自己
当与A关联的资源B达到阀值后，就限流A自己

B惹事，A挂了
张3感冒，李4吃药

配置A
设置效果
当关联资源/testB的qps阀值超过1时，就限流/testA的Rest访问地址，当关联资源到阈值后限制配置好的资源名，B惹事，A挂了
![image.png](./img/12/556d7682f9f04745a5591e8489b2c9b9.png)

Jmeter模拟并发密集访问testB
[Apache JMeter - Download Apache JMeter](https://jmeter.apache.org/download_jmeter.cgi)
Apache JMeter 5.6.2 (Requires Java 8+)

访问testB成功
http://localhost:8401/testB

Run
![image.png](./img/12/801c2d11133c4a76aa6a336b50504282.png)
![image.png](./img/12/07c4ea7031a94fa5a965f5d9a2ca4d83.png)

大批量线程高并发访问B，导致A失效了

运行后发现testA挂了
点击访问http://localhost:8401/testA

结果：
Blocked by Sentinel (flow limiting)

##### 12.4.2.3 链路
来自不同链路的请求对同一个目标访问时，实施针对性的不同限流措施，比如C请求来访问就限流，D请求来访问就是OK

修改微服务cloudalibaba-sentinel-service8401
YML
```yaml
server:
  port: 8401
 
spring:
  application:
    name: cloudalibaba-sentinel-service
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848         #Nacos服务注册中心地址
    sentinel:
      transport:
        dashboard: localhost:8080 #配置Sentinel dashboard控制台服务地址
        port: 8719 #默认8719端口，假如被占用会自动从8719开始依次+1扫描,直至找到未被占用的端口
      web-context-unify: false # controller层的方法对service层调用不认为是同一个根链路
```

业务类
新建FlowLimitService
```java
package com.atguigu.cloudalibaba.service;
 
import com.alibaba.csp.sentinel.annotation.SentinelResource;
import org.springframework.stereotype.Service;
 
@Service
public class FlowLimitService{
    @SentinelResource(value = "common")
    public void common(){
        System.out.println("------FlowLimitService come in");
    }
}
```
@SentinelResource后面介绍

修改FlowLimitController
```java
package com.atguigu.cloudalibaba.controller;
 
import com.atguigu.cloudalibaba.service.FlowLimitService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class FlowLimitController{
 
    @GetMapping("/testA")
    public String testA(){
        return "------testA";
    }
 
    @GetMapping("/testB")
    public String testB(){
        return "------testB";
    }
 
    /**流控-链路演示demo
     * C和D两个请求都访问flowLimitService.common()方法，阈值到达后对C限流，对D不管
     */
    @Resource private FlowLimitService flowLimitService;
 
    @GetMapping("/testC")
    public String testC(){
        flowLimitService.common();
        return "------testC";
    }
    @GetMapping("/testD")
    public String testD(){
        flowLimitService.common();
        return "------testD";
    }
}
```

sentinel配置
>说明：C和D两个请求都访问 flowLimitService.common()方法，对C限流，对D不管

![image.png](./img/12/650da2fda7464134bddf946685ddbe31.png)

测试
http://localhost:8401/testC

C链路
![image.png](./img/12/8432fde23e0f4f0186b779592f47e90f.png)
超过一秒钟一次后，就发生限流
D链路OK

#### 12.4.3 流控效果
![image.png](./img/12/04db86a570f24d098238585f19b69e58.png)

##### 12.4.3.1 直接 →  快速失败(默认的流控处理)
直接失败，抛出异常
Blocked by Sentinel (flow limiting)

##### 12.4.3.2 预热WarmUp
限流 冷启动
[限流 冷启动 · alibaba/Sentinel Wiki · GitHub](https://github.com/alibaba/Sentinel/wiki/%E9%99%90%E6%B5%81---%E5%86%B7%E5%90%AF%E5%8A%A8)

说明
![image.png](./img/12/edcacc83e3d34893879edfe5b2464b8a.png)

说明
公式：阈值除以冷却因子coldFactor(默认值为3),经过预热时长后才会达到阈值

官网
https://github.com/alibaba/Sentinel/wiki/%E6%B5%81%E9%87%8F%E6%8E%A7%E5%88%B6

![image.png](./img/12/e24393016f59409ca8d89f28551345d1.png)

源码
com.alibaba.csp.sentinel.slots.block.flow.controller.WarmUpController
![image.png](./img/12/9dda30717fe44da1a470967f92d098a4.png)
![image.png](./img/12/78982a2ee6004278bf348a5fb1d49040.png)

WarmUp配置
>**默认 coldFactor 为 3，即请求QPS从(threshold / 3) 开始，经多少预热时长才逐渐升至设定的 QPS 阈值。**
案例，单机阈值为10，预热时长设置5秒。
系统初始化的阈值为10 / 3 约等于3,即单机阈值刚开始为3(我们人工设定单机阈值是10，sentinel计算后QPS判定为3开始)；
然后过了5秒后阀值才慢慢升高恢复到设置的单机阈值10，也就是说5秒钟内QPS为3，过了保护期5秒后QPS为10

![image.png](./img/12/9e34269edfde4272a893277ea7a3a074.png)

多次点击http://localhost:8401/testB
刚开始不行，后续慢慢OK

应用场景
如：秒杀系统在开启的瞬间，会有很多流量上来，很有可能把系统打死，预热方式就是把为了保护系统，可慢慢的把流量放进来，慢慢的把阈值增长到设置的阈值。

##### 12.4.3.3 排队等待
![image.png](./img/12/2a4657d5f26140699dc665011b20e31b.png)

修改FlowLimitController
```java
/**
 * 流控效果----排队等待
 * @return
 */
@GetMapping("/testE")
public String testE(){
    System.out.println(System.currentTimeMillis()+"      testE,流控效果----排队等待");
    return "------testE";
}
```
http://localhost:8401/testE

sentinel配置
![image.png](./img/12/49d0a6e509f4490aa4d9b3100bd59b97.png)

>按照单机阈值，一秒钟通过一个请求，10秒后的请求作为超时处理，放弃

![image.png](./img/12/6812f1141f5d4993a0457e17394a9907.png)
![image.png](./img/12/72c78cc0e4644d048d7039fb3f5d4b17.png)


#### 12.4.4 流控效果V2(并发线程数)
sentinel配置
![image.png](./img/12/0a0f41d1ef16431bbbdb5890fe2985b7.png)

Jmeter模拟多个线程并发+循环请求
![image.png](./img/12/c2df595caaf646cf850cd289a9293f71.png)

http://localhost:8401/testB
Jmeter给它打满了，大部分我们自己访问都不好使，偶尔Jmeter线程切换系统判定没访问，我们自己的点击才有点机会


### 12.5 熔断规则
#### 12.5.1 官网
https://github.com/alibaba/Sentinel/wiki/%E7%86%94%E6%96%AD%E9%99%8D%E7%BA%A7

#### 12.5.2 基本介绍
Sentinel 熔断降级会在调用链路中某个资源出现不稳定状态时（例如调用超时或异常比例升高），对这个资源的调用进行限制，
让请求快速失败，避免影响到其它的资源而导致级联错误。当资源被降级后，在接下来的降级时间窗口之内，对该资源的调用都自动熔断（默认行为是抛出 DegradeException）。
![image.png](./img/12/190297eb8a49407bb482c5684ae1a61b.png)

官网说明 
Sentinel主要提供了三个熔断策略
![image.png](./img/12/ee87a24b5dd647679bfb9a401f30a93c.png)

Sentinel 提供以下几种熔断策略：
- 慢调用比例 (SLOW_REQUEST_RATIO)：选择以慢调用比例作为阈值，需要设置允许的慢调用 RT（即最大的响应时间），请求的响应时间大于该值则统计为慢调用。当单位统计时长（statIntervalMs）内请求数目大于设置的最小请求数目，并且慢调用的比例大于阈值，则接下来的熔断时长内请求会自动被熔断。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN 状态），若接下来的一个请求响应时间小于设置的慢调用 RT 则结束熔断，若大于设置的慢调用 RT 则会再次被熔断。
- 异常比例 (ERROR_RATIO)：当单位统计时长（statIntervalMs）内请求数目大于设置的最小请求数目，并且异常的比例大于阈值，则接下来的熔断时长内请求会自动被熔断。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN 状态），若接下来的一个请求成功完成（没有错误）则结束熔断，否则会再次被熔断。异常比率的阈值范围是 [0.0, 1.0]，代表 0% - 100%。
- 异常数 (ERROR_COUNT)：当单位统计时长内的异常数目超过阈值之后会自动进行熔断。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN 状态），若接下来的一个请求成功完成（没有错误）则结束熔断，否则会再次被熔断。

#### 12.5.3 新增熔断规则实战
##### 12.5.3.1 慢调用比例​
![image.png](./img/12/763340f7e1914ef38cbbf5f6626a9fb2.png)
慢调用比例 (SLOW_REQUEST_RATIO)：选择以慢调用比例作为阈值，需要设置允许的慢调用 RT（即最大的响应时间），请求的响应时间大于该值则统计为慢调用。当单位统计时长（statIntervalMs）内请求数目大于设置的最小请求数目，并且慢调用的比例大于阈值，则接下来的熔断时长内请求会自动被熔断。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN 状态），若接下来的一个请求响应时间小于设置的慢调用 RT 则结束熔断，若大于设置的慢调用 RT 则会再次被熔断。

![image.png](./img/12/390e0e2d57fa496c846a2f69ce24019a.png)
![image.png](./img/12/5ff3572b8e6a47309eb7246943c6314a.png)

名词解释
进入熔断状态判断依据：在统计时长内，实际请求数目＞设定的最小请求数 且 实际慢调用比例＞比例阈值 ，进入熔断状态。
![image.png](./img/12/390e0e2d57fa496c846a2f69ce24019a.png)

1.调用：一个请求发送到服务器，服务器给与响应，一个响应就是一个调用。
2.最大RT：即最大的响应时间，指系统对请求作出响应的业务处理时间。
3.慢调用：处理业务逻辑的实际时间>设置的最大RT时间，这个调用叫做慢调用。
4.慢调用比例：在所以调用中，慢调用占有实际的比例＝慢调用次数➗总调用次数
5.比例阈值：自己设定的 ， 比例阈值＝慢调用次数➗调用次数
6.统计时长：时间的判断依据
7.最小请求数：设置的调用最小请求数，上图比如1秒钟打进来10个线程（大于我们配置的5个了）调用被触发

触发条件+熔断状态
进入熔断状态判断依据：在统计时长内，实际请求数目＞设定的最小请求数    且      实际慢调用比例＞比例阈值 ，进入熔断状态。
![image.png](./img/12/390e0e2d57fa496c846a2f69ce24019a.png)

1.熔断状态(保险丝跳闸断电，不可访问)：在接下来的熔断时长内请求会自动被熔断
2.探测恢复状态(探路先锋)：熔断时长结束后进入探测恢复状态
3.结束熔断(保险丝闭合恢复，可以访问)：在探测恢复状态，如果接下来的一个请求响应时间小于设置的慢调用 RT，则结束熔断，否则继续熔断。

测试
代码
```java
/**
 * 新增熔断规则-慢调用比例
 * @return
 */
@GetMapping("/testF")
public String testF(){
    //暂停几秒钟线程
    try { TimeUnit.SECONDS.sleep(1); } catch (InterruptedException e) { e.printStackTrace(); }
    System.out.println("----测试:新增熔断规则-慢调用比例 ");
    return "------testF 新增熔断规则-慢调用比例";
}
```
>10个线程，在一秒的时间内发送完。又因为服务器响应时长设置：暂停1秒，所以响应一个请求的时长都大于1秒综上符合熔断条件，所以当线程开启1秒后，进入熔断状态

配置
进入熔断状态判断依据：在统计时长内，实际请求数目＞设定的最小请求数 且 实际慢调用比例＞比例阈值 ，进入熔断状态。 
![image.png](./img/12/45abbfdf24254411984004f1ef9f4957.png)

jmeter压测
![image.png](./img/12/7be2962ba7d84c379cad3504d43771de.png)

结论
![image.png](./img/12/5fcd4270e273433f908d24510a21223f.png)

按照上述配置，熔断触发：

多次循环，一秒钟打进来10个线程(大于5个了)调用/testF，我们希望200毫秒处理完一次调用，和谐系统

**假如在统计时长内，实际请求数目＞最小请求数且慢调用比例＞比例阈值 ，断路器打开(保险丝跳闸)微服务不可用(Blocked by Sentinel (flow limiting))，进入熔断状态5秒**；后续我停止jmeter，没有这么大的访问量了，单独用浏览器访问rest地址，断路器关闭(保险丝恢复，合上闸口)，

微服务恢复OK

##### 12.5.3.2 异常比例
异常比例 (ERROR_RATIO)：当单位统计时长（statIntervalMs）内请求数目大于设置的最小请求数目，并且异常的比例大于阈值，则接下来的熔断时长内请求会自动被熔断。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN 状态），若接下来的一个请求成功完成（没有错误）则结束熔断，否则会再次被熔断。异常比率的阈值范围是 [0.0, 1.0]，代表 0% - 100%。
![image.png](./img/12/a4dd8f80be624cba8cbd26af0b1bd247.png)
![image.png](./img/12/46f13d7fe3a34555b07fe8dea7d82512.png)
Blocked by Sentinel (flow limiting)

测试
代码
```java
/**
 * 新增熔断规则-异常比例
 * @return
 */
@GetMapping("/testG")
public String testG(){
    System.out.println("----测试:新增熔断规则-异常比例 ");
    int age = 10/0;
    return "------testG,新增熔断规则-异常比例 ";
}
```

配置
不配置Sentinel，对于int age=10/0，调一次错一次报错error，页面报【Whitelabel Error Page】或全局异常
配置Sentinel，对于int age=10/0，如符合如下异常比例启动熔断，页面报【Blocked by Sentinel (flow limiting)】
![image.png](./img/12/d92f0b9aaf4345b4b3317a5d18fb3235.png)

jmeter
![image.png](./img/12/942737c3f49446908564758bdad34480.png)

结论
按照上述配置，单独访问一次，必然来一次报错一次(int age  = 10/0)达到100%，调一次错一次报错error；
![image.png](./img/12/1e8ee29f954d45b7a68584086789316c.png)

开启jmeter后，直接高并发发送请求，多次调用达到我们的配置条件了。
![image.png](./img/12/8905acb3cae74c269cbc0205b08deeaa.png)

**断路器开启(保险丝跳闸)**，微服务不可用了，不再报错error而是服务熔断+服务降级，出提示
Blocked by Sentinel (flow limiting)。
![image.png](./img/12/dd1b930d6d3c40c5ba66a055183a87ad.png)

##### 12.5.3.3 异常数
异常数 (ERROR_COUNT)：当单位统计时长内的异常数目超过阈值之后会自动进行熔断。经过熔断时长后熔断器会进入探测恢复状态（HALF-OPEN 状态），若接下来的一个请求成功完成（没有错误）则结束熔断，否则会再次被熔断。
![image.png](./img/12/f4de54affec4478ab01b9180dfa3ad8f.png)
![image.png](./img/12/a525961541284622b4d5b9e06af9a90f.png)

测试
代码
```java
/**
 * 新增熔断规则-异常数
 * @return
 */
@GetMapping("/testH")
public String testH(){
    System.out.println("----测试:新增熔断规则-异常数 ");
    int age = 10/0;
    return "------testH,新增熔断规则-异常数 ";
}
```

配置
![image.png](./img/12/e5d5b03b9d6c45eca70615beb02db207.png)

jmeter
![image.png](./img/12/368b6418fdba45e8913bfa2597aea12e.png)

结论
http://localhost:8401/testH，
第一次访问绝对报错，因为除数不能为零，我们看到error窗口；
![image.png](./img/12/f5a53ea160204fb6a4c16af9dde10e58.png)

开启jmeter后，直接高并发干爆他发送请求，多次调用达到我们的配置条件了。
![image.png](./img/12/30bf2c8bca6e4cb893bf03a2db8899d7.png)

但是jmeter开工，上述配置表示，**在1秒钟内最少请求2次，当异常数大于1时，会触发熔断操作断路器开启(保险丝跳闸)，微服务不可用了，熔断的时长为5秒**，不再报错error而是服务降级了出提示Blocked by Sentinel (flow limiting) 
![image.png](./img/12/82af80add30e4cafbe812079a958ddf6.png)


### 12.6 @SentinelResource注解
#### 12.6.1 概念
SentinelResource是一个流量防卫防护组件 **注解**，用于指定防护资源，对配置的资源进行流量控制、熔断降级等功能。

@SentinelResource 注解说明
```java
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface SentinelResource {
 
    //资源名称
    String value() default "";
 
    //entry类型，标记流量的方向，取值IN/OUT，默认是OUT
    EntryType entryType() default EntryType.OUT;
    //资源分类
    int resourceType() default 0;
 
    //处理BlockException的函数名称,函数要求：
    //1. 必须是 public
    //2.返回类型 参数与原方法一致
    //3. 默认需和原方法在同一个类中。若希望使用其他类的函数，可配置blockHandlerClass ，并指定blockHandlerClass里面的方法。
    String blockHandler() default "";
 
    //存放blockHandler的类,对应的处理函数必须static修饰。
    Class<?>[] blockHandlerClass() default {};
 
    //用于在抛出异常的时候提供fallback处理逻辑。 fallback函数可以针对所
    //有类型的异常（除了 exceptionsToIgnore 里面排除掉的异常类型）进行处理。函数要求：
    //1. 返回类型与原方法一致
    //2. 参数类型需要和原方法相匹配
    //3. 默认需和原方法在同一个类中。若希望使用其他类的函数，可配置fallbackClass ，并指定fallbackClass里面的方法。
    String fallback() default "";
 
    //存放fallback的类。对应的处理函数必须static修饰。
    String defaultFallback() default "";
 
    //用于通用的 fallback 逻辑。默认fallback函数可以针对所有类型的异常进
    //行处理。若同时配置了 fallback 和 defaultFallback，以fallback为准。函数要求：
    //1. 返回类型与原方法一致
    //2. 方法参数列表为空，或者有一个 Throwable 类型的参数。
    //3. 默认需要和原方法在同一个类中。若希望使用其他类的函数，可配置fallbackClass ，并指定 fallbackClass 里面的方法。
    Class<?>[] fallbackClass() default {};
 
 
    //需要trace的异常
    Class<? extends Throwable>[] exceptionsToTrace() default {Throwable.class};
 
    //指定排除忽略掉哪些异常。排除的异常不会计入异常统计，也不会进入fallback逻辑，而是原样抛出。
    Class<? extends Throwable>[] exceptionsToIgnore() default {};
}
```

#### 12.6.2 启动Nacos成功
startup.cmd -m standalone

#### 12.6.3 启动Sentinel成功
java -jar sentinel-dashboard-1.8.6.jar

#### 12.6.4 ①按照rest地址限流+默认限流返回
通过访问的rest地址来限流，会返回Sentinel自带默认的限流处理信息

业务类RateLimitController
```java
package com.atguigu.cloudalibaba.controller;
 
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@Slf4j
public class RateLimitController{
    @GetMapping("/rateLimit/byUrl")
    public String byUrl(){
        return "按rest地址限流测试OK";
    }
}
```

访问一次
http://localhost:8401/rateLimit/byUrl

Sentinel控制台配置
![image.png](./img/12/9b49428aab824e5bab61df45000f7998.png)
![image.png](./img/12/4012b03864b54994b1bb4d6fde17c843.png)

测试
疯狂点击http://localhost:8401/rateLimit/byUrl

结果
会返回Sentinel自带的限流处理结果，默认 
会返回Sentinel自带的限流处理结果，默认
会返回Sentinel自带的限流处理结果，默认
![image.png](./img/12/156cecf80d3c48a4bc87fc18c5c86473.png)

#### 12.6.5 ②按SentinelResource​资源名称限流+自定义限流返回
不想用默认的限流提示(Blocked by Sentinel (flow limiting))，<font color="red">想返回自定义限流的提示</font>
微服务cloudalibaba-sentinel-service8401

业务类RateLimitController
```java
package com.atguigu.cloudalibaba.controller;
 
import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@Slf4j
public class RateLimitController{
    @GetMapping("/rateLimit/byUrl")
    public String byUrl(){
        return "按rest地址限流测试OK";
    }
 
    @GetMapping("/rateLimit/byResource")
    @SentinelResource(value = "byResourceSentinelResource",blockHandler = "handleException")
    public String byResource(){
        return "按资源名称SentinelResource限流测试OK";
    }
    public String handleException(BlockException exception){
        return "服务不可用@SentinelResource启动";
    }
}
```

测试地址
http://localhost:8401/rateLimit/byResource

配置流量规则
配置步骤
![image.png](./img/12/ce683322a2d44befa748b00a6b13413a.png)

图形配置和代码关系
![image.png](./img/12/2c72c4115837468ba799f41bcbc8feda.png)

测试
1秒钟点击1下，OK
超过上述，疯狂点击，返回了**自定义的限流处理信息**，限流发生

sentinel默认
![image.png](./img/12/c8bd8bdf492543dfb8ff9edcf97a29f0.png)

自定义限流提示
![image.png](./img/12/f414c991efc24dafb4c3b7d4ef2115fc.png)

#### 12.6.6 ③按SentinelResource​资源名称限流+自定义限流返回+服务降级处理
按SentinelResource配置，点击超过限流配置返回自定义限流提示+ <font color="red">程序异常返回fallback服务降级</font>

微服务cloudalibaba-sentinel-service8401

业务类RateLimitController
```java
package com.atguigu.cloudalibaba.controller;
 
import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@Slf4j
public class RateLimitController{
    @GetMapping("/rateLimit/byUrl")
    public String byUrl(){
        return "按rest地址限流测试OK";
    }
 
    @GetMapping("/rateLimit/byResource")
    @SentinelResource(value = "byResourceSentinelResource",blockHandler = "handleException")
    public String byResource(){
        return "按资源名称SentinelResource限流测试OK";
    }
    public String handleException(BlockException exception){
        return "服务不可用@SentinelResource启动"+"\t"+"o(╥﹏╥)o";
    }
 
    @GetMapping("/rateLimit/doAction/{p1}")
    @SentinelResource(value = "doActionSentinelResource",
            blockHandler = "doActionBlockHandler", fallback = "doActionFallback")
    public String doAction(@PathVariable("p1") Integer p1) {
        if (p1 == 0){
            throw new RuntimeException("p1等于零直接异常");
        }
        return "doAction";
    }
 
    public String doActionBlockHandler(@PathVariable("p1") Integer p1,BlockException e){
        log.error("sentinel配置自定义限流了:{}", e);
        return "sentinel配置自定义限流了";
    }
 
    public String doActionFallback(@PathVariable("p1") Integer p1,Throwable e){
        log.error("程序逻辑异常了:{}", e);
        return "程序逻辑异常了"+"\t"+e.getMessage();
    }
 
}
```
http://localhost:8401/rateLimit/doAction/2

配置流控规则
图形配置和代码关系
![image.png](./img/12/eaa4c984e32d48baaccd1075bc1fa52a.png)

表示1秒钟内查询次数大于1，就跑到我们自定义的处流，限流

测试
http://localhost:8401/rateLimit/doAction/2

1秒钟点击1下，OK
超过上述，疯狂点击，返回了自己定义的限流处理信息，限流发生，配合了sentinel设定的规则

http://localhost:8401/rateLimit/doAction/0
p1参数为零，异常发生，返回了自己定义的服务降级处理

小结
blockHandler，主要针对sentinel配置后出现的违规情况处理
fallback，程序异常了JVM抛出的异常服务降级
两者可以同时共存


### 12.7 热点规则
#### 12.7.1 基本介绍
何为热点

热点即经常访问的数据，很多时候我们希望统计或者限制某个热点数据中访问频次最高的TopN数据，并对其访问进行限流或者其它操作
![image.png](./img/12/e3f3eae2706c426fa4d36033db227f83.png)

#### 12.7.2 官网
[热点参数限流 · alibaba/Sentinel Wiki · GitHub](https://github.com/alibaba/Sentinel/wiki/%E7%83%AD%E7%82%B9%E5%8F%82%E6%95%B0%E9%99%90%E6%B5%81)

#### 12.7.3 代码
```java
@GetMapping("/testHotKey")
@SentinelResource(value = "testHotKey",blockHandler = "dealHandler_testHotKey")
public String testHotKey(@RequestParam(value = "p1",required = false) String p1, 
                         @RequestParam(value = "p2",required = false) String p2){
    return "------testHotKey";
}
public String dealHandler_testHotKey(String p1,String p2,BlockException exception){
    return "-----dealHandler_testHotKey";
}
```
sentinel系统默认的提示：Blocked by Sentinel (flow limiting) 

#### 12.7.4 配置
![image.png](./img/12/f2a75ee97c344e1cb4785cfab39bd0c9.png)

限流模式只支持QPS模式，固定写死了。（这才叫热点）

@SentinelResource注解的方法参数索引，0代表第一个参数，1代表第二个参数，以此类推

单机阀值以及统计窗口时长表示在此窗口时间超过阀值就限流。

**上面的抓图就是第一个参数有值的话，1秒的QPS为1，超过就限流，限流后调用**dealHandler_testHotKey支持方法。

方法testHotKey里面第一个参数P1只要QPS超过每秒1次，马上降级处理

http://localhost:8401/testHotKey

#### 12.7.5 测试
✖error
http://localhost:8401/testHotKey?p1=abc
含有参数P1，当每秒访问的频率超过1次时，会触发Sentinel的限流操作

✖error
http://localhost:8401/testHotKey?p1=abc&p2=33
含有参数P1，当每秒访问的频率超过1次时，会触发Sentinel的限流操作

✔right
http://localhost:8401/testHotKey?p2=abc
没有热点参数P1，不断访问则不会触发限流操作

#### 12.7.6 参数例外项
上述案例演示了第一个参数p1，当QPS超过1秒1次点击后马上被限流

特殊情况

普通正常限流
含有P1参数，超过1秒钟一个后，达到阈值1后马上被限流

配置
![image.png](./img/12/53bfe3cc0a1e4651ad14a1158c8e89f2.png)
添加按钮不能忘

测试
✔http://localhost:8401/testHotKey?p1=5

超过1秒钟一个后，达到阈值200后才会被限流
当p1等于5的时候，阈值变为200

✖http://localhost:8401/testHotKey?p1=3

超过1秒钟一个后，达到阈值后马上被限流
当p1不等于5的时候，阈值就是平常的【普通正常限流】规则

前提条件
热点参数的注意点，参数必须是基本类型或者String

### 12.8 授权规则
#### 12.8.1 授权规则概述
在某些场景下，需要根据调用接口的来源判断是否允许执行本次请求。此时就可以使用Sentinel提供的授权规则来实现，Sentinel的授权规则能够根据请求的来源判断是否允许本次请求通过。

在Sentinel的授权规则中，提供了 **白名单与黑名单 两种授权类型。白放行、黑禁止**

#### 12.8.2 官网
https://github.com/alibaba/Sentinel/wiki/%E9%BB%91%E7%99%BD%E5%90%8D%E5%8D%95%E6%8E%A7%E5%88%B6

#### 12.8.3 演示授权规则，黑名单禁止
代码
EmpowerController
```java
package com.atguigu.cloud.controller;
 
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@Slf4j
public class EmpowerController { //Empower授权规则，用来处理请求的来源
    @GetMapping(value = "/empower")
    public String requestSentinel4(){
        log.info("测试Sentinel授权规则empower");
        return "Sentinel授权规则";
    }
}
```

MyRequestOriginParser
```java
package com.atguigu.cloud.handler;
 
import com.alibaba.csp.sentinel.adapter.spring.webmvc.callback.RequestOriginParser;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;
 
@Component
public class MyRequestOriginParser implements RequestOriginParser {
    @Override
    public String parseOrigin(HttpServletRequest httpServletRequest) {
        return httpServletRequest.getParameter("serverName");
    }
}
```

启动8401后先访问成功
http://localhost:8401/empower

#### 12.8.4 配置
![image.png](./img/12/77534c4d8c2a4dea9bc4254389e5641e.png)

#### 12.8.5 测试
✖error
http://localhost:8401/empower?serverName=test
Blocked by Sentinel (flow limiting)

✖error
http://localhost:8401/empower?serverName=test2
Blocked by Sentinel (flow limiting)

说明
不断在浏览器中刷新http://localhost:8401/empower?serverName=test
不断在浏览器中刷新http://localhost:8401/empower?serverName=test2

上述2个rest地址，serverName=test或serverName=test2是处于黑名单的状态，无法访问，会发现无法访问，被Sentinel限流了

✔right
http://localhost:8401/empower?serverName=ab


### 12.9 规则持久化
#### 12.9.1 概念
一旦我们重启微服务应用，sentinel规则将消失，生产环境需要将配置规则进行持久化

#### 112.9.2 使用
将限流配置规则持久化进Nacos保存，只要刷新8401某个rest地址，sentinel控制台的流控规则就能看到，只要Nacos里面的配置不删除，针对8401上sentinel上的流控规则持续有效

#### 112.9.3 步骤
##### 112.9.3.1 修改cloudalibaba-sentinel-service8401
##### 112.9.3.2 POM
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
 
    <artifactId>cloudalibaba-sentinel-service8401</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!--SpringCloud ailibaba sentinel-datasource-nacos -->
        <dependency>
            <groupId>com.alibaba.csp</groupId>
            <artifactId>sentinel-datasource-nacos</artifactId>
        </dependency>
        <!--SpringCloud alibaba sentinel -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
        </dependency>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
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
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
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

#### 12.9.3.3 YML
```yml
server:
  port: 8401
 
spring:
  application:
    name: cloudalibaba-sentinel-service #8401微服务提供者后续将会被纳入阿里巴巴sentinel监管
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848         #Nacos服务注册中心地址
    sentinel:
      transport:
        dashboard: localhost:8080 # 配置Sentinel dashboard控制台服务地址
        port: 8719 # 默认8719端口，假如被占用会自动从8719开始依次+1扫描,直至找到未被占用的端口
      web-context-unify: false # controller层的方法对service层调用不认为是同一个根链路
      datasource:
        ds1:
          nacos:
            server-addr: localhost:8848
            dataId: ${spring.application.name}
            groupId: DEFAULT_GROUP
            data-type: json
            rule-type: flow # com.alibaba.cloud.sentinel.datasource.RuleType
```

添加Nacos数据源配置 
```yml
spring:
  cloud:
    sentinel:
      datasource:
        ds1: 
          nacos:
            server-addr: localhost:8848
            dataId: ${spring.application.name}
            groupId: DEFAULT_GROUP
            data-type: json
            rule-type: flow
```
备注：rule-type是什么？看看源码

源代码
![image.png](./img/12/e0d007e07ac2441695a3cb279debc332.png)

进一步说明
![image.png](./img/12/f147c76a5ada4c9f85abb5b5521305ab.png)

#### 12.9.3.4 添加Nacos业务规则配置
![image.png](./img/12/a485073384d54f40af7ddb5e4dedf955.png)

内容解析
```json
[
  {
    "resource": "/rateLimit/byUrl",
    "limitApp": "default",
    "grade": 1,
    "count": 1,
    "strategy": 0,
    "controlBehavior": 0,
    "clusterMode": false
  }
]
```
>resource：资源名称；
limitApp：来源应用；
grade：阈值类型，0表示线程数，1表示QPS；
count：单机阈值；
strategy：流控模式，0表示直接，1表示关联，2表示链路；
controlBehavior：流控效果，0表示快速失败，1表示Warm Up，2表示排队等待；
clusterMode：是否集群。

##### 12.9.3.5 快速访问测试接口
http://localhost:8401/rateLimit/byUrl
上面地址访问后等待3秒钟
启动8401后**刷新sentinel**发现业务规则有了
![image.png](./img/12/9587f9563a1d465891034994f7fafa6e.png)

默认
![image.png](./img/12/cfa42c18c1304c17915a25e805488914.png)

##### 12.9.3.6 停止8401再看sentinel
![image.png](./img/12/0dfbf0d8b37145299591629d1ee1bc02.png)

##### 12.9.3.7 重新启动8401再看sentinel
乍一看还是没有，稍等一会儿
多次调用
http://localhost:8401/rateLimit/byUrl
✔重新配置出现了，持久化验证通过


### 12.10 OpenFeign和Sentinel集成实现fallback服务降级
#### 12.10.1 需求说明
cloudalibaba-consumer-nacos-order83   通过OpenFeign调用    cloudalibaba-provider-payment9001

1 83   通过OpenFeign调用  9001微服务，正常访问OK

2 83   通过OpenFeign调用  9001微服务，异常访问error
  访问者要有fallback服务降级的情况，不要持续访问9001加大微服务负担，但是通过feign接口调用的各方法各自不同，
  如果每个不同方法都加一个fallback配对方法，会导致代码膨胀不好管理，工程埋雷....../(ㄒoㄒ)/~~

3  public @interface FeignClient
   通过fallback属性进行统一配置，feign接口里面定义的全部方法都走统一的服务降级，一个搞定即可。

4 9001微服务自身还带着sentinel内部配置的流控规则，如果满足也会被触发，也即本例有2个Case
  4.1 OpenFeign接口的统一fallback服务降级处理
  4.2 Sentinel访问触发了自定义的限流配置,在注解@SentinelResource里面配置的blockHandler方法。


#### 12.10.2 程序解耦
前述参考
![image.png](./img/12/4535c4fe054648599f57da676d1e0435.png)

本例说明
![image.png](./img/12/a59a117f890449c9beaea43543d2edc1.png)

#### 12.10.3 编码步骤
启动nacos服务器8848
startup.cmd -m standalone

启动Sentinel成功
java -jar sentinel-dashboard-1.8.6.jar

①修改服务提供方cloudalibaba-provider-payment9001
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
 
    <artifactId>cloudalibaba-provider-payment9001</artifactId>
 
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
        <!--alibaba-sentinel-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
        </dependency>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
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
        <!--hutool-->
        <dependency>
            <groupId>cn.hutool</groupId>
            <artifactId>hutool-all</artifactId>
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

写YML
```yml
server:
  port: 9001
 
spring:
  application:
    name: nacos-payment-provider
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 # 配置Nacos地址
    sentinel:
      transport:
        dashboard: localhost:8080 # 配置Sentinel dashboard控制台服务地址
        port: 8719 # 默认8719端口，假如被占用会自动从8719开始依次+1扫描,直至找到未被占用的端口
```

主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
@SpringBootApplication
@EnableDiscoveryClient
public class Main9001{
    public static void main(String[] args){
        SpringApplication.run(Main9001.class,args);
    }
}
```

业务类
Controller
```java
package com.atguigu.cloud.controller;
 
import cn.hutool.core.util.IdUtil;
import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import com.atguigu.cloud.entities.PayDTO;
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.resp.ReturnCodeEnum;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
 
import java.math.BigDecimal;
 
@RestController
public class PayAlibabaController{
    @Value("${server.port}")
    private String serverPort;
 
    @GetMapping(value = "/pay/nacos/{id}")
    public String getPayInfo(@PathVariable("id") Integer id){
        return "nacos registry, serverPort: "+ serverPort+"\t id"+id;
    }
 
    @GetMapping("/pay/nacos/get/{orderNo}")
    @SentinelResource(value = "getPayByOrderNo",blockHandler = "handlerBlockHandler")
    public ResultData getPayByOrderNo(@PathVariable("orderNo") String orderNo){
        //模拟从数据库查询出数据并赋值给DTO
        PayDTO payDTO = new PayDTO();
 
        payDTO.setId(1024);
        payDTO.setOrderNo(orderNo);
        payDTO.setAmount(BigDecimal.valueOf(9.9));
        payDTO.setPayNo("pay:"+IdUtil.fastUUID());
        payDTO.setUserId(1);
 
        return ResultData.success("查询返回值："+payDTO);
    }
    public ResultData handlerBlockHandler(@PathVariable("orderNo") String orderNo,BlockException exception){
        return ResultData.fail(ReturnCodeEnum.RC500.getCode(),"getPayByOrderNo服务不可用，" +
                "触发sentinel流控配置规则"+"\t"+"o(╥﹏╥)o");
    }
    /*
    fallback服务降级方法纳入到Feign接口统一处理，全局一个
    public ResultData myFallBack(@PathVariable("orderNo") String orderNo,Throwable throwable){
        return ResultData.fail(ReturnCodeEnum.RC500.getCode(),"异常情况："+throwable.getMessage());
    }
    */
}
```
启动9001微服务自测
http://localhost:9001/pay/nacos/get/ord1024

②修改cloud-api-commons
POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>cloud2024</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
 
    <artifactId>cloud-api-commons</artifactId>
 
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
        <!--alibaba-sentinel-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
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

新增PayFeignSentinelApi接口
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.resp.ResultData;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
 
@FeignClient(value = "nacos-payment-provider",fallback = PayFeignSentinelApiFallBack.class)
public interface PayFeignSentinelApi{
    @GetMapping("/pay/nacos/get/{orderNo}")
    public ResultData getPayByOrderNo(@PathVariable("orderNo") String orderNo);
}
```

为远程调用新建全局统一服务降级类 fallback =​PayFeignSentinelApiFallBack.class
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.resp.ReturnCodeEnum;
import org.springframework.stereotype.Component;
 
@Component
public class PayFeignSentinelApiFallBack implements PayFeignSentinelApi{
    @Override
    public ResultData getPayByOrderNo(String orderNo){
        return ResultData.fail(ReturnCodeEnum.RC500.getCode(),"对方服务宕机或不可用，FallBack服务降级o(╥﹏╥)o");
    }
}
```

gav坐标
```xml
<!-- 引入自己定义的api通用包 -->
<dependency>
    <groupId>com.atguigu.cloud</groupId>
    <artifactId>cloud-api-commons</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

③修改cloudalibaba-consumer-nacos-order83
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
 
    <artifactId>cloudalibaba-consumer-nacos-order83</artifactId>
 
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
        <!--openfeign-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <!--alibaba-sentinel-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-sentinel</artifactId>
        </dependency>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!--loadbalancer-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-loadbalancer</artifactId>
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
  port: 83
 
spring:
  application:
    name: nacos-order-consumer
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848
#消费者将要去访问的微服务名称(nacos微服务提供者叫什么你写什么)
service-url:
  nacos-user-service: http://nacos-payment-provider
 
# 激活Sentinel对Feign的支持
feign:
  sentinel:
    enabled: true
```

主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
 
@EnableDiscoveryClient
@SpringBootApplication
@EnableFeignClients //开启激活Feign功能
public class Main83{
    public static void main(String[] args){
        SpringApplication.run(Main83.class,args);
    }
}
```
添加@EnableFeignClients 启动Feign的功能

业务类
OrderNacosController
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.apis.PayFeignSentinelApi;
import com.atguigu.cloud.resp.ResultData;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
 
@RestController
public class OrderNacosController{
    @Resource
    private RestTemplate restTemplate;
    @Resource
    private PayFeignSentinelApi payFeignSentinelApi;
 
    @Value("${service-url.nacos-user-service}")
    private String serverURL;
 
    @GetMapping("/consumer/pay/nacos/{id}")
    public String paymentInfo(@PathVariable("id") Integer id){
        String result = restTemplate.getForObject(serverURL + "/pay/nacos/" + id, String.class);
        return result+"\t"+"    我是OrderNacosController83调用者。。。。。。";
    }
 
    @GetMapping(value = "/consumer/pay/nacos/get/{orderNo}")
    public ResultData getPayByOrderNo(@PathVariable("orderNo") String orderNo){
        return payFeignSentinelApi.getPayByOrderNo(orderNo);
    }
}
```

启动83微服务，第1次
故障现象
![image.png](./img/12/4570d36eb7344cb78006e60aca7bc773.png)

导致原因
springboot+springcloud版本太高导致和阿里巴巴Sentinel不兼容

解决方案
总体父工程，boot+cloud降低版本
```xml
<spring.boot.version>3.2.0 </spring.boot.version>
<spring.cloud.version>2023.0.0 </spring.cloud.version>
上面的配置暂时为本案例注释掉，版本降级一下。
讲解完后请恢复上述高版本保持前后配置一致， 请用下面的版本替代上述
<spring.boot.version>3.0.9</spring.boot.version>
<spring.cloud.version>2022.0.2</spring.cloud.version>
```
![image.png](./img/12/dd4fa99006b2482684a260525b4d69c6.png)

启动83微服务，第2次，成功

##### 12.10.4 测试验证
9001正常启动后，再启动83通过feign调用
测试地址
http://localhost:83/consumer/pay/nacos/get/1024

![image.png](./img/12/2406b82698524a1caf1d6eb9a4861be2.png)

sentinel流控为例，进行配置
![image.png](./img/12/c2626cfcf0b04bd7baeecd6a94aa883f.png)

http://localhost:83/consumer/pay/nacos/get/1024
频繁访问后触发了Sentinel的流控规则，blockHandler起效
![image.png](./img/12/843e10419d354237b32d6b7fc19bd9bb.png)

9001宕机了，83通过feign调用
测试83调用9001，此时故意关闭9001微服务提供者，看83消费侧自动降级，不会被耗死

降级效果
![image.png](./img/12/65d91b312e084712972cd33464552ee8.png)

最后一步
恢复父工程版本号，升
```xml
<spring.boot.version>3.2.0</spring.boot.version>
<spring.cloud.version>2023.0.0</spring.cloud.version>
```

### 12.11 GateWay和Sentinel集成实现服务限流
#### 12.11.1 需求说明
cloudalibaba-sentinel-gateway9528   保护   cloudalibaba-provider-payment9001

#### 12.11.2 启动nacos服务器8848
startup.cmd -m standalone

#### 12.11.3 启动sentienl服务器8080
#### 12.11.4 步骤
建Module
cloudalibaba-sentinel-gateway9528

改POM
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <groupId>com.atguigu.cloud</groupId>
        <artifactId>mscloudV3</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
 
    <artifactId>cloudalibaba-sentinel-gateway9528</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
 
 
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>
        <dependency>
            <groupId>com.alibaba.csp</groupId>
            <artifactId>sentinel-transport-simple-http</artifactId>
            <version>1.8.6</version>
        </dependency>
        <dependency>
            <groupId>com.alibaba.csp</groupId>
            <artifactId>sentinel-spring-cloud-gateway-adapter</artifactId>
            <version>1.8.6</version>
        </dependency>
        <dependency>
            <groupId>javax.annotation</groupId>
            <artifactId>javax.annotation-api</artifactId>
            <version>1.3.2</version>
            <scope>compile</scope>
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
  port: 9528
 
spring:
  application:
    name: cloudalibaba-sentinel-gateway     # sentinel+gataway整合Case
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848
    gateway:
      routes:
        - id: pay_routh1 # pay_routh1                # 路由的ID(类似mysql主键ID)，没有固定规则但要求唯一，建议配合服务名
          uri: http://localhost:9001                # 匹配后提供服务的路由地址
          predicates:
          - Path=/pay/**                      # 断言，路径相匹配的进行路由
```

主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
 
@SpringBootApplication
@EnableDiscoveryClient
public class Main9528{
    public static void main(String[] args){
        SpringApplication.run(Main9528.class,args);
    }
}
```

业务类
参考官网配置说明案例改写
![image.png](./img/12/4e360a5941f446519376cea6b527c3ab.png)
![image.png](./img/12/1cf3cfcc55ef4a649e02e66d74d53a6d.png)

[网关限流 · alibaba/Sentinel Wiki · GitHub](https://github.com/alibaba/Sentinel/wiki/%E7%BD%91%E5%85%B3%E9%99%90%E6%B5%81#spring-cloud-gateway)

配置config
```java
package com.atguigu.cloud.config;
 
import com.alibaba.csp.sentinel.adapter.gateway.common.rule.GatewayFlowRule;
import com.alibaba.csp.sentinel.adapter.gateway.common.rule.GatewayRuleManager;
import com.alibaba.csp.sentinel.adapter.gateway.sc.SentinelGatewayFilter;
import com.alibaba.csp.sentinel.adapter.gateway.sc.callback.BlockRequestHandler;
import com.alibaba.csp.sentinel.adapter.gateway.sc.callback.GatewayCallbackManager;
import com.alibaba.csp.sentinel.adapter.gateway.sc.exception.SentinelGatewayBlockExceptionHandler;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.codec.ServerCodecConfigurer;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.ServerResponse;
import org.springframework.web.reactive.result.view.ViewResolver;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;
 
import javax.annotation.PostConstruct;
import java.util.*;
 
/**
 * 使用时只需注入对应的 SentinelGatewayFilter 实例以及 SentinelGatewayBlockExceptionHandler 实例即可
 */
@Configuration
public class GatewayConfiguration {
 
    private final List<ViewResolver> viewResolvers;
    private final ServerCodecConfigurer serverCodecConfigurer;
 
    public GatewayConfiguration(ObjectProvider<List<ViewResolver>> viewResolversProvider, ServerCodecConfigurer serverCodecConfigurer) {
        this.viewResolvers = viewResolversProvider.getIfAvailable(Collections::emptyList);
        this.serverCodecConfigurer = serverCodecConfigurer;
    }
 
    @Bean
    @Order(Ordered.HIGHEST_PRECEDENCE)
    public SentinelGatewayBlockExceptionHandler sentinelGatewayBlockExceptionHandler() {
        // Register the block exception handler for Spring Cloud Gateway.
        return new SentinelGatewayBlockExceptionHandler(viewResolvers, serverCodecConfigurer);
    }
 
    @Bean
    @Order(-1)
    public GlobalFilter sentinelGatewayFilter() {
        return new SentinelGatewayFilter();
    }
 
    @PostConstruct //javax.annotation.PostConstruct
    public void doInit() {
        //自己动手，丰衣足食
        //initGatewayRules();
        initBlockHandler();
    }
 
 
    //处理+自定义返回的例外信息内容，类似我们的调用触发了流控规则保护
    private void initBlockHandler() {
        Set<GatewayFlowRule> rules = new HashSet<>();
        rules.add(new GatewayFlowRule("pay_routh1").setCount(2).setIntervalSec(1));
 
        GatewayRuleManager.loadRules(rules);
        BlockRequestHandler handler = new BlockRequestHandler() {
            @Override
            public Mono<ServerResponse> handleRequest(ServerWebExchange exchange, Throwable t) {
                Map<String,String> map = new HashMap<>();
 
                map.put("errorCode", HttpStatus.TOO_MANY_REQUESTS.getReasonPhrase());
                map.put("errorMessage", "请求太过频繁，系统忙不过来，触发限流(sentinel+gataway整合Case)");
 
                return ServerResponse.status(HttpStatus.TOO_MANY_REQUESTS)
                        .contentType(MediaType.APPLICATION_JSON)
                        .body(BodyInserters.fromValue(map));
            }
        };
        GatewayCallbackManager.setBlockHandler(handler);
    }
}
```

#### 12.11.5 测试
原生url
http://localhost:9001/pay/nacos/333

加网关
http://localhost:9528/pay/nacos/333

sentinel+gateway：加快点击频率，出现限流容错
![image.png](./img/12/344e7ee759ad4641a0c3b4d617d4bd02.png)



## 13 SpringCloud Alibaba Seata处理分布式事务
![image.png](./img/10/39c909e9ceb541b9b8a3fa53affda255.png)

### 13.1 面试题
#### 13.1.1 你简历上写用微服务boot/cloud做过项目，你不可能只有一个数据库吧？请你谈谈多个数据库之间你如何处理分布式事务？
在订单支付成功后，交易中心会调用订单中心的服务把订单状态更新，并调用物流中心的服务通知商品发货，同时还要调用积分中心的服务为用户增加相应的积分。如何保障分布式事务一致性，成为了确保订单业务稳定运行的核心诉求之一。
![image.png](./img/13/90706be5deed4f01be0a64be116ba33d.png)

#### 13.1.2 我若拿出如下场景，阁下将如何应对？
下订单
冻库存
做支付
减库存
抵扣减：积分冲抵；XX豆冲抵；礼品卷冲抵；......
送积分
做推流：微信；短信；邮件；......
派物流

#### 13.1.3 阿里巴巴的Seata-AT模式如何做到对业务的无侵入？
#### 13.1.4 对于分布式事务问题，你知道的解决方案有哪些?请你谈谈？
① 2PC（两阶段提交）
② 3PC（三阶段提交）
③ TCC方案
TCC(Try-Confirm-Cancel)又被称补偿事务
**类似2PC的柔性分布式解决方案，2PC改良版**
④ LocalMessage本地消息表；
⑤ 独立消息微服务+RabbitMQ/KafKa组件，实现可靠消息最终一致性方案；
⑥ 最大努力通知方案；


### 13.2 分布式事务问题如何产生？请先看业务
上述面试问题都指向一个重要问题
一次业务操作需要**跨多个数据源**或需要跨多个系统进行远程调用，就会产生分布式事务问题

但是
关系型数据库提供的能力是基于**单机事务**的，一旦遇到分布式事务场景，就需要通过更多其他技术手段来解决问题。

分布式事务before
单机单库没这个问题
表结构的关系从1:1 → 1:N → N:N

分布式事务after
单体应用被拆分成微服务应用，原来的三个模块被拆分成**三个独立的应用**，分别使用**三个独立的数据源**，
业务操作需要调用三个服务来完成。
此时**每个服务自己内部的数据一致性由本地事务来保证，但是全局的数据一致性问题没法保证**。
![image.png](./img/13/0fbd710ddc704c4cb143338375a54669.png)

结论
迫切希望提供一种分布式事务框架，解决微服务架构下的分布式事务问题

### 13.3 Seata简介
概念
Simple Extensible Autonomous Transaction Architecture
简单可扩展自治事务框架

官网解释
Apache Seata(incubating) 是一款开源的分布式事务解决方案，致力于在微服务架构下提供高性能和简单易用的分布式事务服务。
![image.png](./img/13/4699d31f784d459f8826b35ac90d7c6b.png)

Seata的发展历程
阿里巴巴作为国内最早一批进行应用分布式（微服务化）改造的企业，很早就遇到微服务架构下的分布式事务问题。
2019年1月份蚂蚁金服和阿里巴巴共同开源的分布式事务解决方案：
2014 年，阿里中间件团队发布 TXC（Taobao Transaction Constructor），为集团内应用提供分布式事务服务。
2016 年，TXC 在经过产品化改造后，以 GTS（Global Transaction Service） 的身份登陆阿里云，成为当时业界唯一一款云上分布式事务产品。在阿云里的公有云、专有云解决方案中，开始服务于众多外部客户。
2019 年起，基于 TXC 和 GTS 的技术积累，阿里中间件团队发起了开源项目 Fescar（Fast & EaSy Commit And Rollback, FESCAR），和社区一起建设这个分布式事务解决方案。
2019 年 **fescar(全称fast easy commit and rollback)** 被重命名为了seata（simple extensiable autonomous transaction architecture）。TXC、GTS、Fescar 以及 seata 一脉相承，为解决微服务架构下的分布式事务问题交出了一份与众不同的答卷。

作用
Seata是一款开源的分布式事务解决方案，致力于在微服务架构下提供高性能和简单易用的分布式事务服务。

下载
官网地址
[Apache Seata](https://seata.apache.org/zh-cn/)

源码地址
[Releases · apache/incubator-seata · GitHub](https://github.com/apache/incubator-seata/releases)

使用
本地@Transactional
全局@GlobalTransactional
Seata的分布式交易解决方案

(TC→TM→RM)分别什么意思
![image.png](./img/13/c9d87abc4cfe4d3a8b39cfbd6e2f9446.png)

### 13.4 Seata工作流程简介
#### 13.4.1 纵观整个分布式事务的管理，就是全局事务ID的传递和变更，要让开发者无感知
![image.png](./img/13/325b6d37eecb4f0a9916f53f3007eded.png)

#### 13.4.2 Seata对分布式事务的协调和控制就是1+3
1个XID
XID是全局事务的唯一标识，它可以在服务的调用链路中传递，绑定到服务的事务上下文中。

官网版3个概念(TC→TM→RM)
![image.png](./img/13/91f5ab8ce2624981bac72a01fee60f7d.png)

阳哥版3个概念(TC→TM→RM)
![image.png](./img/13/4484639a205b4089b7f81d6fe07fb44a.png)

TC（Transaction Coordinator）事务协调器
**就是Seata**，负责维护全局事务和分支事务的状态，驱动全局事务提交或回滚。

TM（Transaction Manager）事务管理器
**标注全局@GlobalTransactional启动入口动作的微服务模块**(比如订单模块)，它是事务的发起者，负责定义全局事务的范围，并根据​TC 维护的全局事务和分支事务状态，做出开始事务、提交事务、回滚事务的决议

RM（Resource Manager）资源管理器
**就是mysql数据库本身**，可以是多个RM，负责管理分支事务上的资源，向 TC​注册分支事务，汇报分支事务状态，驱动分支事务的提交或回滚

#### 13.4.3 分布式事务的执行流程-小总结
三个组件相互协作，TC以Seata 服务器(Server)形式独立部署，TM和RM则是以Seata Client的形式集成在微服务中运行，

流程如下：
![image.png](./img/13/802b461f8af24632815357ea825c43bd.png)
![image.png](./img/13/e676a3fb8f794b21a2d0760c9c81dde4.png)

1 TM向 TC 申请开启一个全局事务，全局事务创建成功并生成一个全局唯一的 XID；
2 XID 在微服务调用链路的上下文中传播；
3 RM向 TC 注册分支事务，将其纳入 XID 对应全局事务的管辖；
4 TM 向 TC 发起针对 XID 的全局提交或回滚决议；
5 TC 调度 XID 下管辖的全部分支事务完成提交或回滚请求。

#### 13.4.4 各事务模式
[Seata AT 模式 | Apache Seata](https://seata.apache.org/zh-cn/docs/user/mode/at/)
日常工作+企业调研+本次课时安排限制，以AT模式作为入手突破

### 13.5 Seata-Server2.0.0安装
#### 13.5.1 下载地址
[Seata-Server下载 | Apache Seata](https://seata.apache.org/zh-cn/unversioned/download/seata-server)

13.5.2 下载版本
https://github.com/seata/seata/releases/tag/v2.0.0
![image.png](./img/13/218d857f37ae4cbda83f86b7ed08336f.png)

#### 13.5.3 各种seata参数官网参考
[参数配置 | Apache Seata](https://seata.apache.org/zh-cn/docs/user/configurations/)

#### 13.5.4 Seata新手部署指南
![image.png](./img/13/d06a8fcd547d4c8eba0a04b2af165004.png)

#### 13.5.5 mysql8.0数据库里面建库+建表
建库seata
CREATE DATABASE seata;
USE seata;

在上一步seata库里建表
建表SQL地址
https://github.com/seata/seata/blob/develop/script/server/db/mysql.sql

SQL脚本内容
```sql
-- -------------------------------- The script used when storeMode is 'db' --------------------------------
 
-- the table to store GlobalSession data
CREATE TABLE IF NOT EXISTS `global_table`( 
    `xid`                       VARCHAR(128) NOT NULL, 
    `transaction_id`            BIGINT, 
    `status`                    TINYINT      NOT NULL, 
    `application_id`            VARCHAR(32), 
    `transaction_service_group` VARCHAR(32), 
    `transaction_name`          VARCHAR(128), 
    `timeout`                   INT, 
    `begin_time`                BIGINT, 
    `application_data`          VARCHAR(2000), 
    `gmt_create`                DATETIME, 
    `gmt_modified`              DATETIME, 
    PRIMARY KEY (`xid`), 
    KEY `idx_status_gmt_modified` (`status` , `gmt_modified`), 
    KEY `idx_transaction_id` (`transaction_id`) 
) ENGINE = InnoDB 
  DEFAULT CHARSET = utf8mb4;
   
-- the table to store BranchSession data
CREATE TABLE IF NOT EXISTS `branch_table`( 
    `branch_id`         BIGINT       NOT NULL, 
    `xid`               VARCHAR(128) NOT NULL, 
    `transaction_id`    BIGINT, 
    `resource_group_id` VARCHAR(32), 
    `resource_id`       VARCHAR(256), 
    `branch_type`       VARCHAR(8), 
    `status`            TINYINT, 
    `client_id`         VARCHAR(64), 
    `application_data`  VARCHAR(2000), 
    `gmt_create`        DATETIME(6),
     `gmt_modified`      DATETIME(6), 
    PRIMARY KEY (`branch_id`), 
    KEY `idx_xid` (`xid`) 
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4; 
 
-- the table to store lock data 
CREATE TABLE IF NOT EXISTS `lock_table`(
    `row_key`        VARCHAR(128) NOT NULL, 
    `xid`            VARCHAR(128), 
    `transaction_id` BIGINT, 
    `branch_id`      BIGINT       NOT NULL, 
    `resource_id`    VARCHAR(256), 
    `table_name`     VARCHAR(32), 
    `pk`             VARCHAR(36), 
    `status`         TINYINT      NOT NULL DEFAULT '0' COMMENT '0:locked ,1:rollbacking', 
    `gmt_create`     DATETIME, 
    `gmt_modified`   DATETIME, 
    PRIMARY KEY (`row_key`), 
    KEY `idx_status` (`status`), 
    KEY `idx_branch_id` (`branch_id`), 
    KEY `idx_xid` (`xid`) 
) ENGINE = InnoDB 
  DEFAULT CHARSET = utf8mb4;
 
CREATE TABLE IF NOT EXISTS `distributed_lock`( 
    `lock_key`       CHAR(20) NOT NULL, 
    `lock_value`     VARCHAR(20) NOT NULL, 
    `expire`         BIGINT, 
    primary key (`lock_key`) 
) ENGINE = InnoDB 
  DEFAULT CHARSET = utf8mb4; 
 
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('AsyncCommitting', ' ', 0); 
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('RetryCommitting', ' ', 0); 
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('RetryRollbacking', ' ', 0); 
INSERT INTO `distributed_lock` (lock_key, lock_value, expire) VALUES ('TxTimeoutCheck', ' ', 0);
```

结果
![image.png](./img/13/50a86bbe17f9429388d1e9f78391068a.png)

#### 13.5.6 更改配置
修改seata-server-2.0.0\conf\application.yml配置文件，记得先备份
![image.png](./img/13/bf5921afb6304b738f761a7c2eeb6622.png)

提前备份，备份，备份application.yml
application.yml定稿版
```yml
#  Copyright 1999-2019 Seata.io Group.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

server:
  port: 7091

spring:
  application:
    name: seata-server 

logging:
  config: classpath:logback-spring.xml
  file:
    path: ${log.home:${user.home}/logs/seata}
  extend:
    logstash-appender:
      destination: 127.0.0.1:4560
    kafka-appender:
      bootstrap-servers: 127.0.0.1:9092
      topic: logback_to_logstash

console:
  user:
    username: seata
    password: seata

seata:
  config:
    type: nacos
    nacos:
      server-addr: 127.0.0.1:8848
      namespace:
      group: SEATA_GROUP # 后续自己在nacos里面新建,不想新建SEATA_GROUP，就写DEFAULT_GROUP
      username: nacos
      password: nacos
  registry:
    type: nacos
    nacos:
      application: seata-server
      server-addr: 127.0.0.1:8848
      group: SEATA_GROUP # 后续自己在nacos里面新建,不想新建SEATA_GROUP，就写DEFAULT_GROUP
      namespace:
      cluster: default
      username: nacos
      password: nacos    
  store:
    mode: db
    db:
      datasource: druid
      db-type: mysql
      driver-class-name: com.mysql.cj.jdbc.Driver
      url: jdbc:mysql://localhost:3306/seata?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
      user: root
      password: password
      min-conn: 10
      max-conn: 100
      global-table: global_table
      branch-table: branch_table
      lock-table: lock_table
      distributed-lock-table: distributed_lock
      query-limit: 1000
      max-wait: 5000
      

  #  server:
  #    service-port: 8091 #If not configured, the default is '${server.port} + 1000'
  security:
    secretKey: SeataSecretKey0c382ef121d778043159209298fd40bf3850a017
    tokenValidityInMilliseconds: 1800000
    ignore:
      urls: /,/**/*.css,/**/*.js,/**/*.html,/**/*.map,/**/*.svg,/**/*.png,/**/*.jpeg,/**/*.ico,/api/v1/auth/login,/metadata/v1/**
```

#### 13.5.7 先启动Nacos2.2.3端口号8848
startup.cmd -m standalone
命令运行成功后直接访问http://localhost:8848/nacos
默认账号密码都是nacos

#### 13.5.8 再启动seata-server-2.0.0
D:\devSoft\seata-server-2.0.0\bin
seata-server.bat 命令执行后
http://localhost:7091
![image.png](./img/13/74745e8db95746b79a77a599947dccc1.png)

看看Nacos
![image.png](./img/13/35411f17c8194f929c15df021a0e559b.png)

## 13.6 Seata案例实战-数据库和表准备
订单 + 库存+ 账户
3个业务数据库MySQL准备
以下演示都需要**先启动Nacos后启动Seata**，保证两个都OK

#### 13.6.1 分布式事务本案例业务说明
这里我们创建三个服务，一个订单服务，一个库存服务，一个账户服务。-------最下面还有笔记

当用户下单时，会在订单服务中创建一个订单，然后通过远程调用库存服务来扣减下单商品的库存，
再通过远程调用账户服务来扣减用户账户里面的余额，
最后在订单服务中修改订单状态为已完成。该操作跨越三个数据库，有两次远程调用，很明显会有分布式事务问题。

<font color="red">下订单 → 减库存  → 扣余额  → 改(订单)状态</font>

![image.png](./img/13/1e6a05edb5c34ea19493eb8216211db7.png)
![image.png](./img/13/b8d759103a78489bbc78457a2b2b52f0.png)

#### 13.6.2 创建3个业务数据库DATABASE​
seata_order：存储订单的数据库；
seata_storage：存储库存的数据库；
seata_account：存储账户信息的数据库。

建库SQL
CREATE DATABASE seata_order;
CREATE DATABASE seata_storage;
CREATE DATABASE seata_account;

#### 13.6.3 按照上述3库分别建对应的undo_log回滚日志表
订单-库存-账户3个库下都需要建各自的undo_log

seata官网
[incubator-seata/script/client/at/db/mysql.sql at 2.x · apache/incubator-seata · GitHub](https://github.com/apache/incubator-seata/blob/2.x/script/client/at/db/mysql.sql)

undo_log建表SQL
```sql
-- for AT mode you must to init this sql for you business database. the seata server not need it.
CREATE TABLE IF NOT EXISTS `undo_log`(
    `branch_id`     BIGINT       NOT NULL COMMENT 'branch transaction id',
    `xid`           VARCHAR(128) NOT NULL COMMENT 'global transaction id',
    `context`       VARCHAR(128) NOT NULL COMMENT 'undo_log context,such as serialization',
    `rollback_info` LONGBLOB     NOT NULL COMMENT 'rollback info',
    `log_status`    INT(11)      NOT NULL COMMENT '0:normal status,1:defense status',
    `log_created`   DATETIME(6)  NOT NULL COMMENT 'create datetime',
    `log_modified`  DATETIME(6)  NOT NULL COMMENT 'modify datetime',
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COMMENT ='AT transaction mode undo table';
ALTER TABLE `undo_log` ADD INDEX `ix_log_created` (`log_created`);
```
![image.png](./img/13/24f824802d984bdda6fd19e081ff767d.png)

#### 13.6.4 按照上述3库分别建对应业务表
t_order脚本SQL
```sql
CREATE TABLE t_order( 
`id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
`user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id', 
`product_id` BIGINT(11)DEFAULT NULL COMMENT '产品id', 
`count` INT(11) DEFAULT NULL COMMENT '数量', 
`money` DECIMAL(11,0) DEFAULT NULL COMMENT '金额', 
`status` INT(1) DEFAULT NULL COMMENT '订单状态: 0:创建中; 1:已完结' 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
 
SELECT * FROM t_order;
```

t_account脚本SQL
```sql
CREATE TABLE t_account( 
`id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'id', 
`user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id', 
`total` DECIMAL(10,0) DEFAULT NULL COMMENT '总额度', 
`used` DECIMAL(10,0) DEFAULT NULL COMMENT '已用账户余额', 
`residue` DECIMAL(10,0) DEFAULT '0' COMMENT '剩余可用额度' 
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8; 
 
INSERT INTO t_account(`id`,`user_id`,`total`,`used`,`residue`)VALUES('1','1','1000','0','1000');
SELECT * FROM t_account;
```

t_storage脚本SQL
```sql
CREATE TABLE t_storage( 
`id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
`product_id` BIGINT(11) DEFAULT NULL COMMENT '产品id', 
`total` INT(11) DEFAULT NULL COMMENT '总库存', 
`used` INT(11) DEFAULT NULL COMMENT '已用库存', 
`residue` INT(11) DEFAULT NULL COMMENT '剩余库存' 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
 
INSERT INTO t_storage(`id`,`product_id`,`total`,`used`,`residue`)VALUES('1','1','100','0','100');
SELECT * FROM t_storage;
```

#### 13.6.5 最终All-SQL(同学们自用，同学们自用，同学们自用，)
建seata_order库+建t_order表+undo_log表
```sql
-- order

CREATE DATABASE seata_order; 
USE seata_order; 
CREATE TABLE t_order( 
`id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
`user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id', 
`product_id` BIGINT(11)DEFAULT NULL COMMENT '产品id', 
`count` INT(11) DEFAULT NULL COMMENT '数量', 
`money` DECIMAL(11,0) DEFAULT NULL COMMENT '金额', 
`status` INT(1) DEFAULT NULL COMMENT '订单状态: 0:创建中; 1:已完结' 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SELECT * FROM t_order; 
 
-- for AT mode you must to init this sql for you business database. the seata server not need it.

CREATE TABLE IF NOT EXISTS `undo_log` (
 
    `branch_id`     BIGINT       NOT NULL COMMENT 'branch transaction id', 
    `xid`           VARCHAR(128) NOT NULL COMMENT 'global transaction id', 
    `context`       VARCHAR(128) NOT NULL COMMENT 'undo_log context,such as serialization', 
    `rollback_info` LONGBLOB     NOT NULL COMMENT 'rollback info', 
    `log_status`    INT(11)      NOT NULL COMMENT '0:normal status,1:defense status', 
    `log_created`   DATETIME(6)  NOT NULL COMMENT 'create datetime', 
    `log_modified`  DATETIME(6)  NOT NULL COMMENT 'modify datetime', 
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`) 
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COMMENT ='AT transaction mode undo table';
 
ALTER TABLE `undo_log` ADD INDEX `ix_log_created` (`log_created`);
```

建seata_storage库+建t_storage 表+undo_log表
```sql
-- storage
 
CREATE DATABASE seata_storage; 
USE seata_storage; 
CREATE TABLE t_storage( 
`id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, 
`product_id` BIGINT(11) DEFAULT NULL COMMENT '产品id', 
`total` INT(11) DEFAULT NULL COMMENT '总库存', 
`used` INT(11) DEFAULT NULL COMMENT '已用库存', 
`residue` INT(11) DEFAULT NULL COMMENT '剩余库存' 
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 
 
INSERT INTO t_storage(`id`,`product_id`,`total`,`used`,`residue`)VALUES('1','1','100','0','100'); 
 
SELECT * FROM t_storage;
 
 -- for AT mode you must to init this sql for you business database. the seata server not need it.
 
CREATE TABLE IF NOT EXISTS `undo_log`(
 
    `branch_id`     BIGINT       NOT NULL COMMENT 'branch transaction id', 
    `xid`           VARCHAR(128) NOT NULL COMMENT 'global transaction id', 
    `context`       VARCHAR(128) NOT NULL COMMENT 'undo_log context,such as serialization', 
    `rollback_info` LONGBLOB     NOT NULL COMMENT 'rollback info', 
    `log_status`    INT(11)      NOT NULL COMMENT '0:normal status,1:defense status', 
    `log_created`   DATETIME(6)  NOT NULL COMMENT 'create datetime', 
    `log_modified`  DATETIME(6)  NOT NULL COMMENT 'modify datetime', 
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`) 
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COMMENT ='AT transaction mode undo table';
 
ALTER TABLE `undo_log` ADD INDEX `ix_log_created` (`log_created`);
```

建seata_account库+建t_account 表+undo_log表
```sql
-- account
 
create database seata_account; 
use seata_account; 
CREATE TABLE t_account( 
`id` BIGINT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'id', 
`user_id` BIGINT(11) DEFAULT NULL COMMENT '用户id', 
`total` DECIMAL(10,0) DEFAULT NULL COMMENT '总额度', 
`used` DECIMAL(10,0) DEFAULT NULL COMMENT '已用余额', 
`residue` DECIMAL(10,0) DEFAULT '0' COMMENT '剩余可用额度' 
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
 
INSERT INTO t_account(`id`,`user_id`,`total`,`used`,`residue`)VALUES('1','1','1000','0','1000');
 
SELECT * FROM t_account; 
 
 -- for AT mode you must to init this sql for you business database. the seata server not need it.
 
CREATE TABLE IF NOT EXISTS `undo_log`( 
    `branch_id`     BIGINT       NOT NULL COMMENT 'branch transaction id', 
    `xid`           VARCHAR(128) NOT NULL COMMENT 'global transaction id', 
    `context`       VARCHAR(128) NOT NULL COMMENT 'undo_log context,such as serialization', 
    `rollback_info` LONGBLOB     NOT NULL COMMENT 'rollback info', 
    `log_status`    INT(11)      NOT NULL COMMENT '0:normal status,1:defense status', 
    `log_created`   DATETIME(6)  NOT NULL COMMENT 'create datetime', 
    `log_modified`  DATETIME(6)  NOT NULL COMMENT 'modify datetime', 
    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`) 
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COMMENT ='AT transaction mode undo table';
 
ALTER TABLE `undo_log` ADD INDEX `ix_log_created` (`log_created`);
```

#### 13.6.6 最终效果
![image.png](./img/13/795fd5e813d147fcbb461181c92f48f6.png)

### 13.7 Seata案例实战-微服务编码落地实现
订单/库存/账户业务微服务Java开发准备

#### 13.7.1 业务需求
一句话：下订单→减库存→扣余额→改（订单）状态

#### 13.7.2 Mybaits一键生成
config.properties
```
#t_pay表包名
package.name=com.atguigu.cloud
 
# mysql8.0
jdbc.driverClass = com.mysql.cj.jdbc.Driver
jdbc.url= jdbc:mysql://localhost:3306/db2024?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
jdbc.user = root
jdbc.password =password
 
# seata_order
#jdbc.driverClass = com.mysql.cj.jdbc.Driver
#jdbc.url = jdbc:mysql://localhost:3306/seata_order?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
#jdbc.user = root
#jdbc.password =password
 
# seata_storage
#jdbc.driverClass = com.mysql.cj.jdbc.Driver
#jdbc.url = jdbc:mysql://localhost:3306/seata_storage?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
#jdbc.user = root
#jdbc.password =password
 
# seata_account
#jdbc.driverClass = com.mysql.cj.jdbc.Driver
#jdbc.url = jdbc:mysql://localhost:3306/seata_account?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
#jdbc.user = root
#jdbc.password =password
```

generatorConfig.xml
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
 
        <!--  seata_order -->
        <!--<table tableName="t_order" domainObjectName="Order">
            <generatedKey column="id" sqlStatement="JDBC"/>
        </table>-->
 
        <!--seata_storage-->
        <!--<table tableName="t_storage" domainObjectName="Storage">
            <generatedKey column="id" sqlStatement="JDBC"/>
        </table>-->
 
        <!--seata_account-->
        <!--<table tableName="t_account" domainObjectName="Account">
            <generatedKey column="id" sqlStatement="JDBC"/>
        </table>-->
 
    </context>
</generatorConfiguration>
```

#### 13.7.3 修改公共cloud-api-commons新增库存和账户两个Feign服务接口
StorageFeignApi
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.resp.ResultData;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
 
@FeignClient(value = "seata-storage-service")
public interface StorageFeignApi{
    // 扣减库存
    @PostMapping(value = "/storage/decrease")
    ResultData decrease(@RequestParam("productId") Long productId, @RequestParam("count") Integer count);
}
```

AccountFeignApi
```java
package com.atguigu.cloud.apis;
 
import com.atguigu.cloud.resp.ResultData;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
 
 
@FeignClient(value = "seata-account-service")
public interface AccountFeignApi{
    // 扣减账户余额
    @PostMapping("/account/decrease")
    ResultData decrease(@RequestParam("userId") Long userId, @RequestParam("money") Long money);
}
```

#### 13.7.4 新建订单Order微服务
##### 13.7.4.1 建Module
seata-order-service2001

##### 13.7.4.2 改POM
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
 
    <artifactId>seata-order-service2001</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
 
    <dependencies>
        <!-- nacos -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!--alibaba-seata-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-seata</artifactId>
        </dependency>
        <!--openfeign-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <!--loadbalancer-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-loadbalancer</artifactId>
        </dependency>
        <!--cloud-api-commons-->
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

##### 13.7.4.3 写YML
```yml
server:
  port: 2001
 
spring:
  application:
    name: seata-order-service
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848         # Nacos服务注册中心地址
# ==========applicationName + druid-mysql8 driver===================
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/seata_order?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
 
# ========================seata===================
seata:
  registry:
    type: nacos
    nacos:
      server-addr: 127.0.0.1:8848
      namespace: ""
      group: SEATA_GROUP
      application: seata-server
  tx-service-group: default_tx_group # 事务组，由它获得TC服务的集群名称
  service:
    vgroup-mapping: # 点击源码分析
      default_tx_group: default # 事务组与TC服务集群的映射关系
  data-source-proxy-mode: AT
 
logging:
  level:
    io:
      seata: info
```

Namespace+Group+DataId三者关系？ 为什么这么设计？
![image.png](./img/13/dec509db76974570918eb5d5d0b4ba0d.png)

对应说明
![image.png](./img/13/12727a2d13a748ec96c2a42f8c367b8b.png)

上图落地的对应源码(笔记最下面还有)：io.seata.spring.boot.autoconfigure.properties.client.ServiceProperties
![image.png](./img/13/582411bcec1f46d5b48b415a4924b0a7.png)

上图落地的对应源码：io.seata.common.DefaultValues
![image.png](./img/13/3ae375f880d142e7b56e5bc50c26a96f.png)

详细过度版(了解即可，太详细也不好维护)
```yml
#seata:
#  registry: # seata注册配置
#    type: nacos # seata注册类型
#    nacos:
#      application: seata-server #seata应用名称
#      server-addr: 127.0.0.1:8848
#      namespace: ""
#      group: SEATA_GROUP
#      cluster: default
#  config:             # seata配置抓取
#    nacos:
#      server-addr: 127.0.0.1:8848
#      namespace: ""
#      group: SEATA_GROUP
#      username: nacos
#      password: nacos
#  tx-service-group: default_tx_group # 事务组，由它获得TC服务的集群名称
#  service:
#    vgroup-mapping:
#      default_tx_group: default # 事务群组的映射配置关系
#  data-source-proxy-mode: AT
#  application-id: seata-server
```

##### 13.7.4.4 主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import tk.mybatis.spring.annotation.MapperScan;
 
@SpringBootApplication
@MapperScan("com.atguigu.cloud.mapper") //import tk.mybatis.spring.annotation.MapperScan;
@EnableDiscoveryClient //服务注册和发现
@EnableFeignClients
public class SeataOrderMainApp2001{
    public static void main(String[] args){
        SpringApplication.run(SeataOrderMainApp2001.class,args);
    }
}
```

##### 13.7.4.5 业务类
entities

Order
```java
package com.atguigu.cloud.entities;
 
 
import lombok.ToString;
 
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
 
@Table(name = "t_order")
@ToString
public class Order implements Serializable{
    @Id
    @GeneratedValue(generator = "JDBC")
    private Long id;
 
    /**
     * 用户id
     */
    @Column(name = "user_id")
    private Long userId;
 
    /**
     * 产品id
     */
    @Column(name = "product_id")
    private Long productId;
 
    /**
     * 数量
     */
    private Integer count;
 
    /**
     * 金额
     */
    private Long money;
 
    /**
     * 订单状态：0：创建中；1：已完结
     */
    private Integer status;
 
    /**
     * @return id
     */
    public Long getId() {
        return id;
    }
 
    /**
     * @param id
     */
    public void setId(Long id) {
        this.id = id;
    }
 
    /**
     * 获取用户id
     *
     * @return user_id - 用户id
     */
    public Long getUserId() {
        return userId;
    }
 
    /**
     * 设置用户id
     *
     * @param userId 用户id
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }
 
    /**
     * 获取产品id
     *
     * @return product_id - 产品id
     */
    public Long getProductId() {
        return productId;
    }
 
    /**
     * 设置产品id
     *
     * @param productId 产品id
     */
    public void setProductId(Long productId) {
        this.productId = productId;
    }
 
    /**
     * 获取数量
     *
     * @return count - 数量
     */
    public Integer getCount() {
        return count;
    }
 
    /**
     * 设置数量
     *
     * @param count 数量
     */
    public void setCount(Integer count) {
        this.count = count;
    }
 
    /**
     * 获取金额
     *
     * @return money - 金额
     */
    public Long getMoney() {
        return money;
    }
 
    /**
     * 设置金额
     *
     * @param money 金额
     */
    public void setMoney(Long money) {
        this.money = money;
    }
 
    /**
     * 获取订单状态：0：创建中；1：已完结
     *
     * @return status - 订单状态：0：创建中；1：已完结
     */
    public Integer getStatus() {
        return status;
    }
 
    /**
     * 设置订单状态：0：创建中；1：已完结
     *
     * @param status 订单状态：0：创建中；1：已完结
     */
    public void setStatus(Integer status) {
        this.status = status;
    }
 
 
    @Override
    public String toString(){
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", count=" + count +
                ", money=" + money +
                ", status=" + status +
                '}';
    }
}
```

OrderMapper
OrderMapper 接口
```java
package com.atguigu.cloud.mapper;
 
import com.atguigu.cloud.entities.Order;
import tk.mybatis.mapper.common.Mapper;
 
public interface OrderMapper extends Mapper<Order> {
}
```

resources文件夹下新建mapper文件夹后添加OrderMapper.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.atguigu.cloud.mapper.OrderMapper">
    <resultMap id="BaseResultMap" type="com.atguigu.cloud.entities.Order">
        <!--
          WARNING - @mbg.generated
        -->
        <id column="id" jdbcType="BIGINT" property="id" />
        <result column="user_id" jdbcType="BIGINT" property="userId" />
        <result column="product_id" jdbcType="BIGINT" property="productId" />
        <result column="count" jdbcType="INTEGER" property="count" />
        <result column="money" jdbcType="DECIMAL" property="money" />
        <result column="status" jdbcType="INTEGER" property="status" />
    </resultMap>
 
</mapper>
```

Service接口及实现
OrderService
```java
package com.atguigu.cloud.service;
import com.atguigu.cloud.entities.Order;
 
public interface OrderService {
 
    /**
     * 创建订单
     */
    void create(Order order);
 
}
```

OrderServiceImpl
```java
package com.atguigu.cloud.service.impl;
 
import com.atguigu.cloud.apis.AccountFeignApi;
import com.atguigu.cloud.apis.StorageFeignApi;
import com.atguigu.cloud.entities.Order;
import com.atguigu.cloud.mapper.OrderMapper;
import com.atguigu.cloud.service.OrderService;
import io.seata.core.context.RootContext;
import io.seata.rm.tcc.api.LocalTCC;
import io.seata.spring.annotation.GlobalTransactional;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;
 
import java.util.concurrent.atomic.AtomicInteger;
 
/**
 * 下订单->减库存->扣余额->改(订单)状态
 */
@Slf4j
@Service
public class OrderServiceImpl implements OrderService{
    @Resource
    private OrderMapper orderMapper;
    @Resource//订单微服务通过OpenFeign去调用库存微服务
    private StorageFeignApi storageFeignApi;
    @Resource//订单微服务通过OpenFeign去调用账户微服务
    private AccountFeignApi accountFeignApi;
 
 
    @Override
    @GlobalTransactional(name = "zzyy-create-order",rollbackFor = Exception.class) //AT
    //@GlobalTransactional @Transactional(rollbackFor = Exception.class) //XA
    public void create(Order order) {
 
        //xid全局事务id的检查，重要
        String xid = RootContext.getXID();
 
        //1. 新建订单
        log.info("==================>开始新建订单"+"\t"+"xid_order:" +xid);
        //订单状态status：0：创建中；1：已完结
        order.setStatus(0);
        int result = orderMapper.insertSelective(order);
 
        //插入订单成功后获得插入mysql的实体对象
        Order orderFromDB = null;
        if(result > 0){
            orderFromDB = orderMapper.selectOne(order);
            //orderFromDB = orderMapper.selectByPrimaryKey(order.getId());
            log.info("-------> 新建订单成功，orderFromDB info: "+orderFromDB);
            System.out.println();
            //2. 扣减库存
            log.info("-------> 订单微服务开始调用Storage库存，做扣减count");
            storageFeignApi.decrease(orderFromDB.getProductId(), orderFromDB.getCount());
            log.info("-------> 订单微服务结束调用Storage库存，做扣减完成");
            System.out.println();
            //3. 扣减账号余额
            log.info("-------> 订单微服务开始调用Account账号，做扣减money");
            accountFeignApi.decrease(orderFromDB.getUserId(), orderFromDB.getMoney());
            log.info("-------> 订单微服务结束调用Account账号，做扣减完成");
            System.out.println();
            //4. 修改订单状态
            //订单状态status：0：创建中；1：已完结
            log.info("-------> 修改订单状态");
            orderFromDB.setStatus(1);
 
            Example whereCondition=new Example(Order.class);
            Example.Criteria criteria=whereCondition.createCriteria();
            criteria.andEqualTo("userId",orderFromDB.getUserId());
            criteria.andEqualTo("status",0);
 
            int updateResult = orderMapper.updateByExampleSelective(orderFromDB, whereCondition);
 
            log.info("-------> 修改订单状态完成"+"\t"+updateResult);
            log.info("-------> orderFromDB info: "+orderFromDB);
        }
        System.out.println();
        log.info("==================>结束新建订单"+"\t"+"xid_order:" +xid);
 
    }
}
```

Controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.entities.Order;
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.service.OrderService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class OrderController {
   
    @Resource
    private OrderService orderService;
 
    /**
     * 创建订单
     */
    @GetMapping("/order/create")
    public ResultData create(Order order) {
        orderService.create(order);
        return ResultData.success(order);
    }
}
```

#### 13.7.5 新建库存Storage微服务
##### 13.7.5.1 建Module
seata-storage-service2002

##### 13.7.5.2 改POM
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
 
    <artifactId>seata-storage-service2002</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
    <dependencies>
        <!-- nacos -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!--alibaba-seata-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-seata</artifactId>
        </dependency>
        <!--openfeign-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <!--loadbalancer-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-loadbalancer</artifactId>
        </dependency>
        <!--cloud_commons_utils-->
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

##### 13.7.5.3 写YML
```yml
server:
  port: 2002
 
spring:
  application:
    name: seata-storage-service
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848         # Nacos服务注册中心地址
  # ==========applicationName + druid-mysql8 driver===================
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/seata_storage?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
# ========================seata===================
seata:
  registry:
    type: nacos
    nacos:
      server-addr: 127.0.0.1:8848
      namespace: ""
      group: SEATA_GROUP
      application: seata-server
  tx-service-group: default_tx_group # 事务组，由它获得TC服务的集群名称
  service:
    vgroup-mapping:
      default_tx_group: default # 事务组与TC服务集群的映射关系
  data-source-proxy-mode: AT
 
logging:
  level:
    io:
      seata: info
```

##### 13.7.5.4 主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import tk.mybatis.spring.annotation.MapperScan;
 
@SpringBootApplication
@MapperScan("com.atguigu.cloud.mapper") //import tk.mybatis.spring.annotation.MapperScan;
@EnableDiscoveryClient //服务注册和发现
@EnableFeignClients
public class SeataStorageMainApp2002{
    public static void main(String[] args){
        SpringApplication.run(SeataStorageMainApp2002.class,args);
    }
}
```

##### 13.7.5.5 业务类
entities

Storage
```java
package com.atguigu.cloud.entities;
 
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
 
 
@Table(name = "t_storage")
public class Storage implements Serializable{
    @Id
    @GeneratedValue(generator = "JDBC")
    private Long id;
 
    /**
     * 产品id
     */
    @Column(name = "product_id")
    private Long productId;
 
    /**
     * 总库存
     */
    private Integer total;
 
    /**
     * 已用库存
     */
    private Integer used;
 
    /**
     * 剩余库存
     */
    private Integer residue;
 
    /**
     * @return id
     */
    public Long getId() {
        return id;
    }
 
    /**
     * @param id
     */
    public void setId(Long id) {
        this.id = id;
    }
 
    /**
     * 获取产品id
     *
     * @return product_id - 产品id
     */
    public Long getProductId() {
        return productId;
    }
 
    /**
     * 设置产品id
     *
     * @param productId 产品id
     */
    public void setProductId(Long productId) {
        this.productId = productId;
    }
 
    /**
     * 获取总库存
     *
     * @return total - 总库存
     */
    public Integer getTotal() {
        return total;
    }
 
    /**
     * 设置总库存
     *
     * @param total 总库存
     */
    public void setTotal(Integer total) {
        this.total = total;
    }
 
    /**
     * 获取已用库存
     *
     * @return used - 已用库存
     */
    public Integer getUsed() {
        return used;
    }
 
    /**
     * 设置已用库存
     *
     * @param used 已用库存
     */
    public void setUsed(Integer used) {
        this.used = used;
    }
 
    /**
     * 获取剩余库存
     *
     * @return residue - 剩余库存
     */
    public Integer getResidue() {
        return residue;
    }
 
    /**
     * 设置剩余库存
     *
     * @param residue 剩余库存
     */
    public void setResidue(Integer residue) {
        this.residue = residue;
    }
 
    @Override
    public String toString(){
        return "Storage{" +
                "id=" + id +
                ", productId=" + productId +
                ", total=" + total +
                ", used=" + used +
                ", residue=" + residue +
                '}';
    }
}
```

StorageMapper
StorageMapper接口
```java
package com.atguigu.cloud.mapper;
 
import com.atguigu.cloud.entities.Storage;
import io.seata.rm.tcc.api.BusinessActionContextParameter;
import tk.mybatis.mapper.common.Mapper;
import org.apache.ibatis.annotations.Param;
 
public interface StorageMapper extends Mapper<Storage>{
    /**
     * 扣减库存
     */
    void decrease(@Param("productId") Long productId, @Param("count") Integer count);
 
}
```

resources文件夹下新建mapper文件夹后添加StorageMapper.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.atguigu.cloud.mapper.StorageMapper">
    <resultMap id="BaseResultMap" type="com.atguigu.cloud.entities.Storage">
        <!--
          WARNING - @mbg.generated
        -->
        <id column="id" jdbcType="BIGINT" property="id" />
        <result column="product_id" jdbcType="BIGINT" property="productId" />
        <result column="total" jdbcType="INTEGER" property="total" />
        <result column="used" jdbcType="INTEGER" property="used" />
        <result column="residue" jdbcType="INTEGER" property="residue" />
    </resultMap>
 
    <update id="decrease">
        UPDATE
            t_storage
        SET
            used = used + #{count},
            residue = residue - #{count}
        WHERE product_id = #{productId}
    </update>
 
</mapper>
```

Service接口及实现
StorageService
```java
package com.atguigu.cloud.serivce;
 
public interface StorageService {
    /**
     * 扣减库存
     */
    void decrease(Long productId, Integer count);
}
```

StorageServiceImpl
```java
package com.atguigu.cloud.serivce.impl;
 
import com.atguigu.cloud.mapper.StorageMapper;
import com.atguigu.cloud.serivce.StorageService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
 
@Service
@Slf4j
public class StorageServiceImpl implements StorageService {
 
    @Resource
    private StorageMapper storageMapper;
 
    /**
     * 扣减库存
     */
    @Override
    public void decrease(Long productId, Integer count) {
        log.info("------->storage-service中扣减库存开始");
        storageMapper.decrease(productId,count);
        log.info("------->storage-service中扣减库存结束");
    }
}
```

Controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.serivce.StorageService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
 
 
@RestController
public class StorageController{
    @Resource
    private StorageService storageService;
 
    // 扣减库存；注意参数要与common模块中的方法一致
    @RequestMapping("/storage/decrease")
    // public ResultData decrease(Long productId, Integer count) {
    public ResultData decrease(@RequestParam("productId") Long productId,  @RequestParam("count") Integer count) {
 
        storageService.decrease(productId, count);
        return ResultData.success("扣减库存成功!");
    }
}
```

#### 13.7.6 新建账户Account微服务
##### 13.7.6.1 建Module
seata-account-service2003

##### 13.7.6.2 改POM
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
 
    <artifactId>seata-account-service2003</artifactId>
 
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
 
 
 
    <dependencies>
        <!-- nacos -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!--alibaba-seata-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-seata</artifactId>
        </dependency>
        <!--openfeign-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-openfeign</artifactId>
        </dependency>
        <!--loadbalancer-->
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-loadbalancer</artifactId>
        </dependency>
        <!--cloud_commons_utils-->
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

##### 13.7.6.3 写YML
```yml
server:
  port: 2003
 
spring:
  application:
    name: seata-account-service
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848         #Nacos服务注册中心地址
  # ==========applicationName + druid-mysql8 driver===================
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/seata_account?characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8&rewriteBatchedStatements=true&allowPublicKeyRetrieval=true
    username: root
    password: password
# ========================mybatis===================
mybatis:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.atguigu.cloud.entities
  configuration:
    map-underscore-to-camel-case: true
 
 
 
# ========================seata===================
seata:
  registry:
    type: nacos
    nacos:
      server-addr: 127.0.0.1:8848
      namespace: ""
      group: SEATA_GROUP
      application: seata-server
  tx-service-group: default_tx_group # 事务组，由它获得TC服务的集群名称
  service:
    vgroup-mapping:
      default_tx_group: default # 事务组与TC服务集群的映射关系
  data-source-proxy-mode: AT
 
logging:
  level:
    io:
      seata: info
```

##### 13.7.6.4 主启动
```java
package com.atguigu.cloud;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import tk.mybatis.spring.annotation.MapperScan;
 
@EnableDiscoveryClient
@EnableFeignClients
@MapperScan("com.atguigu.cloud.mapper") //import tk.mybatis.spring.annotation.MapperScan;
@SpringBootApplication
public class SeataAccountMainApp2003 {
    public static void main(String[] args){
        SpringApplication.run(SeataAccountMainApp2003.class,args);
    }
}
```

##### 13.7.6.5 业务类
entities

Account
```java
package com.atguigu.cloud.entities;
 
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
 
 
@Table(name = "t_account")
public class Account implements Serializable {
    /**
     * id
     */
    @Id
    @GeneratedValue(generator = "JDBC")
    private Long id;
 
    /**
     * 用户id
     */
    @Column(name = "user_id")
    private Long userId;
 
    /**
     * 总额度
     */
    private Long total;
 
    /**
     * 已用余额
     */
    private Long used;
 
    /**
     * 剩余可用额度
     */
    private Long residue;
 
    /**
     * 获取id
     *
     * @return id - id
     */
    public Long getId() {
        return id;
    }
 
    /**
     * 设置id
     *
     * @param id id
     */
    public void setId(Long id) {
        this.id = id;
    }
 
    /**
     * 获取用户id
     *
     * @return user_id - 用户id
     */
    public Long getUserId() {
        return userId;
    }
 
    /**
     * 设置用户id
     *
     * @param userId 用户id
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }
 
    /**
     * 获取总额度
     *
     * @return total - 总额度
     */
    public Long getTotal() {
        return total;
    }
 
    /**
     * 设置总额度
     *
     * @param total 总额度
     */
    public void setTotal(Long total) {
        this.total = total;
    }
 
    /**
     * 获取已用余额
     *
     * @return used - 已用余额
     */
    public Long getUsed() {
        return used;
    }
 
    /**
     * 设置已用余额
     *
     * @param used 已用余额
     */
    public void setUsed(Long used) {
        this.used = used;
    }
 
    /**
     * 获取剩余可用额度
     *
     * @return residue - 剩余可用额度
     */
    public Long getResidue() {
        return residue;
    }
 
    /**
     * 设置剩余可用额度
     *
     * @param residue 剩余可用额度
     */
    public void setResidue(Long residue) {
        this.residue = residue;
    }
 
    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", userId=" + userId +
                ", total=" + total +
                ", used=" + used +
                ", residue=" + residue +
                '}';
    }
}
```

AccountMapper
AccountMapper接口
```java
package com.atguigu.cloud.mapper;
 
import com.atguigu.cloud.entities.Account;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;
 
public interface AccountMapper extends Mapper<Account> {
 
    /**
     * @param userId
     * @param money 本次消费金额
     */
    void decrease(@Param("userId") Long userId, @Param("money") Long money);
}
```

resources文件夹下新建mapper文件夹后添加AccountMapper.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.atguigu.cloud.mapper.AccountMapper">
    <resultMap id="BaseResultMap" type="com.atguigu.cloud.entities.Account">
        <!--
          WARNING - @mbg.generated
        -->
        <id column="id" jdbcType="BIGINT" property="id" />
        <result column="user_id" jdbcType="BIGINT" property="userId" />
        <result column="total" jdbcType="DECIMAL" property="total" />
        <result column="used" jdbcType="DECIMAL" property="used" />
        <result column="residue" jdbcType="DECIMAL" property="residue" />
    </resultMap>
 
 
    <!--
        money   本次消费金额
        t_account数据库表
        total总额度 = 累计已消费金额(used) + 剩余可用额度(residue)
    -->
    <update id="decrease">
        UPDATE
            t_account
        SET
            residue = residue - #{money},used = used + #{money}
        WHERE user_id = #{userId};
    </update>
 
</mapper>
```

Service接口及实现
AccountService
```java
package com.atguigu.cloud.service;

import org.apache.ibatis.annotations.Param;
 
public interface AccountService {
 
    /**
     * 扣减账户余额
     * @param userId 用户id
     * @param money 本次消费金额
     */
    void decrease(@Param("userId") Long userId, @Param("money") Long money);
}
```

AccountServiceImpl
```java
package com.atguigu.cloud.service.impl;
 
import com.atguigu.cloud.mapper.AccountMapper;
import com.atguigu.cloud.service.AccountService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
 
import java.util.concurrent.TimeUnit;
 
@Service
@Slf4j
public class AccountServiceImpl implements AccountService{
    @Resource
    AccountMapper accountMapper;
 
    /**
     * 扣减账户余额
     */
    @Override
    public void decrease(Long userId, Long money) {
        log.info("------->account-service中扣减账户余额开始");
 
        accountMapper.decrease(userId,money);
 
        //myTimeOut();
        //int age = 10/0;
        log.info("------->account-service中扣减账户余额结束");
    }
 
    /**
     * 模拟超时异常，全局事务回滚
     */
    private static void myTimeOut(){
        try { TimeUnit.SECONDS.sleep(65); } catch (InterruptedException e) { e.printStackTrace(); }
    }
}
```

Controller
```java
package com.atguigu.cloud.controller;
 
import com.atguigu.cloud.resp.ResultData;
import com.atguigu.cloud.service.AccountService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class AccountController {
 
    @Resource
    AccountService accountService;
 
    // 扣减账户余额；注意参数要与common模块中的方法一致
    @RequestMapping("/account/decrease")
    public ResultData decrease(@RequestParam("userId") Long userId, @RequestParam("money") Long money){
        accountService.decrease(userId,money);
        return ResultData.success("扣减账户余额成功！");
    }
}
```

### 13.8 Seata案例实战-测试
#### 13.8.1 服务启动情况
启动Nacos
启动Seata
启动订单微服务2001
启动订单微服务2002
启动订单微服务2003

#### 13.8.2 数据库初始情况
SELECT *  FROM  `seata_order`.`t_order`
![image.png](./img/13/6d6315d53e124426a6b448b332dbf5b1.png)

SELECT * FROM `seata_storage`.`t_storage`
![image.png](./img/13/613b363abc0c44c885533bd2f5365298.png)

SELECT *  FROM  `seata_account`.`t_account`;
![image.png](./img/13/bf5cda2ae5424e828a046176f205a28e.png)

#### 13.8.3 正常下单
下订单→减库存→扣余额→改（订单）状态
此时我们没有在订单模块添加@GlobalTransactional

http://localhost:2001/order/create?userId=1&productId=1&count=10&money=100

1号用户花费100块钱买了10个1号产品
正常下单，第1次

故障现象
![image.png](./img/13/9c65ce95f23e4c768b020c7723b21c8f.png)
![image.png](./img/13/e1478c81d32d49cea3ad51c8823ffe95.png)

导致原因
springboot+springcloud版本太高导致和阿里巴巴Seata不兼容

解决方案
总体父工程，boot+cloud降低版本
```xml
<spring.boot.version>3.2.0 </spring.boot.version >
<spring.cloud.version>2023.0.0 </spring.cloud.version >
上面的配置暂时为本案例注释掉，版本降级一下。
讲解完后请恢复上述高版本保持前后配置一致， 请用下面的任一个版本替代上述
<spring.boot.version>3.0.9</spring.boot.version>
<spring.cloud.version>2022.0.2</spring.cloud.version>
<!-- 仅为了整合 openfeign + alibaba seata 的案例，降低版本处理下 -->
<spring.boot.version>3.1.7</spring.boot.version>
<spring.cloud.version>2022.0.4</spring.cloud.version>
```

![image.png](./img/13/ca03b0bba6c248cb943612a563c6fd02.png)

注意：并不需要降低版本号，报错是因为storage和account两个微服务的controller中的方法缺少@RequestParam参数，与自定义common模块中的方法不一致

正常下单，第2次，成功
![image.png](./img/13/0efbe4cb29124ecebc35f2f501833813.png)

数据库情况
![image.png](./img/13/236712efae774295aca8cc1c02b57dea.png)
![image.png](./img/13/4536fedbc886459d9c31b3d57c36704a.png)
![image.png](./img/13/a322602a61634b5889c4231c1499e5c2.png)
新增一个订单+2个扣减


#### 13.8.4 超时异常出错，没有@GlobalTransactional
修改seata-account-service2003微服务，AccountServiceImpl添加超时
```java
@Service
@Slf4j
public class AccountServiceImpl implements AccountService{
    @Resource
    AccountMapper accountMapper;
 
    /**
     * 扣减账户余额
     */
    @Override
    public void decrease(Long userId, Long money) {
        log.info("------->account-service中扣减账户余额开始");
 
        accountMapper.decrease(userId,money);
 
        myTimeOut();
        //int age = 10/0;
        log.info("------->account-service中扣减账户余额结束");
    }
 
    /**
     * 模拟超时异常，全局事务回滚
     */
    private static void myTimeOut(){
        try { TimeUnit.SECONDS.sleep(65); } catch (InterruptedException e) { e.printStackTrace(); }
    }
}
```

故障情况
当库存和账户金额扣减后，订单状态并没有设置为已经完成，没有从零改为1

数据库情况
![image.png](./img/13/650bc71fd00f4cf88dc406a975720a7b.png)
![image.png](./img/13/8248438225ae4af2a9f58c1b27aa66a5.png)
![image.png](./img/13/66c96caef7374048a4e9219c9f1d7d10.png)

#### 13.8.5 超时异常解决，添加@GlobalTransactional
AccountServiceImpl保留超时方法

OrderServiceImpl@GlobalTransactional
```java
@Override
@GlobalTransactional(name = "zzyy-create-order",rollbackFor = Exception.class) //AT
public void create(Order order){
 
    ......
 
}
```

此时，订单模块就是TM，也是其中一个RM
![image.png](./img/13/e64f0c7f5b4b488aa3828d286f3e8304.png)


查看Seata后台
http://localhost:7091/#/login

全局事务ID
![image.png](./img/13/0e6c7ff9f7c94340a0c98cf133592592.png)

全局锁
![image.png](./img/13/0891270a1b534362bd10b0fb8a6d0aaf.png)


下单后数据库3个库数据并没有任何改变，被回滚了
业务中...
![image.png](./img/13/1712dcb7625b4cd19946b7f03152de83.png)

按照正常逻辑，本该有新记录入库，等待最后完成提交。

回滚后
order记录都添加不进来
![image.png](./img/13/ddf4f6cfcdac48c8b85ed64348773399.png)

上一步准备新增的记录被彻底回滚了，保证的一致性。
全部回退

### 13.9 Seata原理小总结和面试题
AT模式如何做到对业务的无侵入

#### 13.9.1 概念
![image.png](./img/13/3594391136364873b91a422cc8405568.png)
![image.png](./img/13/a38ad7f4eece41cd8ffadf66b93ce190.png)

#### 13.9.2 一阶段加载
在一阶段，Seata 会拦截“业务 SQL”，
1  解析 SQL 语义，找到“业务 SQL”要更新的业务数据，在业务数据被更新前，将其保存成“before image”，
2  执行“业务 SQL”更新业务数据，在业务数据更新之后，
3  其保存成“after image”，最后生成行锁。
以上操作全部在一个数据库事务内完成，这样保证了一阶段操作的原子性。

![image.png](./img/13/d7ad72a2f6bd4406a590ff7733c68ca4.png)

#### 13.9.3 二阶段分2种情况
正常提交
二阶段如是顺利提交的话，
因为“业务 SQL”在一阶段已经提交至数据库，所以Seata框架只需将**一阶段保存的快照数据和行锁删掉，完成数据清理即可**。
![image.png](./img/13/ae788a48771c48838d4bfe9655c96daf.png)

异常回滚
二阶段回滚：
**二阶段如果是回滚的话，Seata 就需要回滚一阶段已经执行的“业务 SQL”，还原业务数据。**

回滚方式便是用“before image”还原业务数据；但在还原前要首先要校验脏写，对比“数据库当前业务数据”和 “after image”，

如果两份数据完全一致就说明没有脏写，可以还原业务数据，**如果不一致就说明有脏写，出现脏写就需要转人工处理**。

![image.png](./img/13/dd4abf75141e40b6ba12fddee26b026c.png)
































