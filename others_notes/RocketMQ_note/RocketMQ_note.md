# RocketQM note



## 单机安装与启动

### 1 准备
软硬件需求
系统要求为64位的，JDK需要为1.8及其以上版本
如果linux系统中没有JDK，需要自行下载安装

下载RocketMQ安装包
https://rocketmq.apache.org/zh/docs/quickStart/01quickstart


将下载的安装包上传到Linux


解压到指定目录
`unzip rocketmq-all-5.3.1-bin-release.zip -d /opt/module/`

进入/opt/module，重命名文件夹
`mv rocketmq-all-5.3.1-bin-release/ rocketmq-5.3.1`


### 2 修改配置
修改初始内存

打开bin/runserver.sh文件
`vim bin/runserver.sh`

修改值
```shell
# 默认值
# JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -Xmn2g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"
# JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"1

# 改为以下值
JAVA_OPT="${JAVA_OPT} -server -Xms256m -Xmx256m -Xmn128m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"
JAVA_OPT="${JAVA_OPT} -server -Xms256m -Xmx256m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m"
```


修改runbroker.sh
`vim bin/runbroker.sh`

修改值
```shell
# 默认值
# JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g"

# 改为以下值
JAVA_OPT="${JAVA_OPT} -server -Xms256m -Xmx256m"
```


### 3 启动
在rocketmq-5.3.1文件目录下

启动NameServer
```shell
### 启动namesrv
nohup sh bin/mqnamesrv &
 
### 验证namesrv是否启动成功
tail -f ~/logs/rocketmqlogs/namesrv.log
```

启动broker
```shell
### 启动broker
nohup sh bin/mqbroker -n localhost:9876 &
 
### 验证broker是否启动成功
tail -f ~/logs/rocketmqlogs/broker.log
```


### 4 发送/接收消息测试
发送消息
```shell
export NAMESRV_ADDR=localhost:9876
sh bin/tools.sh org.apache.rocketmq.example.quickstart.Producer
```

接收消息
```shell
sh bin/tools.sh org.apache.rocketmq.example.quickstart.Consumer
```


### 5 关闭Server
无论是关闭NameServer还是broker，都是使用bin/mqshutdown命令
先关broker，再关闭NameServer
```shell
# 关闭broker
sh bin/mqshutdown broker

# 关闭NameServer
sh bin/mqshutdown namesrv
```





## 控制台安装与启动
RocketMQ有一个可视化的dashboard，通过该控制台可以直观的查看到很多数据
注意该项目是在宿主机下运行，非虚拟机

### 1 下载
相关项目地址：https://github.com/apache/rocketmq-externals/releases

旧版名称为RocketMQ Console，新版改名为RocketMQ Dashboard
下载地址 https://github.com/apache/rocketmq-dashboard/releases

下载后解压缩到对应文件夹，此处以rocketmq-dashboard-rocketmq-dashboard-2.0.0为例

### 2 修改配置
进入rocketmq-dashboard-rocketmq-dashboard-2.0.0文件夹
修改其src/main/resources中的application.yml配置文件（旧版为application.properties）
- 默认端口号为8080，修改为其他不常用端口号
- 指定RocketMQ的NameServer地址和端口号


### 3 添加依赖
在解压目录rocketmq-console的pom.xml中添加如下JAXB依赖。
>JAXB，Java Architechture for Xml Binding，用于XML绑定的Java技术，是一个业界标准，是一
项可以根据XML Schema生成Java类的技术

```xml
<dependency>
  <groupId>javax.xml.bind</groupId>
  <artifactId>jaxb-api</artifactId>
  <version>2.3.0</version>
</dependency>
<dependency>
  <groupId>com.sun.xml.bind</groupId>
  <artifactId>jaxb-impl</artifactId>
  <version>2.3.0</version>
</dependency>
<dependency>
  <groupId>com.sun.xml.bind</groupId>
  <artifactId>jaxb-core</artifactId>
  <version>2.3.0</version>
</dependency>
<dependency>
  <groupId>javax.activation</groupId>
  <artifactId>activation</artifactId>
  <version>1.1.1</version>
</dependency>
```


### 4 打包
在rocketmq-dashboard-rocketmq-dashboard-2.0.0目录下运行maven的打包命令（跳过测试）
`mvn clean package -Dmaven.test.skip=true`


### 5 启动
`java -jar rocketmq-dashboard-2.0.0.jar`


### 6 访问
地址 http://localhost:5566/





## 集群搭建

### 1 集群架构
这里要搭建一个双主双从异步复制的Broker集群
| 主机名 | ip | 功能 |  broker角色 |
| ------ | -- | ----| ----------- |
| rocketmq1 | 192.168.255.131 | NameServer + Broker | Master1 + Slave2 |
| rocketmq2 | 192.168.255.132 | NameServer + Broker | Master2 + Slave1 |

### 2 准备
克隆rocketmq1
把克隆后的新虚拟机名称修改为rocketmq2，并修改其对应ip地址

### 3 修改rocketmq1配置文件
要修改的配置文件在rocketMQ解压目录的conf/2m-2s-async目录中

修改broker-a.properties（此文件为主broker1设置）
```shell
# 指定整个broker集群的名称，或者说是RocketMQ集群的名称
brokerClusterName=DefaultCluster
# 指定master-slave集群的名称。一个RocketMQ集群可以包含多个master-slave集群
brokerName=broker-a
# master的brokerId为0；slave为非0
brokerId=0
# 指定删除消息存储过期文件的时间为凌晨4点
deleteWhen=04
# 指定未发生更新的消息存储文件的保留时长为48小时，48小时后过期，将会被删除
fileReservedTime=48
# 指定当前broker为异步复制master
brokerRole=ASYNC_MASTER
# 指定刷盘策略为异步刷盘
flushDiskType=ASYNC_FLUSH
# 指定Name Server的地址
namesrvAddr=192.168.255.131:9876;192.168.255.132:9876
```

修改broker-b-s.properties （此文件为从broker2设置）
```shell
brokerClusterName=DefaultCluster
# 指定这是另外一个master-slave集群
brokerName=broker-b
# slave的brokerId为非0
brokerId=1
deleteWhen=04
fileReservedTime=48
# 指定当前broker为slave
brokerRole=SLAVE
flushDiskType=ASYNC_FLUSH
namesrvAddr=192.168.255.131:9876;192.168.255.132:9876
# 指定Broker对外提供服务的端口，即Broker与producer与consumer通信的端口。默认10911。由于当前主机同时充当着master1与slave2，而前面的master1使用的是默认端口。这里需要将这两个端口加以区分，以区分出master1与slave2
listenPort=11911
# 指定消息存储相关的路径。默认路径为~/store目录。由于当前主机同时充当着master1与slave2，master1使用的是默认路径，这里就需要再指定一个不同路径
storePathRootDir=~/store-s
storePathCommitLog=~/store-s/commitlog
storePathConsumeQueue=~/store-s/consumequeue
storePathIndex=~/store-s/index
storeCheckpoint=~/store-s/checkpoint
abortFile=~/store-s/abort
```

其它配置
除了以上配置外，这些配置文件中还可以设置其它属性
```shell
#指定整个broker集群的名称，或者说是RocketMQ集群的名称
brokerClusterName=rocket-MS
#指定master-slave集群的名称。一个RocketMQ集群可以包含多个master-slave集群
brokerName=broker-a
#0 表示 Master，>0 表示 Slave
brokerId=0
#nameServer地址，分号分割
namesrvAddr=nameserver1:9876;nameserver2:9876
#默认为新建Topic所创建的队列数
defaultTopicQueueNums=4
#是否允许 Broker 自动创建Topic，建议生产环境中关闭
autoCreateTopicEnable=true
#是否允许 Broker 自动创建订阅组，建议生产环境中关闭
autoCreateSubscriptionGroup=true
#Broker对外提供服务的端口，即Broker与producer与consumer通信的端口
listenPort=10911
#HA高可用监听端口，即Master与Slave间通信的端口，默认值为listenPort+1
haListenPort=10912
#指定删除消息存储过期文件的时间为凌晨4点
deleteWhen=04
#指定未发生更新的消息存储文件的保留时长为48小时，48小时后过期，将会被删除
fileReservedTime=48
#指定commitLog目录中每个文件的大小，默认1G
mapedFileSizeCommitLog=1073741824
#指定ConsumeQueue的每个Topic的每个Queue文件中可以存放的消息数量，默认30w条
mapedFileSizeConsumeQueue=300000
#在清除过期文件时，如果该文件被其他线程所占用（引用数大于0，比如读取消息），此时会阻止此次删除任务，同时在第一次试图删除该文件时记录当前时间戳。该属性则表示从第一次拒绝删除后开始计时，该文件最多可以保留的时长。在此时间内若引用数仍不为0，则删除仍会被拒绝。不过时间到后，文件将被强制删除
destroyMapedFileIntervalForcibly=120000
#指定commitlog、consumequeue所在磁盘分区的最大使用率，超过该值，则需立即清除过期文件
diskMaxUsedSpaceRatio=88
#指定store目录的路径，默认在当前用户主目录中
storePathRootDir=/usr/local/rocketmq-all-4.5.0/store
#commitLog目录路径
storePathCommitLog=/usr/local/rocketmq-all-4.5.0/store/commitlog
#consumeueue目录路径
storePathConsumeQueue=/usr/local/rocketmq-all-4.5.0/store/consumequeue
#index目录路径
storePathIndex=/usr/local/rocketmq-all-4.5.0/store/index
#checkpoint文件路径
storeCheckpoint=/usr/local/rocketmq-all-4.5.0/store/checkpoint
#abort文件路径
abortFile=/usr/local/rocketmq-all-4.5.0/store/abort
#指定消息的最大大小
maxMessageSize=65536
#Broker的角色
# - ASYNC_MASTER 异步复制Master
# - SYNC_MASTER 同步双写Master
# - SLAVE
brokerRole=SYNC_MASTER
#刷盘策略
# - ASYNC_FLUSH 异步刷盘
# - SYNC_FLUSH 同步刷盘
flushDiskType=SYNC_FLUSH
#发消息线程池数量
sendMessageThreadPoolNums=128
#拉消息线程池数量
pullMessageThreadPoolNums=128
#强制指定本机IP，需要根据每台机器进行修改。官方介绍可为空，系统默认自动识别，但多网卡时IP地址可能读取错误
brokerIP1=192.168.3.105
```


### 4 修改rocketmq2配置文件
对于rocketmq2主机，同样需要修改rocketMQ解压目录的conf目录的子目录2m-2s-async中的两个配置文件。
修改broker-b.properties（此文件为主broker2设置）
```shell
brokerClusterName=DefaultCluster
brokerName=broker-b
brokerId=0
deleteWhen=04
fileReservedTime=48
brokerRole=ASYNC_MASTER
flushDiskType=ASYNC_FLUSH
namesrvAddr=192.168.255.131:9876;192.168.255.132:9876
```

修改broker-a-s.properties（此文件为从broker1设置）
```shell
brokerClusterName=DefaultCluster
brokerName=broker-a
brokerId=1
deleteWhen=04
fileReservedTime=48
brokerRole=SLAVE
flushDiskType=ASYNC_FLUSH
namesrvAddr=192.168.255.131:9876;192.168.255.132:9876
listenPort=11911
storePathRootDir=~/store-s
storePathCommitLog=~/store-s/commitlog
storePathConsumeQueue=~/store-s/consumequeue
storePathIndex=~/store-s/index
storeCheckpoint=~/store-s/checkpoint
abortFile=~/store-s/abort
```


### 5 启动服务器

#### 启动NameServer集群
分别启动rocketmq1与rocketmq2两个主机中的NameServer。启动命令完全相同。
```shell
nohup sh bin/mqnamesrv &

tail -f ~/logs/rocketmqlogs/namesrv.log
```

#### 启动两个Master
分别启动rocketmq1与rocketmq2两个主机中的broker master。注意，它们指定所要加载的配置文件是不同的

rocketmq1
```shell
nohup sh bin/mqbroker -c conf/2m-2s-async/broker-a.properties &

tail -f ~/logs/rocketmqlogs/broker.log
```

rocketmq2
```shell
nohup sh bin/mqbroker -c conf/2m-2s-async/broker-b.properties &

tail -f ~/logs/rocketmqlogs/broker.log
```

#### 启动两个Slave
分别启动rocketmqOS1与rocketmqOS2两个主机中的broker slave。注意，它们指定所要加载的配置文件是不同的。

rocketmq1
```shell
nohup sh bin/mqbroker -c conf/2m-2s-async/broker-b-s.properties &

tail -f ~/logs/rocketmqlogs/broker.log
```

rocketmq2
```shell
nohup sh bin/mqbroker -c conf/2m-2s-async/broker-a-s.properties &

tail -f ~/logs/rocketmqlogs/broker.log
```

#### 查看状态
在集群中任意一台虚拟机输入以下命令，查看当前java进程的状态
`jps`






## RocketMQ应用
主要为代码记录

Consumer在集群消费模式下offset相关数据以json的形式持久化到Broker磁盘文件中，文件路径为当前用户主目录下的 store/config/consumerOffset.json
可访问虚拟机对应目录查看topic等数据

注意使用时要先开启虚拟机中的nameServer和broker服务

### 普通消息
创建一个Maven的Java工程rocketmq-test

导入rocketmq的client依赖；注意rocketmq-client版本要与rocketmq使用的版本一致
```xml
<dependencies>
  <dependency>
    <groupId>org.apache.rocketmq</groupId>
    <artifactId>rocketmq-client</artifactId>
    <version>5.3.1</version>
  </dependency>
</dependencies>
```

消息发送状态说明
```java
// 消息发送的状态
public enum SendStatus {
  SEND_OK, // 发送成功
  FLUSH_DISK_TIMEOUT, // 刷盘超时。当Broker设置的刷盘策略为同步刷盘时才可能出现这种异常状态。异步刷盘不会出现
  FLUSH_SLAVE_TIMEOUT, // Slave同步超时。当Broker集群设置的Master-Slave的复制方式为同步复制时才可能出现这种异常状态。异步复制不会出现
  SLAVE_NOT_AVAILABLE, // 没有可用的Slave。当Broker集群设置为Master-Slave的复制方式为同步复制时才可能出现这种异常状态。异步复制不会出现
}
```

#### 同步发送消息
定义同步消息发送生产者 SyncProducer
```java
public class SyncProducer {
  public static void main(String[] args) throws Exception {
    // 创建一个producer，参数为Producer Group名称
    DefaultMQProducer producer = new DefaultMQProducer("pg");

    // nameServer地址
    producer.setNamesrvAddr("192.168.255.131:9876");

    // 设置当发送失败时重试发送的次数，默认为2次
    producer.setRetryTimesWhenSendFailed(3);

    // 设置发送超时时限为5s，默认3s
    producer.setSendMsgTimeout(5000);

    producer.start();

    for(int i = 0; i< 100 ; i++) {
      byte[] body = ("Test " + i).getBytes();
      Message msg = new Message("syncTopic", "syncTag", body);
      // 指定消息key
      msg.setKeys("key-" + i);

      SendResult sendResult = producer.send(msg);
      System.out.println(sendResult);
    }

    // 发送完成后关闭生产者
    producer.shutdown();
  }
}
```

#### 异步发送消息
定义异步消息发送生产者AsyncProducer
```java
public class AsyncProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");

    producer.setNamesrvAddr("192.168.255.131:9876");

    // 指定异步发送失败后不进行重试发送
    producer.setRetryTimesWhenSendAsyncFailed(0);
    // 指定新创建的Topic的Queue数量为2，默认为4
    producer.setDefaultTopicQueueNums(2);


    producer.start();

    for(int i = 0; i< 100 ; i++) {
      byte[] body = ("Test " + i).getBytes();

      Message msg = new Message("asyncTopic", "asyncTag", body);

      producer.send(msg, new SendCallback() {
        // 当producer接收到MQ发送来的ACK后就会触发该回调方法的执行
        @Override
        public void onSuccess(SendResult sendResult) {
          System.out.println(sendResult);
        }

        @Override
        public void onException(Throwable throwable) {
          throwable.printStackTrace();
        }
      });
    }


    // 由于发送是异步操作，所以需要使用其他异步操作进行等待；否则在发送之前producer就会被关闭，无法发送
    TimeUnit.SECONDS.sleep(3);
    producer.shutdown();
  }
}
```

#### 单向发送消息
定义单向消息发送生产者 OnewayProducer
```java
public class OnewayProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");
    producer.setNamesrvAddr("192.168.255.131:9876");
    producer.start();

    for (int i = 0; i < 10; i++) {
      byte[] body = ("Hi," + i).getBytes();
      Message msg = new Message("onewayTopic", "onewayTag", body);
      // 单向发送
      producer.sendOneway(msg);
    }

    producer.shutdown();
    System.out.println("producer shutdown");
  }
}
```

#### 消费者
定义消息消费者 TestCosumer
```java
public class TestCosumer {
  public static void main(String[] args) throws MQClientException {
    // 定义一个pull消费者
    // DefaultLitePullConsumer consumer = new DefaultLitePullConsumer("cg");

    // 定义一个push消费者
    DefaultMQPushConsumer consumer = new DefaultMQPushConsumer("cg");

    // 指定nameServer
    consumer.setNamesrvAddr("192.168.255.131:9876");

    // 指定从第一条消息开始消费
    consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);

    // 订阅指定的消费topic与tag
    consumer.subscribe("onewayTopic", "*");

    // 指定采用 广播模式 进行消费，默认为 集群模式
    // consumer.setMessageModel(MessageModel.BROADCASTING);

    // 注册消息监听器
    consumer.registerMessageListener(new MessageListenerConcurrently() {

      // 一旦broker中有了其订阅的消息就会触发该方法的执行，其返回值为当前consumer消费的状态
      @Override
      public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgList, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
        // 逐条消费消息
        for(MessageExt msg : msgList){
          System.out.println(msg);
        }

        // 返回消费状态：消费成功
        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
      }
    });

    // 开启消费者消费
    consumer.start();
    System.out.println("Consumer Started");

  }
}
```



### 顺序消息
定义顺序消息生产者 OrderedProducer
```java
public class OrderedProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");
    producer.setNamesrvAddr("192.168.255.131:9876");
    producer.start();

    for (int i = 0; i < 10; i++) {
      Integer orderId = i;
      byte[] body = ("OrderTest  " + i).getBytes();
      Message msg = new Message("orderTopic", "orderTag", body);
      // 这里传入的第三个参数orderId，可以在重写的select()方法的第三个参数获取到（即下面的arg参数）
      SendResult sendResult = producer.send(msg,
          new MessageQueueSelector() {
            @Override
            public MessageQueue select(List<MessageQueue> msgList, Message message, Object arg) {
              Integer id = (Integer) arg;
              int index = id % msgList.size();
              return msgList.get(index);
            }
          }, orderId);
      System.out.println(sendResult);
    }

    producer.shutdown();
  }
}
```



### 延时消息
延时消息的延迟时长 不支持随意时长 的延迟，而是通过特定的延迟等级来指定的；
延时等级定义在 RocketMQ服务端的 MessageStoreConfig类中的变量中，默认值如下
```java
messageDelayLevel = 1s 5s 10s 30s 1m 2m 3m 4m 5m 6m 7m 8m 9m 10m 20m 30m 1h 2h
```
注意：延迟等级从1开始计数（而不是0）

如果需要自定义延时等级，可以通过在broker加载的配置中新增配置；配置文件在RocketMQ安装目录下的conf目录中。

延迟消息生产者 DelayProducer
```java
public class DelayProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");
    producer.setNamesrvAddr("192.168.255.131:9876");
    producer.start();

    for(int i = 0; i < 3; i++) {
      byte[] body = ("delayTest  " + i).getBytes();
      Message msg = new Message("delayTopic", "delayTag", body);
      // 指定消息延迟等级为3级，即延迟10s
      // 各等级默认对应1s 5s 10s 30s 1m 2m 3m 4m 5m 6m 7m 8m 9m 10m 20m 30m 1h 2h（从1开始）
      msg.setDelayTimeLevel(3);

      SendResult sendResult = producer.send(msg);

      // 消息发送的时间
      System.out.println(new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new Date()) + " " + sendResult);

    }

    producer.shutdown();
  }

}
```

延迟消息消费者 DelayConsumer
```java
public class DelayConsumer {
  public static void main(String[] args) throws MQClientException {
    DefaultMQPushConsumer consumer = new DefaultMQPushConsumer("cg");
    consumer.setNamesrvAddr("192.168.255.131:9876");
    consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);
    consumer.subscribe("delayTopic", "*");

    consumer.registerMessageListener(new MessageListenerConcurrently() {
      @Override
      public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgList, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
        for(MessageExt msg : msgList){
          // 消息消费的时间
          System.out.println(new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(new Date()) + " " + msg);
        }
        // 返回消费状态：消费成功
        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
      }
    });

    consumer.start();
    System.out.println("Consumer Started");
  }
}
```


### 事务消息
以从银行扣款为例

定义银行事务监听器
```java
public class BankTransactionListener implements TransactionListener {
  // 回调操作方法
  // 消息预提交成功就会触发该方法的执行，用于完成本地事务
  @Override
  public LocalTransactionState executeLocalTransaction(Message msg, Object arg) {
    System.out.println("预提交消息成功：" + msg);
    // 消息tag为成功时，返回成功状态
    if (StringUtils.equals("success", msg.getTags())) {
      return LocalTransactionState.COMMIT_MESSAGE;
    } else if (StringUtils.equals("fail", msg.getTags())) {
      // 消息tag为失败时，返回失败状态
      return LocalTransactionState.ROLLBACK_MESSAGE;
    }
    // 其他情况返回 未知状态，需要回查
    return LocalTransactionState.UNKNOW;
  }

  // 回查方法；当回调方法返回UNKNOW，或是 TC没有接收到TM的最终全局事务确认指令（超时），执行该方法
  @Override
  public LocalTransactionState checkLocalTransaction(MessageExt messageExt) {
    System.out.println("执行消息回查" + messageExt.getTags());
    // 这里简单设置为直接返回成功状态
    return LocalTransactionState.COMMIT_MESSAGE;
  }
}
```

定义事物消息生产者 TransactionProducer
```java
public class TransactionProducer {
  public static void main(String[] args) throws Exception {
    // 指定对应group名称
    TransactionMQProducer producer = new TransactionMQProducer("tpg");
    producer.setNamesrvAddr("192.168.255.131:9876");

    /*
     * 创建线程池
     *  @param corePoolSize 线程池中核心线程数量
     *  @param maximumPoolSize 线程池中最多线程数
     *  @param keepAliveTime 当线程池中线程数量大于核心线程数量时，多余空闲线程的存活时长
     *  @param unit 时间单位
     *  @param workQueue 临时存放任务的队列，其参数就是队列的长度
     *  @param threadFactory 线程工厂
     */
    ExecutorService executorService = new ThreadPoolExecutor(2, 5,
        100, TimeUnit.SECONDS,
        new ArrayBlockingQueue<Runnable>(2000),
        new ThreadFactory() {
          @Override
          public Thread newThread(Runnable r) {
            Thread thread = new Thread(r);
            thread.setName("client-transaction-msg-check-thread");
            return thread;
          }
        });

    // 为生产者指定一个线程池
    producer.setExecutorService(executorService);
    // 为生产者添加事务监听器
    producer.setTransactionListener(new BankTransactionListener());

    producer.start();

    String[] tagList = {"success", "fail", "unknow"};
    for(int i = 0; i < 3; i++){
      byte[] body = ("Transaction Test" + i).getBytes();
      Message msg = new Message("Transaction Topic", tagList[i], body);

      // 发送事务消息
      // 第二个参数用于指定在执行本地事务时要使用的业务参数
      SendResult sendResult = producer.sendMessageInTransaction(msg, null);
      System.out.println("SendResult: " + sendResult);
    }

    producer.shutdown();

  }
}
```

消费者与普通消息的消费者相同
```java
public class NormalCosumer {
  public static void main(String[] args) throws MQClientException {
    // 定义一个pull消费者
    // DefaultLitePullConsumer consumer = new DefaultLitePullConsumer("cg");

    // 定义一个push消费者
    DefaultMQPushConsumer consumer = new DefaultMQPushConsumer("cg");

    // 指定nameServer
    consumer.setNamesrvAddr("192.168.255.131:9876");

    // 指定从第一条消息开始消费
    consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);

    // 订阅指定的消费topic与tag
    consumer.subscribe("onewayTopic", "*");

    // 指定采用 广播模式 进行消费，默认为 集群模式
    // consumer.setMessageModel(MessageModel.BROADCASTING);

    // 注册消息监听器
    consumer.registerMessageListener(new MessageListenerConcurrently() {
      // 一旦broker中有了其订阅的消息就会触发该方法的执行，其返回值为当前consumer消费的状态
      @Override
      public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgList, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
        // 逐条消费消息
        for(MessageExt msg : msgList){
          System.out.println(msg);
        }

        // 返回消费状态：消费成功
        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
      }
    });

    // 开启消费者消费
    consumer.start();
    System.out.println("Consumer Started");

  }
}
```



### 批量消息
生产者进行消息发送时可以一次发送多条消息，这可以大大提升Producer的发送效率。不过需要注意以下几点：
- 批量发送的消息必须具有相同的Topic
- 批量发送的消息必须具有相同的刷盘策略
- 批量发送的消息不能是延时消息与事务消息

默认情况下，一批发送的消息总大小不能超过4MB字节。如果想超出该值，有两种解决方案：
方案一：将批量消息进行拆分，拆分为若干不大于4M的消息集合分多次批量发送
方案二：在Producer端与Broker端修改属性
- Producer端需要在发送之前设置Producer的maxMessageSize属性
- Broker端需要修改其加载的配置文件中的maxMessageSize属性

生产者通过send()方法发送的Message，并不是直接将Message序列化后发送，而是通过Message生成了一个字符串进行发送。这个字符串由四部分构成：Topic、消息Body、消息日志（占20字节），及用于描述消息的一堆属性key-value。
这些属性中包含例如生产者地址、生产时间、要发送的QueueId等。最终写入到Broker中消息单元中的数据都是来自于这些属性。


#### 批量发送例子
不修改最大发送4M的默认值，但要防止发送的批量消息超出4M的限制。

定义消息列表分割器 MessageListSplitter
```java
public class MessageListSplitter implements Iterator<List<Message>> {
  // 设置一次能发送的消息大小的最大值；这里设置为4M
  private final int SIZE_LIMIT = 4 * 1024 * 1024;
  private final List<Message> msgList;
  private int currentIndex;

  public MessageListSplitter(List<Message> msgList) {
    this.msgList = msgList;
  }


  @Override
  public boolean hasNext() {
    return currentIndex < msgList.size();
  }

  @Override
  public List<Message> next() {
    int nextIndex = currentIndex;
    // 发送信息的总大小
    int totalSize = 0;
    while (nextIndex < msgList.size()) {
      Message msg = msgList.get(nextIndex);
      // 当前遍历消息的大小
      int tempSize = msg.getTopic().length() + msg.getBody().length;
      Map<String, String> properties = msg.getProperties();
      for (Map.Entry<String, String> entry : properties.entrySet()) {
        tempSize += entry.getKey().length() + entry.getValue().length();
      }
      tempSize += 20;

      // 如果单条消息大小超过限制值
      if (tempSize > SIZE_LIMIT) {
        if (nextIndex == currentIndex) {
          nextIndex++;
        }
        break;
      }

      // 如果累计的消息总大小 + 当前信息大小 超过限制值
      if (tempSize + totalSize > SIZE_LIMIT) {
        break;
      } else {
        // 如果累计的消息总大小 + 当前信息大小 在限制值内，则进行累加
        totalSize += tempSize;
      }
      nextIndex++;
    }

    // 获取信息数列中currentIndex到nextIndex的值组成新数列（不包括nextIndex位置）
    List<Message> subList = msgList.subList(currentIndex, nextIndex);
    currentIndex = nextIndex;
    return subList;
  }
}
```

定义批量消息生产者 BatchProducer
```java
public class BatchProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");
    producer.setNamesrvAddr("192.168.255.131:9876");

    // 指定要发送的消息的最大大小，默认为4M
    // 但仅修改该属性无法生效，还需要同时修改broker加载的配置文件中的maxMessageSize属性
    // producer.setMaxMessageSize(8 * 1024 * 1024);

    producer.start();

    // 定义要发送的消息集合
    List<Message> msgList = new ArrayList<>();
    for (int i = 0; i < 100; i++){
      byte[] body = ("batchTest " + i).getBytes();
      Message msg = new Message("batchTopic", "batchTag", body);
      msgList.add(msg);
    }

    // 将消息列表分割为多个不超出4M大小的小列表
    MessageListSplitter splitter = new MessageListSplitter(msgList);
    while (splitter.hasNext()){
      List<Message> list = splitter.next();
      producer.send(list);
    }

    producer.shutdown();

  }
}
```

定义批量消息消费者 BatchConsumer
```java
public class BatchConsumer {
  public static void main(String[] args) throws MQClientException {
    DefaultMQPushConsumer consumer = new DefaultMQPushConsumer("cg");
    consumer.setNamesrvAddr("192.168.255.131:9876");
    consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);
    consumer.subscribe("batchTopic", "*");

    // 指定每次可以消费10条消息，默认为1
    consumer.setConsumeMessageBatchMaxSize(10);
    // 指定每次可以从Broker拉取30条消息，默认为32
    consumer.setPopBatchNums(30);

    consumer.registerMessageListener((MessageListenerConcurrently) (msgList, consumeConcurrentlyContext) -> {
      for (MessageExt msg : msgList) {
        System.out.println(msg);
      }
      return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
    });

    consumer.start();
    System.out.println("Consumer Started");
  }
}
```



### 消息过滤
对于指定Topic消息的过滤有两种过滤方式：Tag过滤与SQL过滤。

#### 1 Tag过滤
通过consumer的subscribe()方法指定要订阅消息的Tag。如果订阅多个Tag的消息，Tag间使用或运算
符(双竖线||)连接


#### 2 SQL过滤
SQL过滤是一种通过特定表达式对事先埋入到消息中的用户属性进行筛选过滤的方式。通过SQL过滤，可以实现对消息的复杂过滤。
注意：只有使用PUSH模式的消费者才能使用SQL过滤。

SQL过滤表达式中支持多种常量类型与运算符。
支持的常量类型：
> 数值：比如：123，3.1415
> 字符：必须用单引号包裹起来，比如：'abc'
> 布尔：TRUE 或 FALSE
> NULL：特殊的常量，表示空

支持的运算符有：
> 数值比较：>，>=，<，<=，BETWEEN，=
> 字符比较：=，<>，IN
> 逻辑运算 ：AND，OR，NOT
> NULL判断：IS NULL 或者 IS NOT NULL

默认情况下Broker没有开启消息的SQL过滤功能，
需要在Broker加载的配置文件中添加如下属性，以开启该功能：
`enablePropertyFilter = true`

在启动Broker时需要指定这个修改过的配置文件。
例如对于单机Broker的启动，需要修改配置文件 conf/broker.conf
`vim conf/broker.conf`
添加 `enablePropertyFilter = true`

启动时使用如下命令：
`sh bin/mqbroker -n localhost:9876 -c conf/broker.conf &`


#### 3 代码举例
定义Tag过滤生产者 FilterByTagProducer
```java
public class FilterByTagProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");
    producer.setNamesrvAddr("192.168.255.131:9876");
    producer.start();

    String[] tags = {"testTagA", "testTagB", "testTagC"};
    for (int i = 0; i < 10; i++) {
      byte[] body = ("filter tag test," + i).getBytes();
      String tag = tags[i % tags.length];
      Message msg = new Message("filterTopic", tag, body);
      SendResult sendResult = producer.send(msg);
      System.out.println(sendResult);
    }

    producer.shutdown();
  }
}
```

定义Tag过滤消费者
```java
public class FilterByTagConsumer {
  public static void main(String[] args) throws Exception {
    DefaultMQPushConsumer consumer = new DefaultMQPushConsumer("cg");
    consumer.setNamesrvAddr("192.168.255.131:9876");
    consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);

    // 使用消息tag进行过滤，只接收tag为testTagA或testTagC的消息
    consumer.subscribe("filterTopic", "testTagA || testTagC");

    consumer.registerMessageListener(new MessageListenerConcurrently() {
      @Override
      public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgList, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
        for (MessageExt msg : msgList) {
          System.out.println(msg);
        }

        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
      }
    });

    consumer.start();
    System.out.println("Consumer Started");
  }
}
```

定义SQL过滤生产者 FilterBySQLProducer
```java
public class FilterBySQLProducer {
  public static void main(String[] args) throws Exception {
    DefaultMQProducer producer = new DefaultMQProducer("pg");
    producer.setNamesrvAddr("192.168.255.131:9876");
    producer.start();

    for (int i = 0; i < 10; i++) {
      byte[] body = ("Test SQL filter " + i).getBytes();
      Message msg = new Message("filterTopic", "SQLfilter", body);
      msg.putUserProperty("age", i + "");
      SendResult sendResult = producer.send(msg);
      System.out.println(sendResult);
    }
    
    producer.shutdown();
  }
}
```

定义SQL过滤消费者 FilterBySQLConsumer
```java
public class FilterBySQLConsumer {
  public static void main(String[] args) throws Exception {
    DefaultMQPushConsumer consumer = new DefaultMQPushConsumer("cg");
    consumer.setNamesrvAddr("192.168.255.131:9876");
    consumer.setConsumeFromWhere(ConsumeFromWhere.CONSUME_FROM_FIRST_OFFSET);

    // 使用SQL语句进行过滤，只接收age属性值为[0, 5]范围内的消息
    consumer.subscribe("filterTopic", MessageSelector.bySql("age between 0 and 5"));

    consumer.registerMessageListener(new MessageListenerConcurrently() {
      @Override
      public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgList, ConsumeConcurrentlyContext consumeConcurrentlyContext) {
        for (MessageExt msg : msgList) {
          System.out.println(msg);
        }

        return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
      }
    });

    consumer.start();
    System.out.println("Consumer Started");

  }
}
```



















