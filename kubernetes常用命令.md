# kubernetes 常用命令

## node相关

```
## 查询所有node节点
kubectl get nodes

## 删除node节点
kubectl delete node <node name>


```

## 容器简单操作example
```
## 创建一个nginx 部署
kubectl create -f nginx/deployment.yaml
## 创建一个nginx 服务
kubectl create -f nginx/service.yaml
## 查看容器状态，等待容器启动完成
kubectl get po

NAME                   READY     STATUS              RESTARTS   AGE
nginx-8586cf59-gscc2   0/1       ContainerCreating   0          2s

## 当status是Running时容器启动成功
kubectl get po

NAME                   READY     STATUS    RESTARTS   AGE
nginx-8586cf59-gscc2   1/1       Running   0          20s

## 创建一个带网络volume的容器部署
kubectl create -f nginx/cephsecret.yaml
kubectl create -f nginx/deployment-with-ceph.yaml


## 清理环境
kubectl delete -f nginx

```



## pod相关
pod可以简单理解为docker的container概念
```
## 查询所有pod
kubectl get po --all-namespace

## 查看pod详细信息
kubectl describe po <pod name> [-n <namespace>]

## 删除pod
kubectl delete po <pod name> [-n <namespace>]

## 进入pod容器执行命令
kubectl [-n <namespace>] exec [-it]  <pod name> -- <command>
例如
kubectl exec -it nginx-xxx bash

## 查看容器日志
kubectl [-n <namespace>] logs [-f] <pod name>

```