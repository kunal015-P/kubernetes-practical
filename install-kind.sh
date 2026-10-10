#!/bin/bash

#install docker
sudo yum install docker -y
sudo systemctl enable docker --now
sudo usermod -aG docker $USER && newgrp docker

#install kubectl

ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && ARCH=amd64
[ "$ARCH" = "aarch64" ] && ARCH=arm64

K8S_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/${ARCH}/kubectl"

chmod +x kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl

#install kind

ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && ARCH=amd64
[ "$ARCH" = "aarch64" ] && ARCH=arm64

curl -Lo kind "https://kind.sigs.k8s.io/dl/v0.33.0/kind-linux-${ARCH}"

chmod +x kind
sudo mv kind /usr/local/bin/kind

