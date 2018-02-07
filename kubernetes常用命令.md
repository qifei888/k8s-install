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
kubectl run nginx --image=nginx

## 删除nginx部署
kubectl delete deploy nginx

## 将nginx容器服务导出网络端口
kubectl
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