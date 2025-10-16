#!/bin/bash
# This script runs automatically when the VM starts for the first time
# It installs Docker, kubectl, Helm, and starts Minikube

set -e
exec > >(tee /var/log/setup.log)
exec 2>&1

echo "========================================="
echo "Starting DevOps VM Setup"
echo "========================================="

# Update system
echo "[1/6] Updating system packages..."
apt-get update -y
apt-get upgrade -y

# Install basic tools
echo "[2/6] Installing basic utilities..."
apt-get install -y curl wget git vim htop net-tools

# Install Docker
echo "[3/6] Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ${admin_username}
systemctl enable docker
systemctl start docker

# Install kubectl
echo "[4/6] Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install Minikube
echo "[5/6] Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Configure system for Kubernetes
echo "[6/6] Configuring system for Kubernetes..."
modprobe br_netfilter
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl --system

echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo "Installed: Docker, kubectl, Minikube"
echo "Next steps:"
echo "1. SSH into VM: ssh ${admin_username}@VM_IP"
echo "2. Start Minikube: minikube start --driver=docker"
echo "3. Deploy application"
echo "========================================="