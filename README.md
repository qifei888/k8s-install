# k8s-install
包括一些快速安装kubernetes的脚本

## 一行命令安装kubernetes

适用于 centos7
```
curl https://raw.githubusercontent.com/mohaijiang/k8s-install/master/centos.sh | sh
```

之后安装节点功能不同分别执行

```
## master节点
kubeadm init --kubernetes-version=v1.8.2  --pod-network-cidr=10.244.0.0/16
```

```
## 选择以下一个网络进行安装，flannel 或 calico
## 安装flannel网络
kubectl apply -f https://raw.githubusercontent.com/mohaijiang/k8s-install/master/kube-flannel.yml
## 安装calico网络
kubectl apply -f https://raw.githubusercontent.com/mohaijiang/k8s-install/master/calico.yaml
```


```
## node 节点 (mater节点安装后输出的join命令)
kubeadm join ....
```




## kubernete使用简单说明

+ [常用命令](/kubernetes常用命令.md)
+ [网络原理](/kubernetes网络.md)
+ [k8s存储官方文档](https://kubernetes.io/docs/concepts/storage/volumes/)

