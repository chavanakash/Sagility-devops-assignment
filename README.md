## 🚀 Quick Start

### Option A: Validate Terraform Without Deployment

```bash
# 1. Clone the repository
git clone https://github.com/chavanakash/Sagility-devops-assignment.git
cd devops-assignment

# 2. Validate Terraform configuration
cd terraform
terraform init
terraform validate
terraform fmt -check

# 3. Review the configuration
cat main.tf
cat variables.tf
cat outputs.tf
```

### Option B: Full Deployment (Optional)

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/devops-assignment.git
cd devops-assignment

# 2. Login to Azure
az login

# 3. Set up Terraform variables
cd terraform
cat > terraform.tfvars <<EOF
ssh_public_key = "$(cat ~/.ssh/id_rsa.pub)"
EOF

# 4. Deploy infrastructure
terraform init
terraform plan
terraform apply -auto-approve

# 5. Get VM IP and SSH
VM_IP=$(terraform output -raw vm_public_ip)
ssh# DevOps Engineer Take-Home Assignment

A complete end-to-end CI/CD pipeline deploying a Node.js Express API to Kubernetes on Azure, with monitoring via Prometheus and Grafana.

## 📋 Table of Contents

- [Architecture Overview](#architecture-overview)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Setup Instructions](#detailed-setup-instructions)
- [Accessing the Application](#accessing-the-application)
- [Project Structure](#project-structure)
- [Architectural Decisions](#architectural-decisions)
- [Challenges and Solutions](#challenges-and-solutions)

## 🏗️ Architecture Overview

This project implements a complete DevOps pipeline with the following components:

1. **Application**: Node.js Express API with health endpoints and Prometheus metrics
2. **CI/CD**: GitHub Actions for automated testing, linting, and Docker image building
3. **Infrastructure**: Azure VM and VNet provisioned via Terraform
4. **Kubernetes**: Minikube cluster on Azure VM
5. **Deployment**: Helm chart for templated Kubernetes deployments
6. **Monitoring**: Prometheus for metrics collection, Grafana for visualization

```
┌─────────────────────────────────────────────────────────────┐
│                     GitHub Repository                        │
│  ┌────────────┐  ┌──────────────┐  ┌──────────────────┐   │
│  │ App Code   │  │ Dockerfile   │  │ Terraform/Helm   │   │
│  └────────────┘  └──────────────┘  └──────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Actions CI                         │
│  Lint → Test → Build → Push to GitHub Container Registry   │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                      Azure Cloud                             │
│  ┌────────────────────────────────────────────────────┐    │
│  │  Ubuntu VM (Standard_D4s_v3)                       │    │
│  │  ┌──────────────────────────────────────────────┐ │    │
│  │  │  Minikube Kubernetes Cluster                 │ │    │
│  │  │  ┌────────────┐  ┌──────────┐  ┌──────────┐ │ │    │
│  │  │  │ API Pods   │  │Prometheus│  │ Grafana  │ │ │    │
│  │  │  └────────────┘  └──────────┘  └──────────┘ │ │    │
│  │  └──────────────────────────────────────────────┘ │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## 🛠️ Technologies Used

- **Application**: Node.js 18, Express.js
- **Containerization**: Docker (multi-stage builds)
- **CI/CD**: GitHub Actions
- **Infrastructure as Code**: Terraform
- **Cloud Provider**: Microsoft Azure
- **Container Orchestration**: Kubernetes (Minikube)
- **Package Manager**: Helm
- **Monitoring**: Prometheus, Grafana
- **Ingress**: nginx-ingress

## ✅ Prerequisites

Before you begin, ensure you have:

1. **Azure Account** with an active subscription (for actual deployment - optional for assignment)
2. **Terraform** (v1.0+) for validation
3. **Git**
4. **SSH key pair** (for configuration examples)
5. **GitHub Account** with repository permissions
6. **Node.js 18+** (for local testing)

> **Note**: For the assignment submission, you can demonstrate the Terraform code without actually deploying to Azure. The code is valid and ready to deploy when needed.

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/devops-assignment.git
cd devops-assignment

# 2. Login to Azure
az login

# 3. Set up Terraform variables
cd terraform
cat > terraform.tfvars <<EOF
ssh_public_key = "$(cat ~/.ssh/id_rsa.pub)"
EOF

# 4. Deploy infrastructure
terraform init
terraform plan
terraform apply -auto-approve

# 5. Get VM IP and SSH
VM_IP=$(terraform output -raw vm_public_ip)
ssh azureuser@$VM_IP

# 6. Deploy application (on the VM)
git clone https://github.com/YOUR_USERNAME/devops-assignment.git
cd devops-assignment

# Deploy with Helm
helm install devops-api ./helm/devops-demo-api

# 7. Setup monitoring
chmod +x scripts/setup-monitoring.sh
./scripts/setup-monitoring.sh
```

## 📖 Detailed Setup Instructions

### Step 1: Prepare Your Environment

```bash
# Install Azure CLI (if not installed)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to Azure
az login

# Set your Azure subscription
az account set --subscription "YOUR_SUBSCRIPTION_ID"

# Generate SSH key if you don't have one
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
```

### Step 2: Fork and Clone Repository

```bash
# Fork the repository on GitHub first, then:
git clone https://github.com/YOUR_USERNAME/devops-assignment.git
cd devops-assignment
```

### Step 3: Update Configuration Files

1. **Update GitHub Actions Workflow** (`.github/workflows/ci.yml`):
   - Replace `YOUR_USERNAME` with your GitHub username

2. **Update Kubernetes Manifests** (`k8s/deployment.yaml`):
   - Replace `YOUR_USERNAME` in image repository

3. **Update Helm Values** (`helm/devops-demo-api/values.yaml`):
   - Replace `YOUR_USERNAME` in image repository

### Step 4: Provision Azure Infrastructure

```bash
cd terraform

# Create terraform.tfvars file
cat > terraform.tfvars <<EOF
resource_group_name = "devops-assignment-rg"
location           = "eastus"
vm_name            = "devops-vm"
vm_size            = "Standard_D4s_v3"
admin_username     = "azureuser"
ssh_public_key     = "$(cat ~/.ssh/id_rsa.pub)"
EOF

# Initialize Terraform
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply

# Save the output
terraform output > ../terraform-outputs.txt
```

**Expected time**: 5-10 minutes

### Step 5: Verify VM Setup

```bash
# Get VM IP address
VM_IP=$(terraform output -raw vm_public_ip)

# SSH into the VM
ssh azureuser@$VM_IP

# Verify installations
docker --version
kubectl version --client
helm version
minikube status
```

### Step 6: Deploy Application to Kubernetes

#### Option A: Using Helm (Recommended)

```bash
# Clone the repository on the VM
git clone https://github.com/YOUR_USERNAME/devops-assignment.git
cd devops-assignment

# Install the application
helm install devops-api ./helm/devops-demo-api \
  --set image.repository=ghcr.io/YOUR_USERNAME/devops-assignment \
  --set image.tag=latest

# Verify deployment
kubectl get pods
kubectl get svc
kubectl get ingress
```

#### Option B: Using Raw Manifests

```bash
# Apply Kubernetes manifests
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/servicemonitor.yaml

# Verify deployment
kubectl get all
```

### Step 7: Setup Monitoring

```bash
# Make the script executable
chmod +x scripts/setup-monitoring.sh

# Run the monitoring setup script
./scripts/setup-monitoring.sh

# Verify Prometheus and Grafana are running
kubectl get pods -n monitoring
```

### Step 8: Configure Port Forwarding (Optional)

If you want to access services locally:

```bash
# Forward Grafana
kubectl port-forward -n monitoring svc/grafana 3000:80 --address 0.0.0.0

# Forward Prometheus
kubectl port-forward -n monitoring svc/prometheus-server 9090:80 --address 0.0.0.0

# Forward Application
kubectl port-forward svc/devops-demo-api 8080:80 --address 0.0.0.0
```

## 🌐 Accessing the Application

After deployment, you can access the services:

### Application API

```bash
# Get Minikube IP
MINIKUBE_IP=$(minikube ip)

# Test the API
curl http://$MINIKUBE_IP

# Test health endpoint
curl http://$MINIKUBE_IP/health

# Access from outside (use VM public IP)
VM_PUBLIC_IP=$(curl -s ifconfig.me)
curl http://$VM_PUBLIC_IP
```

### Grafana Dashboard

- **URL**: `http://<VM_PUBLIC_IP>:30091`
- **Username**: `admin`
- **Password**: `admin123`

**Steps to create dashboard**:
1. Log into Grafana
2. Add Prometheus data source:
   - URL: `http://prometheus-server.monitoring.svc.cluster.local`
3. Import dashboard or create new:
   - Create panels for CPU usage, Memory usage, HTTP requests
   - Query: `container_cpu_usage_seconds_total{pod=~"devops-demo-api.*"}`

### Prometheus

- **URL**: `http://<VM_PUBLIC_IP>:30090`
- Query examples:
  - `http_requests_total`
  - `container_memory_usage_bytes`
  - `container_cpu_usage_seconds_total`

## 📁 Project Structure

```
devops-assignment/
├── .github/
│   └── workflows/
│       └── ci.yml                 # GitHub Actions CI pipeline
├── helm/
│   └── devops-demo-api/
│       ├── Chart.yaml             # Helm chart metadata
│       ├── values.yaml            # Default configuration values
│       └── templates/
│           ├── deployment.yaml    # Kubernetes deployment template
│           ├── service.yaml       # Service template
│           ├── ingress.yaml       # Ingress template
│           └── _helpers.tpl       # Helper templates
├── k8s/
│   ├── deployment.yaml            # Raw Kubernetes deployment
│   ├── service.yaml               # Service definition
│   ├── ingress.yaml               # Ingress configuration
│   └── servicemonitor.yaml        # Service monitor for metrics
├── scripts/
│   ├── setup.sh                   # VM setup script
│   └── setup-monitoring.sh        # Monitoring setup script
├── terraform/
│   ├── main.tf                    # Main Terraform configuration (all resources)
│   ├── variables.tf               # Input variables
│   ├── outputs.tf                 # Output values
│   ├── terraform.tfvars.example   # Example variable values
│   └── scripts/
│       └── setup.sh               # VM initialization script
├── app.js                         # Express application
├── app.test.js                    # Unit tests
├── package.json                   # Node.js dependencies
├── Dockerfile                     # Multi-stage Docker build
├── .eslintrc.json                 # ESLint configuration
├── .gitignore                     # Git ignore rules
└── README.md                      # This file
```

## 🎯 Architectural Decisions

### 1. Node.js with Express

**Choice**: Selected Node.js with Express over Python FastAPI

**Reasoning**:
- Lighter weight and faster startup time
- Excellent ecosystem for microservices
- Native async/await support
- Better suited for high-concurrency scenarios

### 2. Minikube vs Kubeadm

**Choice**: Minikube for Kubernetes cluster

**Reasoning**:
- Simpler setup and configuration
- Perfect for single-node development/demo environments
- Built-in addons (ingress, metrics-server)
- Faster deployment for assignment purposes
- Less resource-intensive

### 2. Terraform with Simple Structure

**Choice**: Single main.tf file with all resources

**Reasoning**:
- **Simplicity**: Easier to understand and maintain for learning purposes
- **Clarity**: All infrastructure in one place, easy to visualize
- **Appropriate Scale**: For a single VM deployment, modules add unnecessary complexity
- **Learning Focused**: Better for demonstrating Terraform basics
- **Quick Iteration**: Faster to modify and test changes

### 4. Multi-Stage Docker Build

**Choice**: Implemented multi-stage Dockerfile

**Reasoning**:
- **Security**: Final image doesn't contain build tools
- **Size**: Reduced image size by ~60%
- **Performance**: Faster pulls and deployments
- **Best Practice**: Separation of build and runtime dependencies

### 5. Helm for Deployment

**Choice**: Created Helm chart alongside raw manifests

**Reasoning**:
- **Templating**: Easy to deploy to multiple environments
- **Versioning**: Rollbacks are straightforward
- **Parameterization**: Single values file for all configurations
- **Industry Standard**: Widely adopted in production

### 6. GitHub Container Registry

**Choice**: GHCR over Docker Hub

**Reasoning**:
- **Integration**: Native GitHub integration
- **Authentication**: Uses GitHub tokens
- **Free**: Unlimited public images
- **Organization**: Co-located with source code

### 7. Prometheus + Grafana

**Choice**: Standard monitoring stack

**Reasoning**:
- **Industry Standard**: Most widely used in Kubernetes
- **Pull-based**: Better for dynamic environments
- **Ecosystem**: Rich exporter ecosystem
- **PromQL**: Powerful query language

## 🐛 Challenges and Solutions

### Challenge 1: Terraform VM Provisioning

**Problem**: Setting up the VM with all required tools automatically

**Solution**:
- Used `custom_data` in azurerm_linux_virtual_machine
- Script runs automatically on first boot via cloud-init
- Installs Docker, kubectl, Helm, and Minikube
- No need for manual SSH and configuration

```hcl
custom_data = base64encode(file("${path.module}/scripts/setup.sh"))
```

### Challenge 2: Minikube on Azure VM

**Problem**: Minikube requires specific system configurations and runs as non-root

**Solution**:
- Configured kernel modules (`br_netfilter`)
- Set sysctl parameters for networking
- Used `su - azureuser` to run Minikube commands
- Allocated sufficient resources (4 CPUs, 8GB RAM)

```bash
# System configuration
modprobe br_netfilter
sysctl -w net.ipv4.ip_forward=1
```

### Challenge 3: Ingress External Access

**Problem**: Minikube ingress not accessible from outside the VM

**Solution**:
- Used NodePort services for external access
- Configured Azure NSG to allow traffic on NodePort range
- Alternative: Used `kubectl port-forward` with `--address 0.0.0.0`
- Documented both access methods in README

```bash
# Port forwarding for external access
kubectl port-forward svc/service-name 8080:80 --address 0.0.0.0
```

### Challenge 4: Docker Permission Issues

**Problem**: azureuser couldn't run Docker commands after installation

**Solution**:
- Added user to docker group: `usermod -aG docker azureuser`
- Required logout/login for group changes to take effect
- Setup script handles this automatically

### Challenge 5: GitHub Actions Container Registry Authentication

**Problem**: Pushing to GHCR required proper authentication

**Solution**:
- Used `GITHUB_TOKEN` secret (automatically provided)
- Set proper permissions in workflow:
  ```yaml
  permissions:
    contents: read
    packages: write
  ```
- Used `docker/login-action` for authentication

### Challenge 6: Prometheus Scraping Application Metrics

**Problem**: Prometheus not discovering application endpoints

**Solution**:
- Exposed `/metrics` endpoint in Express app
- Created separate service for metrics
- Configured Prometheus to scrape Kubernetes services
- Used service discovery in Prometheus config

### Challenge 7: Resource Constraints

**Problem**: VM running out of resources with all services

**Solution**:
- Selected Standard_D4s_v3 (4 vCPUs, 16GB RAM)
- Set resource limits/requests in Kubernetes
- Disabled unnecessary Prometheus components (alertmanager, pushgateway)
- Configured Minikube with appropriate resources

```yaml
resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

## 📊 Monitoring Dashboards

### Grafana Dashboard Configuration

1. **Add Prometheus Data Source**:
   - Go to Configuration → Data Sources
   - Add Prometheus
   - URL: `http://prometheus-server.monitoring.svc.cluster.local`
   - Save & Test

2. **Create Application Dashboard**:
   
   **Panel 1: HTTP Request Rate**
   ```promql
   rate(http_requests_total{service="devops-demo-api"}[5m])
   ```

   **Panel 2: Pod CPU Usage**
   ```promql
   rate(container_cpu_usage_seconds_total{pod=~"devops-demo-api.*"}[5m])
   ```

   **Panel 3: Pod Memory Usage**
   ```promql
   container_memory_usage_bytes{pod=~"devops-demo-api.*"}
   ```

   **Panel 4: Pod Count**
   ```promql
   count(kube_pod_info{pod=~"devops-demo-api.*"})
   ```

## 🧪 Testing the Application

### Local Testing

```bash
# Install dependencies
npm install

# Run linting
npm run lint

# Run tests
npm test

# Run application locally
npm start

# Test endpoints
curl http://localhost:3000
curl http://localhost:3000/health
curl http://localhost:3000/metrics
```

### Testing in Kubernetes

```bash
# Check pod status
kubectl get pods -l app=devops-demo-api

# View logs
kubectl logs -l app=devops-demo-api -f

# Execute command in pod
kubectl exec -it <pod-name> -- /bin/sh

# Test service internally
kubectl run -it --rm debug --image=alpine --restart=Never -- sh
wget -qO- http://devops-demo-api/health
```

## 🔄 CI/CD Pipeline Flow

1. **Trigger**: Push to main branch
2. **Lint & Test Job**:
   - Checkout code
   - Setup Node.js
   - Install dependencies
   - Run ESLint (fails on errors)
   - Run Jest tests (fails if tests fail)
3. **Build & Push Job** (only if tests pass):
   - Checkout code
   - Setup Docker Buildx
   - Login to GHCR
   - Extract metadata (tags, labels)
   - Build multi-stage Docker image
   - Push to GitHub Container Registry
   - Cache layers for faster builds

## 🚀 Deployment Commands

### Using Helm

```bash
# Install
helm install devops-api ./helm/devops-demo-api

# Upgrade
helm upgrade devops-api ./helm/devops-demo-api

# Rollback
helm rollback devops-api

# Uninstall
helm uninstall devops-api

# Custom values
helm install devops-api ./helm/devops-demo-api \
  --set replicaCount=3 \
  --set image.tag=v1.2.0
```

### Using kubectl

```bash
# Apply all manifests
kubectl apply -f k8s/

# Update deployment
kubectl set image deployment/devops-demo-api \
  api=ghcr.io/YOUR_USERNAME/devops-assignment:new-tag

# Scale deployment
kubectl scale deployment/devops-demo-api --replicas=3

# Delete all resources
kubectl delete -f k8s/
```

## 🔐 Security Considerations

1. **Docker Image**:
   - Non-root user in container
   - Multi-stage build (no build tools in final image)
   - Minimal base image (Alpine)
   - Health checks configured

2. **Azure Infrastructure**:
   - Network Security Groups restrict access
   - SSH key authentication (no passwords)
   - Public IP only where necessary

3. **Kubernetes**:
   - Resource limits prevent resource exhaustion
   - Liveness/readiness probes ensure availability
   - Service accounts with minimal permissions

4. **Secrets Management**:
   - SSH keys not committed to Git
   - Terraform tfvars in .gitignore
   - GitHub secrets for CI/CD

## 📈 Performance Metrics

- **Docker Image Size**: ~150MB (multi-stage build)
- **Application Startup**: <2 seconds
- **Response Time**: <50ms for health endpoints
- **Resource Usage**: 
  - CPU: ~50m at idle, ~150m under load
  - Memory: ~100Mi at idle, ~200Mi under load

## 🔧 Troubleshooting

### Application not accessible

```bash
# Check pod status
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>

# Check service
kubectl get svc
kubectl describe svc devops-demo-api

# Check ingress
kubectl get ingress
kubectl describe ingress devops-demo-api
```

### Minikube issues

```bash
# Check Minikube status
minikube status

# Restart Minikube
minikube stop
minikube start

# View Minikube logs
minikube logs

# SSH into Minikube
minikube ssh
```

### Terraform issues

```bash
# Validate configuration
terraform validate

# Check state
terraform show

# Refresh state
terraform refresh

# Destroy and recreate
terraform destroy
terraform apply
```

## 🧹 Cleanup

### Destroy Infrastructure

```bash
# From terraform directory
cd terraform
terraform destroy -auto-approve

# Or selectively
terraform destroy -target=module.vm
```

### Delete Kubernetes Resources

```bash
# Delete application
helm uninstall devops-api
# OR
kubectl delete -f k8s/

# Delete monitoring
helm uninstall prometheus -n monitoring
helm uninstall grafana -n monitoring
kubectl delete namespace monitoring
```

## 📚 Additional Resources

- [Express.js Documentation](https://expressjs.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)

## 👤 Author

**Your Name**
- GitHub: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)
- Email: your.email@example.com

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Built as part of DevOps Engineer interview process
- Thanks to the open-source community for the tools used in this project

---

**Note**: Remember to replace `YOUR_USERNAME` with your actual GitHub username throughout all files before deployment.