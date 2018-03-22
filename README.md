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
wget https://raw.githubusercontent.com/mohaijiang/k8s-install/master/kubeadm/kubeadm.yaml
kubeadm init --config=kubeadm.yaml
```

```
## 选择一个网络进行安装，本例选择calico
## 安装calico网络
kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
```


```
## node 节点 (mater节点安装后输出的join命令)
kubeadm join ....
```




## kubernete使用简单说明

+ [常用命令](/kubernetes常用命令.md)
+ [网络原理](/kubernetes网络.md)
+ [k8s存储官方文档](https://kubernetes.io/docs/concepts/storage/volumes/)

