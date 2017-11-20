#!/bin/bash
wget -qO- "http://minio.one2.newtouch.com:9000/mohaijiang/kubernetes/docker-1.12-rpm.tar.gz" | tar -zx
rpm -Uvh *.rpm && rm -rf *.rpm

cat > /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl -p /etc/sysctl.d/k8s.conf

setenforce 0

cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://registry.docker-cn.com"],
  "insecure-registries" : ["registry.one2.newtouch.com:5000"]
}
EOF

systemctl enable docker && systemctl restart docker

wget -qO- http://minio.one2.newtouch.com:9000/mohaijiang/kubernetes/1.8.1/k8s_1.8.1_rpm.tar | tar -zx
rpm -Uvh *.rpm && rm -rf *.rpm

wget -qO- http://minio.one2.newtouch.com:9000/mohaijiang/kubernetes/1.8.1/k8s_1.8.2_image.tar.gz | tar -zx
docker load -i k8s_1.8.2_image.tar
rm -rf k8s_1.8.2_image.tar
systemctl enable kubelet.service
