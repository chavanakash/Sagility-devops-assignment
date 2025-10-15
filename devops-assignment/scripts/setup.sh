#!/bin/bash
set -e

echo "=== Starting VM Setup ==="

# Update system
echo "Updating system packages..."
apt-get update
apt-get upgrade -y

# Install basic utilities
echo "Installing basic utilities..."
apt-get install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    net-tools \
    ca-certificates \
    gnupg \
    lsb-release

# Install Docker
echo "Installing Docker..."
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Add azureuser to docker group
usermod -aG docker azureuser

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install Helm
echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Configure system for Kubernetes
echo "Configuring system for Kubernetes..."
modprobe br_netfilter
echo "br_netfilter" > /etc/modules-load.d/br_netfilter.conf

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

# Start Minikube as azureuser
echo "Starting Minikube..."
su - azureuser -c "minikube start --driver=docker --cpus=4 --memory=8192 --disk-size=50g"

# Configure kubectl for azureuser
su - azureuser -c "mkdir -p ~/.kube"
su - azureuser -c "minikube kubectl -- config view --raw > ~/.kube/config"
su - azureuser -c "chmod 600 ~/.kube/config"

# Enable Minikube addons
echo "Enabling Minikube addons..."
su - azureuser -c "minikube addons enable metrics-server"
su - azureuser -c "minikube addons enable ingress"

echo "=== VM Setup Complete ==="
echo "Please log in as azureuser to use Kubernetes"