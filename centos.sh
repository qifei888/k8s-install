#!/bin/bash
swapoff -a
mkdir -p /tmp/kubernetes
cd /tmp/kubernetes
echo "安装docker"
# curl -fsSL https://get.docker.com/ | sh -s -- --mirror Aliyun
yum install -y docker wget

echo "设置docker daemon.json"
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF

systemctl enable docker && systemctl restart docker

sed -i "s/overlay2/devicemapper/g" /etc/sysconfig/docker-storage

systemctl daemon-reload
systemctl restart docker

echo "设置系统变量"
cat > /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl -p /etc/sysctl.d/k8s.conf

setenforce 0


echo "安装kubernetes"
wget -qO- http://minio.test.onepoc.xonestep.com/mohaijiang/kubernetes/1.10.1/k8s_1.10.1_rpm.tar.gz | tar -zx
rpm -Uvh *.rpm  && rm -rf *.rpm

sed -i 'N;10i\Environment="KUBELET_EXTRA_ARGS=--pod-infra-container-image=registry.test.onepoc.xonestep.com/google_containers/pause-amd64:3.1"' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

systemctl daemon-reload
systemctl enable kubelet.service

echo "kubernetes 安装成功"
echo ""
echo "现在可以启动kubernetes"
echo ""
echo "master: "
echo "           wget https://raw.githubusercontent.com/mohaijiang/k8s-install/master/kubeadm/kubeadm.yaml"
echo "           kubeadm init --config=kubeadm.yaml "
echo ""
echo "master安装完成后，可以选择网络安装"
echo ""
echo "calico: "
echo "           kubectl apply -f https://raw.githubusercontent.com/mohaijiang/k8s-install/master/kubeadm/calico.yaml"
echo ""
echo "或者作为node节点join到kubernetes集群"
echo ""
