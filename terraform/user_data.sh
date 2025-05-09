#!/bin/bash
yum update -y
yum install -y docker curl git conntrack
systemctl enable docker
systemctl start docker
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/bin/
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
mv minikube /usr/bin/
curl -LO https://get.helm.sh/helm-v3.14.4-linux-amd64.tar.gz
tar -zxvf helm-v3.14.4-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/
rm -rf linux-amd64 helm-v3.14.4-linux-amd64.tar.gz
usermod -aG docker ec2-user
su - ec2-user -c '
  export CHANGE_MINIKUBE_NONE_USER=true
  minikube start --driver=docker

  git clone https://github.com/danilloo/helm-minikube.git /tmp/app && cd /tmp/app
  helm install nginx-app ./helm-chart
'
mkdir -p /root/.kube
cp /home/ec2-user/.kube/config /root/.kube/config
chown root:root /root/.kube/config