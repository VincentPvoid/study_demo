# RabbitMQ



## 安装
```shell
# 拉取镜像；注意版本，如果不是management版本，后面需要自行开启后台管理界面
docker pull rabbitmq:4.0.5

# 如果拉取如下版本，则会默认开启后台管理界面
docker pull rabbitmq:4.0.5-management

# -d 参数：后台运行 Docker 容器
# --name 参数：设置容器名称
# -p 参数：映射端口号，格式是“宿主机端口号:容器内端口号”。5672供客户端程序访问，15672供后台管理界面访问
# -v 参数：卷映射目录
# -e 参数：设置容器内的环境变量，这里我们设置了登录RabbitMQ管理后台的默认用户和密码
docker run -d \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
-v rabbitmq-plugin:/usr/temp/rabbitmq/plugins \
-e RABBITMQ_DEFAULT_USER=admin \
-e RABBITMQ_DEFAULT_PASS=password \
rabbitmq:4.0.5
```

如果无法访问后台界面（非management版本）
需要进入对应rabbitmq开启后台管理功能
```shell
docker exec -it 镜像ID /bin/bash
rabbitmq-plugins enable rabbitmq_management
```

如果后台Queues and Streams界面无法显示图表
1 进入rabbitmq对应容器
`docker exec -it b377275f6a59 /bin/bash`

2 进入conf.d配置中
`cd /etc/rabbitmq/conf.d/`

3 修改management_agent.disable_metrics_collector.conf 中 management_agent.disable_metrics_collector 的值为false
```shell
echo management_agent.disable_metrics_collector = false > management_agent.disable_metrics_collector.conf 
```

4 退出对应容器
`exit`

5 重启对应容器
`docker restart b377275f6a59`





## 延迟插件使用

### 插件安装
确定rabbitmq映射目录
`docker inspect rabbitmq`

查看其中 Mounts 数组第一项中 Source 的值
```json
"Mounts": [
  {
    "Type": "volume",
    "Name": "rabbitmq-plugin",
    "Source": "/var/lib/docker/volumes/rabbitmq-plugin/_data",
    "Destination": "/usr/temp/rabbitmq/plugins",
    "Driver": "local",
    "Mode": "z",
    "RW": true,
    "Propagation": ""
  },
  {
    "Type": "volume",
    "Name": "b46f3ac49be41ea62489dc46ca97088e215ba794b05a31a6520e37e3470956f6",
    "Source": "/var/lib/docker/volumes/ b46f3ac49be41ea62489dc46ca97088e215ba794b05a31a6520e37e3470956f6/_data",
  "Destination": "/var/lib/rabbitmq",
    "Driver": "local",
    "Mode": "",
    "RW": true,
    "Propagation": ""
  }
],  
```
和容器内/plugins目录对应的宿主机目录是：/var/lib/docker/volumes/rabbitmq-plugin/_data

把延迟插件 rabbitmq_delayed_message_exchange-4.0.2.ez 
放入对应的文件夹中 /var/lib/docker/volumes/rabbitmq-plugin/_data


### 启用插件

```shell
# 进入容器内部
docker exec -it rabbitmq /bin/bash

# rabbitmq-plugins命令所在目录已经配置到$PATH环境变量中了，可以直接调用
rabbitmq-plugins enable rabbitmq_delayed_message_exchange

# 退出Docker容器
exit

# 重启Docker容器
docker restart rabbitmq
```




## 集群搭建

### 安装RabbitMQ
RabbitMQ安装方式官方指南：
https://www.rabbitmq.com/docs/install-debian

#### 安装Erlang环境
描述 RabbitMQ 和 Erlang 包存储库的文件放在
`/etc/apt/sources.list.d/` 下

推荐写在
`/etc/apt/sources.list.d/rabbitmq.list` 中

##### ①创建yum库配置文件
```shell
vim /etc/apt/sources.list.d/rabbitmq.list
```

##### ②加入配置内容
以下内容来自官方文档
```shell
# This Launchpad PPA repository provides Erlang packages produced by the RabbitMQ team
#
# Replace $distribution with the name of the Ubuntu release used
deb [arch=amd64 signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu jammy main
deb-src [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu jammy main
```

##### ③更新apt库
```shell
sudo apt-get update -y
```

##### ④正式安装Erlang
```shell
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
```



### 安装RabbitMQ
`sudo apt-get install rabbitmq-server -y --fix-missing`



### RabbitMQ基础配置

```shell
# 启用管理界面插件
rabbitmq-plugins enable rabbitmq_management

# 启动 RabbitMQ 服务：
systemctl start rabbitmq-server

# 将 RabbitMQ 服务设置为开机自动启动
systemctl enable rabbitmq-server

# 新增登录账号密码
rabbitmqctl add_user admin password

# 设置登录账号权限
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

# 配置所有稳定功能 flag 启用
rabbitmqctl enable_feature_flag all

# 重启RabbitMQ服务生效
systemctl restart rabbitmq-server
```


### 访问管理界面
`http://ip:15672`

集群其他机器也同样安装
实际直接执行 
`sudo apt-get update -y`
`sudo apt-get install rabbitmq-server -y --fix-missing` 
也能成功安装RabbitMQ




### 配置集群

#### ①设置 IP 地址到主机名称的映射
修改文件/etc/hosts，为集群中的机器配置ip地址和名称的映射
```text
192.168.255.123 master0
192.168.255.124 node1-124
192.168.255.125 node2-125
```

#### ②查看当前RabbitMQ节点的Cookie值并记录
RabbitMQ要求集群中的节点使用同一个cookie值
```shell
[root@node01 ~]# cat /var/lib/rabbitmq/.erlang.cookie 
NOTUPTIZIJONXDWWQPOJ
```


#### ③重启节点应用
```shell
rabbitmqctl stop_app
# rabbitmqctl reset
rabbitmqctl start_app
```

查看集群状态
`rabbitmqctl cluster_status`



#### 其他节点设置
修改hosts，把cookie设置为前面获取到的cookie值
`vim /var/lib/rabbitmq/.erlang.cookie`

重启节点应用时，需要添加加入集群的命令
```shell
rabbitmqctl stop_app
# rabbitmqctl reset
rabbitmqctl join_cluster rabbit@master0
rabbitmqctl start_app
```

##### 问题
修改cookie后，rabbitmq启动后的默认名称可能与hosts中设置的不一致，会无法停止本机运行的app，也无法加入集群
默认名称为rabbit@master0、rabbit@node1...

要使用hosts中自定义的名称，需要修改rabbitmq设置
`vim /etc/rabbitmq/rabbitmq-env.conf`

修改对应的NODENAME为自定义名称
```shell
NODENAME=rabbit@hosts中的自定义主机名称

NODENAME=rabbit@node1-124
NODENAME=rabbit@node2-125
```

修改配置后重启rabbitmq服务
`systemctl restart rabbitmq-server`

之后再进行重启和加入集群操作



### 清除节点
如有需要踢出某个节点，则按下面操作执行：
```shell
# 被踢出的节点：
rabbitmqctl stop_app
# rabbitmqctl reset
rabbitmqctl start_app

# 节点2
rabbitmqctl forget_cluster_node rabbit@node2-125
```








## 负载均衡：Management UI
先给管理界面做负载均衡，然后方便我们在管理界面上创建交换机、队列等操作

### 安装HAProxy
```shell
# 安装HAProxy
apt-get install -y haproxy

# 查看HAProxy版本
haproxy -v

# 启动HAProxy
systemctl start haproxy

# 设置HAProxy开机启动
systemctl enable haproxy
```


### 修改配置文件
`vim /etc/haproxy/haproxy.cfg`

在配置文件末尾增加如下内容：
```shell
# 前端配置；外部访问地址、端口、协议、要转发到到的后端地址
frontend rabbitmq_ui_frontend
bind 192.168.255.123:22222
mode http
default_backend rabbitmq_ui_backend

# 转发到的后端配置；地址、端口、协议、轮询负载均衡
backend rabbitmq_ui_backend
mode http
balance roundrobin
option httpchk GET /
server rabbitmq_ui1 192.168.255.123:15672 check
server rabbitmq_ui2 192.168.255.124:15672 check
server rabbitmq_ui3 192.168.255.125:15672 check
```


设置SELinux策略，允许HAProxy拥有权限连接任意端口：
```shell
setsebool -P haproxy_connect_any=1
```

> SELinux是Linux系统中的安全模块，它可以限制进程的权限以提高系统的安全性。在某些情况下，SELinux可能会阻止HAProxy绑定指定的端口，这就需要通过设置域（domain）的安全策略来解决此问题。
>
> 通过执行`setsebool -P haproxy_connect_any=1`命令，您已经为HAProxy设置了一个布尔值，允许HAProxy连接到任意端口。这样，HAProxy就可以成功绑定指定的socket，并正常工作。
>


重启HAProxy：
```shell
systemctl restart haproxy
```



## 负载均衡：核心功能
修改配置文件
`vim /etc/haproxy/haproxy.cfg`

增加配置
```shell
frontend rabbitmq_frontend
bind 192.168.255.123:11111
mode tcp
default_backend rabbitmq_backend

backend rabbitmq_backend
mode tcp
balance roundrobin
server rabbitmq1 192.168.255.123:5672 check
server rabbitmq2 192.168.255.124:5672 check
server rabbitmq3 192.168.255.125:5672 check
```


重启HAProxy服务：

```shell
systemctl restart haproxy
```



### 测试
#### 生产者端 rabbitmq_08_cluster_puoducer
##### ①创建组件
- 交换机：exchange.cluster.test
默认配置direct等，不需要修改
- 队列：queue.cluster.test
- 路由键：routing.key.cluster.test


##### [1]配置POM
```xml
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>3.3.5</version>
  <relativePath/> <!-- lookup parent from repository -->
</parent>

<dependencies>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
  </dependency>
  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
  </dependency>
</dependencies>
```

##### [2]主启动类
```java
package com.rabbitmqtp.mq;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RabbitMQClusterProducer {
  public static void main(String[] args) {
    SpringApplication.run(RabbitMQClusterProducer.class, args);
  }
}
```


##### [3]配置YAML
```yaml
spring:
  rabbitmq:
    host: 192.168.255.123
    port: 11111
    username: admin
    password: password
    virtual-host: /
    publisher-confirm-type: CORRELATED # 交换机的确认
    publisher-returns: true # 队列的确认
logging:
  level:
    com.rabbitmqtp.mq.config.MQProducerAckConfig: info
```


##### [4]配置类
```java
package com.rabbitmqtp.mq.config;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.ReturnedMessage;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class MQProducerAckConfig implements RabbitTemplate.ConfirmCallback, RabbitTemplate.ReturnsCallback {
  @Resource
  RabbitTemplate rabbitTemplate;

  @PostConstruct
  public void init() {
    rabbitTemplate.setConfirmCallback(this);
    rabbitTemplate.setReturnsCallback(this);
  }

  // 消息发送到交换机，成功/失败都会调用此方法
  @Override
  public void confirm(CorrelationData correlationData, boolean ack, String cause) {
    if(ack){
      log.info("消息发送到交换机成功 数据：" + correlationData);
    }else{
      log.info("消息发送到交换机失败 数据：" + correlationData + " 原因：" + cause);
    }
  }

  @Override
  public void returnedMessage(ReturnedMessage returnedMessage) {
    log.info("消息主体: " + new String(returnedMessage.getMessage().getBody()));
    log.info("应答码: " + returnedMessage.getReplyCode());
    log.info("描述：" + returnedMessage.getReplyText());
    log.info("消息使用的交换器 exchange : " + returnedMessage.getExchange());
    log.info("消息使用的路由键 routing : " + returnedMessage.getRoutingKey());
  }
}
```

##### [5] Junit测试类
```java
package com.rabbitmqtp.mq;

import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class RabbitMQTest {

  public static final String EXCHANGE_NAME = "exchange.cluster.test";
  public static final String ROUTING_KEY = "routing.key.cluster.test";

  @Resource
  RabbitTemplate rabbitTemplate;

  @Test
  public void testSendMsg() {
    rabbitTemplate.convertAndSend(EXCHANGE_NAME, ROUTING_KEY, "Cluster message test --------");
  }
}
```

#### 消费者端 rabbitmq_09_cluster_consumer
##### [1]配置POM
```xml
<parent>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-parent</artifactId>
  <version>3.3.5</version>
  <relativePath/> <!-- lookup parent from repository -->
</parent>

<dependencies>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
  </dependency>
  <dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
  </dependency>
</dependencies>
```

##### [2]主启动类
```java
package com.rabbitmqtp.mq;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RabbitMQClusterConsumer {
  public static void main(String[] args) {
    SpringApplication.run(RabbitMQClusterProducer.class, args);
  }
}
```


##### [3]配置YAML
```yaml
spring:
  rabbitmq:
    host: 192.168.255.123
    port: 11111
    username: admin
    password: password
    virtual-host: /
    listener:
      simple:
        acknowledge-mode: manual
logging:
  level:
    com.rabbitmqtp.mq.listener.CusListener: info
```

##### [4]监听器
```java
package com.rabbitmqtp.mq.listener;

import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

import java.io.IOException;


@Component
@Slf4j
public class CusListener {
  public static final String QUEUE_NAME = "queue.cluster.test";

  @RabbitListener(queues = {QUEUE_NAME})
  public  void processNormalQueueMessage(String dataString, Message message, Channel channel) throws IOException {
    log.info("消费端：" + dataString);
    channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
  }
  
}

```



## Quorum Queue 仲裁队列
### 准备
#### 1、创建交换机
和仲裁队列绑定的交换机没有特殊，创建一个普通direct交换机即可
交换机名称：exchange.quorum.test

#### 2、创建仲裁队列
队列名称：queue.quorum.test

#### 3、绑定交换机
路由键：routing.key.quorum.test


### 测试
像使用经典队列一样发送消息、消费消息

#### ①生产者端
```java
// 仲裁队列测试
public static final String EXCHANGE_QUORUM_NAME = "exchange.quorum.test";
public static final String ROUTING_QUORUM_KEY = "routing.key.quorum.test";

@Test
public void testSendMsgQuorum() {
  rabbitTemplate.convertAndSend(EXCHANGE_QUORUM_NAME, ROUTING_QUORUM_KEY, "Quorum queue message test --------");
}
```

#### ②消费者端
```java
// 仲裁队列测试
public static final String QUEUE_QUORUM_NAME = "queue.quorum.test";

@RabbitListener(queues = {QUEUE_QUORUM_NAME})
public void processQuorumQueueMessage(String dataString, Message message, Channel channel) throws IOException {
  log.info("Quorum测试，消费端：" + dataString);
  channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
}
```

### 高可用测试

#### ①停止某个节点的rabbit应用
```shell
# 停止rabbit应用
rabbitmqctl stop_app
```

#### ②查看仲裁队列对应的节点情况

#### ③再次发送消息
收发消息仍然正常





## Stream Queue 流式队列
只有启用了Stream插件，才能使用流式队列的完整功能

### 准备

#### 启用插件
在集群每个节点中依次执行如下操作：
```shell
# 启用Stream插件
rabbitmq-plugins enable rabbitmq_stream

# 重启rabbit应用
rabbitmqctl stop_app
rabbitmqctl start_app

# 查看插件状态
rabbitmq-plugins list
```

#### 负载均衡
在文件`/etc/haproxy/haproxy.cfg`末尾追加：

```shell
frontend rabbitmq_stream_frontend
bind 192.168.255.123:33333
mode tcp
default_backend rabbitmq_stream_backend

backend rabbitmq_stream_backend
mode tcp
balance roundrobin
server rabbitmq1 192.168.255.123:5552 check
server rabbitmq2 192.168.255.124:5552 check
server rabbitmq3 192.168.255.125:5552 check
```



### 测试
Stream 专属 Java 客户端官方网址：https://github.com/rabbitmq/rabbitmq-stream-java-client
Stream 专属 Java 客户端官方文档网址：https://rabbitmq.github.io/rabbitmq-stream-java-client/stable/htmlsingle/


```xml
<dependencies>
  <!-- https://mvnrepository.com/artifact/com.rabbitmq/stream-client -->
  <dependency>
    <groupId>com.rabbitmq</groupId>
    <artifactId>stream-client</artifactId>
    <version>0.18.0</version>
  </dependency>

  <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>2.0.16</version>
  </dependency>

  <!-- https://mvnrepository.com/artifact/ch.qos.logback/logback-classic -->
  <dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.5.15</version>
    <scope>test</scope>
  </dependency>
</dependencies>
```

#### 创建Stream
不需要创建交换机
队列名称：stream.queue.test

也可以使用代码方式创建
```java
Environment environment = Environment.builder()
        .host("192.168.255.123")
        .port(33333)
        .username("admin")
        .password("password")
        .build();

environment.streamCreator().stream("stream.queue.test").create();

environment.close();
```


#### 生产者端程序
> Internally, the `Environment` will query the broker to find out about the topology of the stream and will create or re-use a connection to publish to the leader node of the stream.

翻译：  
在内部，Environment将查询broker以了解流的拓扑结构，并将创建或重用连接以发布到流的 leader 节点。

解析  
- 在 Environment 中封装的连接信息仅负责连接到 broker
- Producer 在构建对象时会访问 broker 拉取集群中 Leader 的连接信息
- 将来实际访问的是集群中的 Leader 节点
- Leader 的连接信息格式是：节点名称:端口号

配置  
为了让本机的应用程序知道 Leader 节点名称对应的 IP 地址，我们需要在本地配置 hosts 文件，建立从节点名称到 IP 地址的映射关系


#### 代码
生产者端
```java
Environment environment = Environment.builder()
        .host("192.168.255.123")
        .port(33333)
        .username("admin")
        .password("password")
        .build();

Producer producer = environment.producerBuilder()
        .stream("stream.queue.test")
        .build();

byte[] messagePayload = "hello rabbit stream".getBytes(StandardCharsets.UTF_8);

CountDownLatch countDownLatch = new CountDownLatch(1);

producer.send(
        producer.messageBuilder().addData(messagePayload).build(),
        confirmationStatus -> {
            if (confirmationStatus.isConfirmed()) {
                System.out.println("[生产者端]the message made it to the broker");
            } else {
                System.out.println("[生产者端]the message did not make it to the broker");
            }

            countDownLatch.countDown();
        });

countDownLatch.await();

producer.close();

environment.close();
```


### 指定Offset消费
消费者端
```java
Environment environment = Environment.builder()
        .host("192.168.255.123")
        .port(33333)
        .username("admin")
        .password("password")
        .build();

CountDownLatch countDownLatch = new CountDownLatch(1);

Consumer consumer = environment.consumerBuilder()
        .stream("stream.queue.test")
        .offset(OffsetSpecification.first())
        .messageHandler((offset, message) -> {
            byte[] bodyAsBinary = message.getBodyAsBinary();
            String messageContent = new String(bodyAsBinary);
            System.out.println("[消费者端]messageContent = " + messageContent);
            countDownLatch.countDown();
        })
        .build();

countDownLatch.await();

consumer.close();
```


### 对比
- autoTrackingStrategy 方式：始终监听Stream中的新消息（狗狗看家，忠于职守）
- 指定偏移量方式：针对指定偏移量的消息消费之后就停止（狗狗叼飞盘，叼回来就完）

















## 附：使用命令
```shell
docker pull rabbitmq:4.0.5

docker run -d \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
-v rabbitmq-plugin:/usr/temp/rabbitmq/plugins \
-e RABBITMQ_DEFAULT_USER=admin \
-e RABBITMQ_DEFAULT_PASS=password \
rabbitmq:4.0.5



docker exec -it b377275f6a59 /bin/bash
rabbitmq-plugins enable rabbitmq_management

cd /etc/rabbitmq/conf.d/

echo management_agent.disable_metrics_collector = false > management_agent.disable_metrics_collector.conf 




docker restart b377275f6a59
```












