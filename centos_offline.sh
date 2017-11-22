#!/bin/bash
echo "安装docker"
tar -zxvf docker-1.12-rpm.tar.gz
rpm -Uvh *.rpm && rm -rf *.rpm

echo "设置系统变量"
cat > /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl -p /etc/sysctl.d/k8s.conf

setenforce 0

echo "设置docker daemon.json"
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://registry.docker-cn.com"],
  "insecure-registries" : ["registry.one2.newtouch.com:5000"]
}
EOF

systemctl enable docker && systemctl restart docker

echo "安装kubernetes"
tar -zxvf k8s_1.8.1_rpm.tar
rpm -Uvh *.rpm && rm -rf *.rpm


echo "导入kubernetes镜像..."
tar -zxvf k8s_1.8.2_image.tar.gz
docker load -i k8s_1.8.2_image.tar
rm -rf k8s_1.8.2_image.tar
systemctl enable kubelet.service

echo "kubernetes 安装成功"
echo ""
echo "现在可以启动kubernetes"
echo ""
echo "master: "
echo "           kubeadm init --kubernetes-version=v1.8.2  --pod-network-cidr=10.244.0.0/16"
echo ""
echo "master安装完成后，可以选择网络安装"
echo ""
echo "flannel: "
echo "           kubectl apply -f https://raw.githubusercontent.com/mohaijiang/k8s-install/master/kube-flannel.yml"
echo "calico: "
echo "           kubectl apply -f https://raw.githubusercontent.com/mohaijiang/k8s-install/master/calico.yaml"
echo ""
echo "或者作为node节点join到kubernetes集群"
echo ""