# Kubernetes（k8s） note


## kubernetes 安装、集群搭建
目前生产部署 Kubernetes 集群主要有两种方式：
（1）kubeadm
Kubeadm 是一个 K8s 部署工具，提供 kubeadm init 和 kubeadm join，用于快速部署 Kubernetes 集群。
官方地址：https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/

（2）二进制包
从 github 下载发行版的二进制包，手动部署每个组件，组成 Kubernetes 集群。

Kubeadm 降低部署门槛，但屏蔽了很多细节，遇到问题很难排查。如果想更容易可控，推荐使用二进制包部署 Kubernetes 集群，虽然手动部署麻烦点，期间可以学习很多工作原理，也利于后期维护。


### kubeadm 方式安装
以 kubeadm 1.30版本为例
官方文档 https://v1-30.docs.kubernetes.io/zh-cn/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

#### 准备
- 一台兼容的 Linux 主机
- 每台机器 2 GB 或更多的 RAM（如果少于这个数字将会影响应用的运行内存）
- CPU 2 核心及以上
- 集群中的所有机器的网络彼此均能相互连接（公网和内网都可以）
- 节点之中不可以有重复的主机名、MAC 地址或 product_uuid
- 开启机器上的某些端口
- swap（交换分区）的配置；需要禁用swap
  - 如果 kubelet 未被正确配置使用交换分区，则必须禁用交换分区。 例如，sudo swapoff -a 将暂时禁用交换分区。要使此更改在重启后保持不变，请确保在如 /etc/fstab、systemd.swap 等配置文件中禁用交换分区，具体取决于你的系统如何配置。
  
#### 最终目标
- 在所有节点上安装 Docker 和 kubeadm
- 部署 Kubernetes Master
- 部署容器网络插件
- 部署 Kubernetes Node，将节点加入 Kubernetes 集群中
- 部署 Dashboard Web 页面，可视化查看 Kubernetes 资源  

#### 1 关闭 swap（所有节点）
```shell
# 临时
swapoff -a

# 永久关闭
vim /etc/fstab
# 把/swapfile开头这行注释掉
# /swapfile                                 none            swap    sw              0       0
```
启动Kubelet需要禁用swap，否则会启动失败


#### 2 修改主机名称（可选）（所有节点）
`hostnamectl set-hostname <hostname>`


#### 3 安装docker（所有节点）
**准备工作**
启用 IPv4 数据包转发
```shell
# 设置所需的 sysctl 参数，参数在重新启动后保持不变
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# 应用 sysctl 参数而不重新启动
sudo sysctl --system

# 使用以下命令验证 net.ipv4.ip_forward 是否设置为 1
sysctl net.ipv4.ip_forward
```

**安装docker**
官方文档 https://docs.docker.com/engine/install/ubuntu/

**安装cri-dockerd**
地址 https://github.com/Mirantis/cri-dockerd/releases
选择自己需要的版本

这里以 Ubuntu22.04(jammy) 版本为例
下载 cri-dockerd_0.3.15.3-0.ubuntu-jammy_amd64.deb

下载好文件包后，安装
`dpkg -i cri-dockerd_0.3.15.3-0.ubuntu-jammy_amd64.deb`


#### 4 安装 kubeadm、kubelet 和 kubectl （所有节点）
1 更新 apt 包索引并安装使用 Kubernetes apt 仓库所需要的包
```shell
sudo apt-get update
# apt-transport-https 可能是一个虚拟包（dummy package）；如果是的话，可以跳过安装这个包
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```

2 下载用于 Kubernetes 软件包仓库的公共签名密钥。所有仓库都使用相同的签名密钥，因此你可以忽略URL中的版本
```shell
# 如果 `/etc/apt/keyrings` 目录不存在，则应在 curl 命令之前创建它
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

3 添加 Kubernetes apt 仓库
```shell
# 此操作会覆盖 /etc/apt/sources.list.d/kubernetes.list 中现存的所有配置
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

4 更新 apt 包索引，安装 kubelet、kubeadm 和 kubectl，并锁定其版本
```shell
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```


#### 5 创建 kubernetes 集群，部署 Kubernetes Master （主节点）

##### master节点初始化
在主节点Master上执行
```shell
kubeadm init \
--kubernetes-version v1.30.0 \
--cri-socket unix:///run/cri-dockerd.sock \
--pod-network-cidr=10.244.0.0/16 \
--service-cidr=10.96.0.0/12 

# 区别于1.23及之前的版本，一定要加上 --cri-socket unix:///run/cri-dockerd.sock，用于指定容器运行时；安装了cri-socket后会有多个容器运行时，所以需要指定
```

出现以下信息说明创建成功
```shell
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

```

按照提示，创建配置文件目录和复制配置文件
```shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```


##### kubeadm一些参数说明
```shell
--apiserver-advertise-address string   设置 apiserver 绑定的 IP.
--apiserver-bind-port int32            设置apiserver 监听的端口. (默认 6443)
--apiserver-cert-extra-sans strings    api证书中指定额外的Subject Alternative Names (SANs) 可以是IP 也可以是DNS名称。 证书是和SAN绑定的。
--cert-dir string                      证书存放的目录 (默认 "/etc/kubernetes/pki")
--certificate-key string               kubeadm-cert secret 中 用于加密 control-plane 证书的key
--config string                        kubeadm 配置文件的路径.
--cri-socket string                    CRI socket 文件路径，如果为空 kubeadm 将自动发现相关的socket文件; 只有当机器中存在多个 CRI  socket 或者 存在非标准 CRI socket 时才指定.
--dry-run                              测试，并不真正执行;输出运行后的结果.
--feature-gates string                 指定启用哪些额外的feature 使用 key=value 对的形式。
--help  -h                             帮助文档
--ignore-preflight-errors strings      忽略前置检查错误，被忽略的错误将被显示为警告. 例子: 'IsPrivilegedUser,Swap'. Value 'all' ignores errors from all checks.
--image-repository string              选择拉取 control plane images 的镜像repo (default "k8s.gcr.io")
--kubernetes-version string            选择K8S版本. (default "stable-1")
--node-name string                     指定node的名称，默认使用 node 的 hostname.
--pod-network-cidr string              指定 pod 的网络， control plane 会自动将 网络发布到其他节点的node，让其上启动的容器使用此网络
--service-cidr string                  指定service 的IP 范围. (default "10.96.0.0/12")
--service-dns-domain string            指定 service 的 dns 后缀, e.g. "myorg.internal". (default "cluster.local")
--skip-certificate-key-print           不打印 control-plane 用于加密证书的key.
--skip-phases strings                  跳过指定的阶段（phase）
--skip-token-print                     不打印 kubeadm init 生成的 default bootstrap token 
--token string                         指定 node 和control plane 之间，简历双向认证的token ，格式为 [a-z0-9]{6}\.[a-z0-9]{16} - e.g. abcdef.0123456789abcdef
--token-ttl duration                   token 自动删除的时间间隔。 (e.g. 1s, 2m, 3h). 如果设置为 '0', token 永不过期 (default 24h0m0s)
--upload-certs                         上传 control-plane 证书到 kubeadm-certs Secret.
```

##### 重置
如果出现问题想要重置，先执行 
```shell
kubeadm reset --cri-socket unix:///run/cri-dockerd.sock
```
再重新执行上面的初始化命令`


##### 安装 Pod 网络附加组件
列表 https://v1-30.docs.kubernetes.io/zh-cn/docs/concepts/cluster-administration/addons/#networking-and-network-policy

这里以安装 Flannel 为例
github地址 https://github.com/flannel-io/flannel 

```shell
# 安装
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

# 查看状态
kubectl get pods --all-namespaces
```


#### 6 加入worker节点 （工作节点）
查看token（主节点）
`kubeadm token list`

默认是24小时过期，如果过期了可以用以下命令创建（主节点）
`kubeadm token create`

查看 token-ca-cert-hash
```shell
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'
```

在worker节点上执行
```shell
kubeadm join 192.168.255.200:6443 \
--token 392lub.wnh2sz1iings5xzd \
--discovery-token-ca-cert-hash sha256:efb9aeef4c8e4d0176de9013761495649ea8965c71ff43ae068c4b9b4e4c8b2c \
--cri-socket unix:///run/cri-dockerd.sock
```

##### 常用命令
```shell
# 查看节点
kubectl get nodes

# 查看集群状态
kubectl get cs

# 查看kubelet状态
systemctl status kubelet

# 查看详细日志信息
journalctl -u kubelet -f

# 重启kubelet
systemctl restart kubelet

# 查看事件
kubectl get events --all-namespaces  --sort-by='.metadata.creationTimestamp'
kubectl get events --sort-by=".metadata.managedFields[0].time"

# 查看kubectl 配置
kubectl config view

```


#### 7 测试 kubernetes 集群
在 Kubernetes 集群中创建一个 pod，验证是否正常运行
```shell
kubectl create deployment mynginx --image=nginx
kubectl expose deployment mynginx --port=80 --type=NodePort
kubectl get pod,svc
```
访问地址：http://NodeIP:Port
http://192.168.255.200:31638/
访问任意一台虚拟机的ip，都能查看nginx页面


#### 常见错误排查

##### coredns 状态为 ContainerCreating
```shell
# 使用describe查看错误信息
kubectl describe pods -n kube-system   coredns-55cb58b774-kb4v2

# 报错
Warning  FailedCreatePodSandBox  8m45s (x3 over 8m47s)    kubelet            (combined from similar events): Failed to create pod sandbox: rpc error: code = Unknown desc = failed to set up sandbox container "0f24e4662aecee2df80dfff0ea243b1d5c2bec65f070fc354dc9681198572856" network for pod "coredns-55cb58b774-kb4v2": networkPlugin cni failed to set up pod "coredns-55cb58b774-kb4v2_kube-system" network: plugin type="flannel" failed (add): loadFlannelSubnetEnv failed: open /run/flannel/subnet.env: no such file or directory

# 需要下载yaml文件
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```


##### kube-flannel 状态为 CrashLoopBackOff
```shell
# 查看对应日志信息
kubectl logs <NAME>  -n kube-flannel

kubectl logs kube-flannel-ds-9grtp  -n kube-flannel

# 报错
Failed to check br_netfilter: stat /proc/sys/net/bridge/bridge-nf-call-iptables: no such file or directory

# 该错误通常表示内核模块 br_netfilter 未加载或未正确配置
# 解决
# 加载 br_netfilter 模块
sudo modprobe br_netfilter
```

可配置让系统启动时自动加载 br_netfilter 模块
编辑 /etc/modules-load.d/br_netfilter.conf
`echo "br_netfilter" | sudo tee /etc/modules-load.d/br_netfilter.conf`

生效
```shell
sudo sysctl --system  
systemctl daemon-reload

# 重启kubelet和containerd
systemctl restart kubelet
systemctl restart containerd
```

##### 镜像状态为ImagePullBackoff
参考 https://www.cnblogs.com/digdeep/p/12319340.html
```shell
# 查看对应日志
kubectl describe pod <NAME> 
kubectl describe pod mynginx-76748d594d-jtxtm 
```
镜像拉取失败一般为网络问题，但要注意在集群环境下，**所有的节点都需要设置镜像源**，因为 kubectl run命令默认可以在任一个节点上安装

```shell
# 解决
# 删除有问题的pod，之后会自动重新下载镜像
kubectl delete pod mynginx-76748d594d-jtxtm
```








### 纯手动方式部署（未完成）

#### 服务器规划
| 角色          | IP             | 组件                                                               |
| ------------- | -------------- | ------------------------------------------------------------------ |
| k8s_manual_m  | 192.168.31.205 | kube-apiserver,kube-controller-manager,kube-scheduler,etcd, kubectl |
| k8s_manual_n1 | 192.168.31.206 | kubelet,kube-proxy,docker,etcd                                     |
| k8s_manual_n2 | 192.168.31.207 | kubelet,kube-proxy,docker,etcd                                     |



准备、安装步骤 1-2 与 kubeadm 方式相同

#### 1 关闭 swap（所有节点）
```shell
# 临时
swapoff -a

# 永久关闭
vim /etc/fstab
# 把/swapfile开头这行注释掉
# /swapfile                                 none            swap    sw              0       0
```
启动Kubelet需要禁用swap，否则会启动失败


#### 2 修改主机名称（可选）（所有节点）
`hostnamectl set-hostname <hostname>`


#### 3 设置 IPV4 转发（所有节点）
启用 IPv4 数据包转发
```shell
# 设置所需的 sysctl 参数，参数在重新启动后保持不变
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# 应用 sysctl 参数而不重新启动
sudo sysctl --system

# 使用以下命令验证 net.ipv4.ip_forward 是否设置为 1
sysctl net.ipv4.ip_forward
```


#### 4 安装docker（子节点）
官方文档 https://docs.docker.com/engine/install/ubuntu/


#### 5 签发证书
参考文档 https://kubernetes.io/docs/tasks/administer-cluster/certificates/

要设置集群，请使用三种类型的证书，例如：
- 客户端证书：服务器用于验证客户端。例如 etcdctl、etcd 代理或 docker 客户端。
- 服务器证书：服务器使用，客户端验证服务器身份。例如 docker 服务器或 kube-apiserver。
- 对等证书（peer certificate）：etcd 集群成员使用此证书进行双向通信。

##### 下载 cfssl 工具
cfssl 是一个开源的证书管理工具，使用 json 文件生成证书，相比 openssl 更方便使用。
可以用任意一台集群中的机器操作，这里使用 Master 节点
```shell
# 下载 cfssl 工具
curl -O https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
curl -O https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
curl -O https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
# 赋予执行权限
chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64
# 把文件全部移动到/usr/bin文件夹中
mv -f cfssl_linux-amd64 /usr/bin/cfssl
mv -f cfssljson_linux-amd64 /usr/bin/cfssljson
mv -f cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo

# 或直接用以下命令一步到位
curl -s -L -o /usr/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
curl -s -L -o /usr/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
curl -s -L -o /usr/bin/cfssl-certinfo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
chmod +x /bin/cfssl*
```
curl下载可能会不成功，因此可以先用宿主机下载好对应文件，在上传到虚拟机中

查看配置等示例
```shell
cfssl print-defaults csr
cfssl print-defaults config
```

##### 生成证书
创建 CA 证书签名请求 (CSR) 配置文件
示例
```json
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names":[{
    "C": "<country>",
    "ST": "<state>",
    "L": "<city>",
    "O": "<organization>",
    "OU": "<organization unit>"
  }]
}
```

ca-csr.json
```json
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names":[{
    "C": "CN",
    "ST": "BJ",
    "L": "BJ",
    "O": "k8s",
    "OU": "System"
  }]
}
```
参数说明
```
# "CN"：Common Name，kube-apiserver 从证书中提取该字段作为请求的用户名 (User Name)
# "O"：Organization，kube-apiserver从证书中提取该字段作为请求用户所属的组 (Group)
# C: Country， 国家
# L: Locality，地区，城市
# O: Organization Name，组织名称，公司名称
# OU: Organization Unit Name，组织单位名称，公司部门
# ST: State，州，省
```

生成 CA 密钥（ca-key.pem）和证书（ca.pem）
`cfssl gencert -initca ca-csr.json | cfssljson -bare ca -`

可生成如下文件
```
ca-key.pem
ca.csr
ca.pem
```


创建证书配置文件（CA 进行签名时需要的配置） 
ca-config.json
```json
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "client auth"
        ],
        "expiry": "8760h"
      }
    }
  }
}
```
参数说明
```
# 这个策略，有一个默认的配置，和一个profile，可以设置多个profile，这里的profile是etcd。
# 默认策略，指定了证书的有效期是一年(8760h)
# etcd策略，指定了证书的用途
# signing, 表示该证书可用于签名其它证书；生成的 ca.pem 证书中 CA=TRUE
# server auth：表示 client 可以用该 CA 对 server 提供的证书进行验证
# client auth：表示 server 可以用该 CA 对 client 提供的证书进行验证
```

创建为 API 服务器生成密钥和证书的配置配置文件 server-csr.json
示例
```json
{
  "CN": "kubernetes",
  "hosts": [
    "127.0.0.1",
    "<MASTER_IP>",
    "<MASTER_CLUSTER_IP>",
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.default.svc.cluster.local"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [{
    "C": "<country>",
    "ST": "<state>",
    "L": "<city>",
    "O": "<organization>",
    "OU": "<organization unit>"
  }]
}
```

server-csr.json
```json
{
  "CN": "kubernetes",
  "hosts": [
    "127.0.0.1",
    "192.168.255.205",
    "192.168.255.206",
    "192.168.255.207",
    "10.96.0.1",
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.default.svc.cluster.local"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [{
    "C": "CN",
    "ST": "BJ",
    "L": "BJ",
    "O": "k8s",
    "OU": "System"
  }]
}
```
注：上述文件 hosts 字段中 IP 为所有 etcd 节点的集群内部通信 IP，一个都不能少。为了
方便后期扩容可以多写几个预留的 IP。

生成 API 服务器的密钥和证书（服务端证书）
```shell
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem \
     --config=ca-config.json -profile=kubernetes \
     server-csr.json | cfssljson -bare server
```

可生成如下文件
```
server-key.pem
server.csr
server.pem
```



#### 6 etcd
下载 https://github.com/etcd-io/etcd/releases

此处选择v3.5.17版本，下载地址
https://github.com/etcd-io/etcd/releases/download/v3.5.17/etcd-v3.5.17-linux-amd64.tar.gz

为了简化操作，（1）-（4）在节点1（192.168.255.205）上操作即可，节点1生成对应文件后将文件拷贝到节点2（192.168.255.206）和节点3（192.168.255.207）

##### （1）创建工作目录并解压二进制包
```shell
# 解压文件
tar zxvf etcd-v3.5.17-linux-amd64.tar.gz

# 拷贝可执行文件到系统环境
cp -r etcd-v3.5.17-linux-amd64/{etcd,etcdctl} /usr/bin/
# 添加执行权限
# chmod +x /usr/bin/{etcd,etcdctl}
```

##### （2）创建 etcd 配置文件
etcd配置文件 etcd.conf
```shell
# 创建etcd配置文件；这里放在/opt/module/etcd/ 中
# 在/opt/module中创建 etcd 文件夹
mkdir etcd
vim /opt/module/etcd/etcd.conf

# 配置如下内容
#[Member]
ETCD_NAME="etcd-1"
ETCD_DATA_DIR="/etc/module/data/default.etcd"
ETCD_LISTEN_PEER_URLS="https://192.168.255.205:2380"
ETCD_LISTEN_CLIENT_URLS="https://192.168.255.205:2379"
#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.255.205:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.255.205:2379"
ETCD_INITIAL_CLUSTER="etcd-1=https://192.168.255.205:2380,etcd-2=https://192.168.255.206:2380,etcd-3=https://192.168.255.207:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"
```
参数说明
```
ETCD_NAME：节点名称，集群中唯一
ETCD_DATA_DIR：数据目录
ETCD_LISTEN_PEER_URLS：集群通信监听地址
ETCD_LISTEN_CLIENT_URLS：客户端访问监听地址
ETCD_INITIAL_ADVERTISE_PEER_URLS：集群通告地址
ETCD_ADVERTISE_CLIENT_URLS：客户端通告地址
ETCD_INITIAL_CLUSTER：集群节点地址
ETCD_INITIAL_CLUSTER_TOKEN：集群 Token
ETCD_INITIAL_CLUSTER_STATE：加入集群的当前状态，new 是新集群，existing 表示加入已有集群
```

##### （3）systemd 管理 etcd
准备 systemd 服务文件 etcd.service
```shell
# 创建 Service 文件
vim /usr/lib/systemd/system/etcd.service 

# 写入如下内容
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target
[Service]
Type=notify
EnvironmentFile=/opt/module/etcd/etcd.conf
ExecStart=/usr/bin/etcd  \
--cert-file=/opt/module/etcd/ssl/server.pem \
--key-file=/opt/module/etcd/ssl/server-key.pem \
--peer-cert-file=/opt/module/etcd/ssl/server.pem \
--peer-key-file=/opt/module/etcd/ssl/server-key.pem \
--trusted-ca-file=/opt/module/etcd/ssl/ca.pem \
--peer-trusted-ca-file=/opt/module/etcd/ssl/ca.pem \
--logger=zap
Restart=on-failure
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
```

##### （4）拷贝刚才生成的证书
把之前生成的3个证书拷贝到配置文件的路径（都是.pem后缀）
```shell
# server.pem
# server-key.pem
# ca.pem
cp /opt/cert/server.pem /opt/module/etcd/ssl/
cp /opt/cert/server-key.pem /opt/module/etcd/ssl/
cp /opt/cert/ca.pem /opt/module/etcd/ssl/
# 注意先创建ssl文件夹
```


##### （5）复制文件
将上面节点 1 所有生成的文件拷贝到其他节点 （节点2 （192.168.255.206）节点3 （192.168.255.207））
```shell
scp -r /opt/module/etcd/ root@192.168.255.206:/opt/module/
scp -r /usr/bin/{etcd,etcdctl} root@192.168.255.206:/usr/bin/
scp /usr/lib/systemd/system/etcd.service root@192.168.255.206:/usr/lib/systemd/system/

scp -r /opt/module/etcd/ root@192.168.255.207:/opt/module/ 
scp -r /usr/bin/{etcd,etcdctl} root@192.168.255.207:/usr/bin/
scp /usr/lib/systemd/system/etcd.service root@192.168.255.207:/usr/lib/systemd/system/
```

在节点2 （192.168.255.206）和节点3 （192.168.255.207）上分别修改 etcd.conf 配置文件中的节点名称和当前服务器 IP：
```shell
#[Member]
ETCD_NAME="etcd-1" # 修改此处，节点 2 改为 etcd-2，节点 3 改为 etcd-3
ETCD_DATA_DIR="/etc/module/data/default.etcd"
ETCD_LISTEN_PEER_URLS="https://192.168.255.205:2380" # 修改此处为当前服务器 IP
ETCD_LISTEN_CLIENT_URLS="https://192.168.255.205:2379" # 修改此处为当前服务器 IP
#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://192.168.255.205:2380" # 修改此处为当前服务器 IP
ETCD_ADVERTISE_CLIENT_URLS="https://192.168.255.205:2379" # 修改此处为当前服务器 IP
ETCD_INITIAL_CLUSTER="etcd-1=https://192.168.255.205:2380,etcd-2=https://192.168.255.206:2380,etcd-3=https://192.168.255.207:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"
```


##### （6）启动并设置开机启动
安装etcd服务的所在服务器都需执行（192.168.255.205 - 207 ）
```shell
# 载入设置
systemctl daemon-reload 

# 启动etcd
systemctl start etcd 
# 设置etcd开机启动
systemctl enable etcd

# 查看etcd状态
systemctl status etcd
```


##### （7）查看集群状态
```shell
ETCDCTL_API=3 /usr/bin/etcdctl --cacert=/opt/module/etcd/ssl/ca.pem --cert=/opt/module/etcd/ssl/server.pem --key=/opt/module/etcd/ssl/server-key.pem --endpoints="https://192.168.255.205:2379,https://192.168.255.206:2379,https://192.168.255.207:2379" endpoint health
```
显示如下信息表示部署成功
```
https://192.168.255.205:2379 is healthy: successfully committed proposal: took = 4.332979ms
https://192.168.255.206:2379 is healthy: successfully committed proposal: took = 5.169833ms
https://192.168.255.207:2379 is healthy: successfully committed proposal: took = 5.223092ms
```



#### 7 安装docker （所有节点）
官方文档 https://docs.docker.com/engine/install/ubuntu/



#### 8 部署 Master Node（主节点）
在 Master 节点，需要 kubernetes 系列组件（包括 kube-apiserver 、 kube-scheduler、kube-controller-manager 和 kubectl）

##### (1) 生成 kube-apiserver 证书
在第5步签发证书时已经生成过，可直接使用
新版还需要生成 pub

使用之前已经生成的 ca.pem 文件 生成 sa.pub（文件名可自取）
```shell
openssl x509 -in ca.pem -pubkey -noout > sa.pub
```


##### (2) 从 Github 下载 kubernetes 二进制文件
下载地址
https://dl.k8s.io/v1.30.0/kubernetes-server-linux-amd64.tar.gz
注意需要下载 server 包

```shell
# 解压文件
tar zxvf kubernetes-server-linux-amd64.tar.gz

# 移动解压后文件夹
mv kubernetes /opt/module
cd /opt/module

# 拷贝可执行文件到系统环境
cp -r kubernetes/server/bin/{kube-apiserver,kube-scheduler,kube-controller-manager,kubectl} /usr/bin/
chmod +x /usr/bin/{kube-apiserver,kube-scheduler,kube-controller-manager,kubectl}
```

##### (3) 部署 kube-apiserver
创建配置文件 kube-apiserver.conf
```shell
# 创建存放对应数据的文件夹
mkdir /opt/module/kubernetes/{cfg,ssl,logs}

# 创建配置
vim /opt/module/kubernetes/cfg/kube-apiserver.conf 

# 写入如下内容
KUBE_APISERVER_OPTS="--v=2 \
--etcd-servers=https://192.168.255.205:2379,https://192.168.255.206:2379,https://192.168.255.207:2379 \
--bind-address=192.168.255.205 \
--secure-port=6443 \
--advertise-address=192.168.255.205 \
--allow-privileged=true \
--service-cluster-ip-range=10.0.0.0/24 \
--enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,ResourceQuota,NodeRestriction \
--enable-bootstrap-token-auth=true \
--token-auth-file=/opt/module/kubernetes/cfg/token.csv \
--service-node-port-range=30000-32767 \
\
--kubelet-client-certificate=/opt/module/kubernetes/ssl/server.pem \
--kubelet-client-key=/opt/module/kubernetes/ssl/server-key.pem \
--tls-cert-file=/opt/module/kubernetes/ssl/server.pem \
--tls-private-key-file=/opt/module/kubernetes/ssl/server-key.pem \
--client-ca-file=/opt/module/kubernetes/ssl/ca.pem \
--service-account-key-file=/opt/module/kubernetes/ssl/ca-key.pem \
--etcd-cafile=/opt/module/etcd/ssl/ca.pem \
--etcd-certfile=/opt/module/etcd/ssl/server.pem \
--etcd-keyfile=/opt/module/etcd/ssl/server-key.pem \
--service-account-key-file=/opt/module/kubernetes/ssl/sa.pub \
--service-account-signing-key-file=/opt/module/kubernetes/ssl/ca-key.pem \
--service-account-issuer=api \
\
--audit-log-maxage=30 \
--audit-log-maxbackup=3 \
--audit-log-maxsize=100 \
--audit-log-path=/opt/module/kubernetes/logs/k8s-audit.log \
--runtime-config=api/all=true,rbac.authorization.k8s.io/v1=true"
```
参数说明
```
—v：日志等级
–etcd-servers：etcd 集群地址
–bind-address：监听地址
–secure-port：https 安全端口
–advertise-address：集群通告地址
–allow-privileged：启用授权
–service-cluster-ip-range：Service 虚拟 IP 地址段
–enable-admission-plugins：准入控制模块
–authorization-mode：认证授权，启用 RBAC 授权和节点自管理
–enable-bootstrap-token-auth：启用 TLS bootstrap 机制
–token-auth-file：bootstrap token 文件
–service-node-port-range：Service nodeport 类型默认分配端口范围
–kubelet-client-xxx：apiserver 访问 kubelet 客户端证书
–tls-xxx-file：apiserver https 证书
–etcd-xxxfile：连接 Etcd 集群证书
–audit-log-xxx：审计日志
```

复制之前生成的证书到对应的ssl文件夹中
```shell
# server.pem
# server-key.pem
# ca.pem
# ca-key.pem
# sa.pub
cp /opt/cert/*.pem /opt/module/kubernetes/ssl/
cp /opt/cert/sa.pub /opt/module/kubernetes/ssl/
```


启用 TLS Bootstrapping 机制
文档 https://kubernetes.io/docs/reference/access-authn-authz/kubelet-tls-bootstrapping/

TLS Bootstraping：Master apiserver 启用 TLS 认证后，Node 节点 kubelet 和 kube-proxy 要与 kube-apiserver 进行通信，必须使用 CA 签发的有效证书。当 Node 节点很多时，这种客户端证书颁发需要大量工作，同样也会增加集群扩展复杂度。
为了简化流程，Kubernetes 引入了 TLS bootstraping 机制来自动颁发客户端证书，kubelet 会以一个低权限用户自动向 apiserver 申请证书，kubelet 的证书由 apiserver 动态签署。所以强烈建议在 Node 上使用这种方式，目前主要用于 kubelet，kube-proxy 还是由我们统一颁发一个证书。

创建上述配置文件中需要用到的 token 文件
```shell
# 创建文件
vim /opt/module/kubernetes/cfg/token.csv

# 文件内容示例；前三个值可以是任何内容
02b50b05283e98dd0fd71db496ef01e8,kubelet-bootstrap,10001,"system:bootstrappers"

# 前面的token部分可使用如下方法生成
head -c 16 /dev/urandom | od -An -t x | tr -d ' '
```


创建 kube-apiserver 的 service 文件
```shell
vim /usr/lib/systemd/system/kube-apiserver.service

# 填入如下内容
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kube-apiserver.conf
ExecStart=/usr/bin/kube-apiserver $KUBE_APISERVER_OPTS
Restart=on-failure
[Install]
WantedBy=multi-user.target
```

启动并设置开机启动
```shell
systemctl daemon-reload
systemctl start kube-apiserver
systemctl enable kube-apiserver

systemctl status kube-apiserver
```


**kube-apiserver常见错误**
```shell
# 查看fail日志
journalctl -u kube-apiserver -f

# 出现类似下面这种错误，直接删除该错误参数
Error: unknown flag: --insecure-port

# 出现下面这种错误
service-account-issuer is a required flag, --service-account-signing-key-file and --service-account-issuer are required flags
# 1.20后需要添加service-account-issuer参数；因此需要生成pub
```


授权 kubelet-bootstrap 用户允许请求证书
```shell
kubectl create clusterrolebinding kubelet-bootstrap \
--clusterrole=system:bootstrappers \
--user=kubelet-bootstrap
```



##### (4) 部署 kube-scheduler
创建配置文件 kube-scheduler.conf
```shell
vim /opt/module/kubernetes/cfg/kube-scheduler.conf

# 填入如下内容
KUBE_SCHEDULER_OPTS="--v=2 \
--leader-elect \
--master=127.0.0.1:8080 \
--bind-address=127.0.0.1"
```
参数说明
```
–master：通过本地非安全本地端口 8080 连接 apiserver。
–leader-elect：当该组件启动多个时，自动选举（HA）
```

创建 kube-scheduler 的 service 文件
```shell
vim /usr/lib/systemd/system/kube-scheduler.service

# 填入如下内容
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kube-scheduler.conf
ExecStart=/usr/bin/kube-scheduler $KUBE_SCHEDULER_OPTS
Restart=on-failure
[Install]
WantedBy=multi-user.target
```

启动并设置开机启动
```shell
systemctl daemon-reload
systemctl start kube-scheduler
systemctl enable kube-scheduler

systemctl status kube-scheduler
```



##### (5) 部署 kube-controller-manager
创建配置文件 kube-controller-manager.conf
```shell
vim /opt/module/kubernetes/cfg/kube-controller-manager.conf 

# 填入如下内容
KUBE_CONTROLLER_MANAGER_OPTS="--v=2 \
--leader-elect=true \
--master=127.0.0.1:8080 \
--bind-address=127.0.0.1 \
--allocate-node-cidrs=true \
--cluster-cidr=10.244.0.0/16 \
--service-cluster-ip-range=10.0.0.0/24 \
--cluster-signing-cert-file=/opt/module/kubernetes/ssl/ca.pem \
--cluster-signing-key-file=/opt/module/kubernetes/ssl/ca-key.pem \
--root-ca-file=/opt/module/kubernetes/ssl/ca.pem \
--service-account-private-key-file=/opt/module/kubernetes/ssl/ca-key.pem"
```
参数说明
```
–cluster-signing-cert-file、–cluster-signing-key-file：自动为 kubelet 颁发证书的 CA，与 apiserver 保持一致
```

创建 kube-controller-manager 的 service 文件
```shell
vim /usr/lib/systemd/system/kube-controller-manager.service

# 填入如下内容
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kube-controller-manager.conf
ExecStart=/usr/bin/kube-controller-manager $KUBE_CONTROLLER_MANAGER_OPTS
Restart=on-failure
[Install]
WantedBy=multi-user.target
```

启动并设置开机启动
```shell
systemctl daemon-reload
systemctl start kube-controller-manager
systemctl enable kube-controller-manager

systemctl status kube-controller-manager
```


##### (6) 查看集群状态
```shell
kubectl get cs

# 显示如下信息表示运行正常
NAME                 STATUS    MESSAGE   ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   ok
```




#### 部署 Worker Node (子节点)
在 Worker Node 节点，必须安装 docker、flannel 和 kubernetes 系列组件（包括 kubelet 和 kube-proxy）。

##### (1) 创建工作目录并拷贝二进制文件/证书
```shell
mkdir -p /opt/module/kubernetes/{cfg,ssl,logs}
mkdir -p /opt/module/kubernetes/server/bin

# 在每台worker node节点执行，从主节点复制 kubelet,kubectl,kube-proxy 到子节点中
scp 192.168.255.205:/opt/module/kubernetes/server/bin/{kubelet,kubectl,kube-proxy} /opt/module/kubernetes/server/bin/
cp /opt/module/kubernetes/server/bin/{kubelet,kubectl,kube-proxy} /usr/bin/

# 从主节点复制相关证书到子节点中
scp 192.168.255.205:/opt/module/kubernetes/ssl/ca*.pem /opt/module/kubernetes/ssl/
# scp 192.168.255.205:/root/TLS/k8s/kube-proxy*.pem /opt/kubernetes/ssl/
```

##### (2) 部署 kubelet
创建配置文件 kubelet.conf
```shell
vim /opt/module/kubernetes/cfg/kubelet.conf

# 填入如下内容
KUBELET_OPTS="--v=2 \
--hostname-override=k8s-node1 \
--kubeconfig=/opt/module/kubernetes/cfg/kubelet.kubeconfig \
--bootstrap-kubeconfig=/opt/module/kubernetes/cfg/bootstrap.kubeconfig \
--config=/opt/module/kubernetes/cfg/kubelet-config.yml \
--cert-dir=/opt/module/kubernetes/ssl \
--pod-infra-container-image=lizhenliang/pause-amd64:3.0"
```
参数说明
```
–hostname-override：显示名称，集群中唯一
–network-plugin：启用 CNI
–kubeconfig：空路径，会自动生成，后面用于连接 apiserver
–bootstrap-kubeconfig：首次启动向 apiserver 申请证书
–config：配置参数文件
–cert-dir：kubelet 证书生成目录
–pod-infra-container-image：管理 Pod 网络容器的镜像
```

创建配置参数文件 kubelet-config.yml
```shell
vim /opt/module/kubernetes/cfg/kubelet-config.yml

# 填入如下内容
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
address: 0.0.0.0
port: 10250
readOnlyPort: 10255
cgroupDriver: cgroupfs
clusterDNS:
  - 10.0.0.2
clusterDomain: cluster.local
failSwapOn: false
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 2m0s
    enabled: true
  x509:
    clientCAFile: /opt/module/kubernetes/ssl/ca.pem
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 5m0s
    cacheUnauthorizedTTL: 30s
evictionHard:
  imagefs.available: "15%"
  memory.available: "100Mi"
  nodefs.available: "10%"
  nodefs.inodesFree: "5%"
  maxOpenFiles: "1000000"
  maxPods: "110"
```

生成 bootstrap.kubeconfig 文件
```shell
# apiserver IP:PORT
export KUBE_APISERVER="https://192.168.255.205:6443" 
# 与 token.csv 里保持一致
export KUBELET_BK_CONFIG_TOKEN="8042a7df0e4cdff3d6aee8dbe0faac8e" 

# 生成 kubelet bootstrap.kubeconfig 配置文件
kubectl config set-cluster kubernetes \
--certificate-authority=/opt/module/kubernetes/ssl/ca.pem \
--embed-certs=true \
--server=${KUBE_APISERVER} \
--kubeconfig=bootstrap.kubeconfig

# 设置客户端认证参数
kubectl config set-credentials "kubelet-bootstrap" \
--token=${KUBELET_BK_CONFIG_TOKEN} \
--kubeconfig=bootstrap.kubeconfig

# 设置上下文参数
kubectl config set-context default \
--cluster=kubernetes \
--user="kubelet-bootstrap" \
--kubeconfig=bootstrap.kubeconfig

# 设置默认上下文
kubectl config use-context default --kubeconfig=bootstrap.kubeconfig

# 注意要把生成的 `bootstrap.kubeconfig` 文件放到 `/opt/module/kubernetes/cfg/` 文件夹中
mv bootstrap.kubeconfig /opt/module/kubernetes/cfg
```

创建 kubelet 的 service 文件
```shell
vim /usr/lib/systemd/system/kubelet.service

# 填入如下内容
[Unit]
Description=Kubernetes Kubelet
After=docker.service
[Service]
EnvironmentFile=/opt/module/kubernetes/cfg/kubelet.conf
ExecStart=/usr/bin/kubelet $KUBELET_OPTS
Restart=on-failure
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
```

启动并设置开机启动
```shell
systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet

systemctl status kubelet
```









## Pod 控制器
Kubernetes 中内建了很多 controller（控制器），这些相当于一个状态机，用来控制 Pod 的具体状态和行为

**控制器类型**
ReplicationController 和 ReplicaSet
Deployment
DaemonSet
StateFulSet
Job/CronJob
Horizontal Pod Autoscaling


### ReplicationController 和 ReplicaSet
ReplicationController（RC）用来确保容器应用的副本数始终保持在用户定义的副本数，即如果有容器异常退出，会自动创建新的 Pod 来替代；多出来的容器也会自动回收；
在新版本的 Kubernetes 中建议使用 ReplicaSet 来取代 ReplicationController 。ReplicaSet 跟ReplicationController 没有本质的不同，只是名字不一样，并且 ReplicaSet 支持集合式的 selector；


### Deployment
Deployment 为 Pod 和 ReplicaSet 提供了一个声明式定义 (declarative) 方法，用来替代以前的ReplicationController 来方便的管理应用。典型的应用场景包括；
- 定义 Deployment 来创建 Pod 和 ReplicaSet
- 滚动升级和回滚应用
- 扩容和缩容
- 暂停和继续 Deployment


### DaemonSet
DaemonSet 确保全部（或者一些）Node 上运行一个 Pod 的副本。当有 Node 加入集群时，也会为他们新增一个Pod。当有 Node 从集群移除时，这些 Pod 也会被回收。删除 DaemonSet 将会删除它创建的所有 Pod
使用 DaemonSet 的一些典型用法：
- 运行集群存储 daemon，例如在每个 Node 上运行 glusterd 、 ceph
- 在每个 Node 上运行日志收集 daemon，例如 fluentd 、 logstash
- 在每个 Node 上运行监控 daemon，例如 Prometheus Node Exporter、 collectd 、Datadog 代理、New Relic 代理，或 Ganglia gmond


### Job
Job 负责批处理任务，即仅执行一次的任务，它保证批处理任务的一个或多个 Pod 成功结束


### CronJob
Cron Job 管理基于时间的 Job，即：
- 在给定时间点只运行一次
- 周期性地在给定时间点运行

使用前提条件：**当前使用的 Kubernetes 集群，版本 >= 1.8（对 CronJob）。对于先前版本的集群，版本 < 1.8，启动 API Server时，通过传递选项 --runtime-config=batch/v2alpha1=true 可以开启 batch/v2alpha1 API**

典型的用法如下所示：
- 在给定的时间点调度 Job 运行
- 创建周期性运行的 Job，例如：数据库备份、发送邮件


### StatefulSet
StatefulSet 作为 Controller 为 Pod 提供唯一的标识。它可以保证部署和 scale 的顺序
StatefulSet是为了解决有状态服务的问题（对应Deployments和ReplicaSets是为无状态服务而设计），其应用场景包括：
- 稳定的持久化存储，即Pod重新调度后还是能访问到相同的持久化数据，基于PVC来实现
- 稳定的网络标志，即Pod重新调度后其PodName和HostName不变，基于Headless Service（即没有Cluster IP的Service）来实现
- 有序部署，有序扩展，即Pod是有顺序的，在部署或者扩展的时候要依据定义的顺序依次依次进行（即从0到N-1，在下一个Pod运行之前所有之前的Pod必须都是Running和Ready状态），基于init containers来实现
- 有序收缩，有序删除（即从N-1到0）


### Horizontal Pod Autoscaling
使Pod水平自动缩放





























## Pod排错步骤
### 1 查看所有pod状态
```shell
kubectl get pods
```

### 2 查看问题pod详细信息
```shell
kubectl describe pod <NAME>
```
找出有问题的容器

### 3 查看问题容器信日志
```shell
# NAME1为pod名称；NAME2为问题容器名称
kubectl logs <NAME1> -c <NAME2>

# 如果当前pod只有一个容器，可以直接进行查看
kubectl logs <NAME>
```



## 查看证书信息
```shell
# 查看证书信息 pem/crt
openssl x509 -in <cert name> -text -noout
openssl x509 -in apiserver.crt -text -noout
openssl x509 -in server.pem -text -noout

# 查看CSR信息
openssl req -noout -text -in <csr name>
openssl req -noout -text -in myserver.csr

```


















