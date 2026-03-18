# OpenClaw note
openclaw相关记录  

官方github 
https://github.com/openclaw/openclaw


## 安装
安装非常简单  
直接根据文档一步一步来就行，没遇到什么问题  

### 快速安装
官方文档： https://docs.openclaw.ai/start/getting-started

以下以Ubuntu系统安装为例

```shell
curl -fsSL https://openclaw.ai/install.sh | bash
```

### 初始化
安装完成后使用初始化配置工具
```shell
openclaw onboard --install-daemon
```
根据提示一步一步选择就行，非常简单
这里使用的是OpenRouter，列表中可以直接进行选择  
模型可以选择带有free的


### 使用
```shell
# 查看gateway状态
openclaw gateway status

# 打开web UI界面
openclaw dashboard
```

### 配置文件
默认配置文件位置
 ~/.openclaw/openclaw.json



## 宿主机访问
使用nginx，使得宿主机能够访问VMware虚拟机中的openclaw web UI

### 安装nginx
```shell
# 安装nginx
apt get update
apt install nginx -y

# 启动nginx
systemctl start nginx

# 设置nginx开机自启（可选）
sudo systemctl enable nginx

# 验证状态
sudo systemctl status nginx
```

### 配置反向代理
1. 创建OpenClaw专属配置文件
```shell
vim /etc/nginx/sites-available/openclaw
```

2. 写入以下配置内容
```shell
server {
    listen 433 ssl;
    server_name 192.168.255.233;  # 虚拟机静态IP

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
	
    location / {
        proxy_pass http://127.0.0.1:18789;
        proxy_http_version 1.1;
        
        # WebSocket支持
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        
        # 传递真实客户端信息
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # 长连接超时设置
        proxy_read_timeout 3600s;
        proxy_send_timeout 3600s;
    }
}
```

3. 配置 Nginx 使用自签名证书
```shell
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```
一路回车确认，生成对应的key和crt文件

4. 启用配置
```shell
# 禁用默认配置（移除指向默认配置的连接）
sudo rm /etc/nginx/sites-enabled/default

# 启用OpenClaw配置
sudo ln -s /etc/nginx/sites-available/openclaw /etc/nginx/sites-enabled/

# 测试配置语法
sudo nginx -t
# 应该显示 "test is successful"

# 重载Nginx使配置生效
sudo systemctl reload nginx
```

5. 访问
宿主机直接访问虚拟机地址；需要带上端口号才能访问对应聊天界面
https://192.168.255.233:433/

浏览器会提示不安全，点`高级`，`继续前往`


### openclaw问题排查

#### origin not allowed错误
能够访问dashboard面板，但报错无法进行聊天
```shell
origin not allowed (open the Control UI from the gateway host or allow it in gateway.controlUi.allowedOrigins)
```
需要修改openclaw配置
```shell
# 打开配置文件
vim /root/.openclaw/openclaw.json

# 在gateway部分添加以下内容
"controlUi": {
  "enabled": true,
  "allowInsecureAuth": true,           // 允许HTTP下的认证
  "allowedOrigins": [
    "http://192.168.255.233",
    "http://localhost:8080",
    "https://192.168.255.233:433" // 需要添加端口号
  ]
}
```
配置完成后重启gateway
```shell
openclaw gateway restart
```

#### device identity required错误
官方文档 https://docs.openclaw.ai/web/control-ui#device-pairing-first-connection
初次访问时需要进行设备配对

```shell
# 查看设备列表
openclaw devices list

# 找到在pending部分的设备的requestId（第一列）进行配对
openclaw devices approve <requestId>
```
完成后宿主机就能正常访问并使用openclaw


#### 需要token
如果报错信息提示需要token  
直接复制启动dashboard时显示的token，或到配置文件中查看



## 升级
使用如下命令升级
```shell
openclaw update
```
需要连上git进行更新，如果网络不通畅可能会超时  

如果报 ` npm error code 128` 错误，并提示shh问题  
使用https代替ssh
```shell
git config --global url."https://github.com/".insteadOf "git@github.com:"
```



## 常用命令
```shell
# 查看配置模型列表
openclaw models list

# 查看当前使用模型
openclaw session_status

# 切换模型
openclaw models set <provider/model>
```



## 接入QQ
登录QQ Bot页面（手机QQ扫码），并创建机器人
https://q.qq.com/qqbot/openclaw/login.html

根据官方提示接入
```shell
# 安装OpenClaw开源社区QQBot插件
openclaw plugins install @tencent-connect/openclaw-qqbot@latest

# 配置绑定当前QQ机器人（填充创建的id和api）
# --channel	频道类型，固定为 qqbot
# --token	机器人凭证，格式为 AppID:AppSecret
openclaw channels add --channel qqbot --token "<App ID>:<AppSecret>"

# 重启本地OpenClaw服务
openclaw gateway restart


# 查看插件列表
openclaw plugins list
```

### 问题
openclaw新版需要配置插件白名单，否则会提示 plugins.allow is empty
```shell
[plugins] plugins.allow is empty; discovered non-bundled plugins may auto-load ...
```

在openclaw配置文件中，在plugins中
```shell
"allow": [
  "openclaw-qqbot"
],
```

QQ Bot返回的信息一直提示 `[暂不支持该消息类型，请用手机QQ查看]`
QQ版本问题，需要使用高版本的QQ才能正常显示




## 问题记录

### 版本问题
2026.3.2版本  
配置完成后，聊天显示401错误  
可能是bug，官方github上也有人报这个错

2026.2.26版本
启动后gateway一直退出，导致无法打开web UI dashboard页面  
可能是bug，官方github上也有人报这个错

使用 2026.3.1版本 ，配置后没有问题，可以正常聊天

#### 测试
测试直接使用api key
```shell
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer YOUR API KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openrouter/free",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```
如果正常返回，说明不是key的问题








