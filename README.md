# DevOps Assignment - Node.js API Deployment

A simple Node.js Express API deployed on Azure Kubernetes cluster with complete CI/CD pipeline and monitoring setup.

## 📝 About The Project

This project demonstrates a complete DevOps workflow for deploying a REST API to Kubernetes on Azure. I built this as part of a DevOps Engineer interview assignment at Sagility.

### What I Built

- Simple Express.js API with health check endpoint
- Automated CI/CD pipeline using GitHub Actions
- Infrastructure provisioning with Terraform on Azure (East US 2 region)
- Kubernetes deployment on Minikube with monitoring stack

## 🚀 The Application

I created a basic Express.js REST API that runs on port 3005. It has two endpoints:

### Endpoints

**Root Endpoint**
```bash
GET /
```
Returns basic API information
```json
{
  "message": "Welcome to DevOps DevOps assignment API - Sagility",
  "version": "1.0.0",
  "status": "healthy"
}
```

**Health Check**
```bash
GET /health
```
Returns service health status
```json
{
  "status": "healthy",
  "service": "devops-demo-api",
  "uptime": 123.456
}
```

### Running Locally

```bash
# Install dependencies
npm install

# Run the application
npm start

# The API will be available at http://localhost:3005
```

## 🧪 Testing & Code Quality

### Unit Tests

I wrote unit tests using Jest and Supertest to ensure the API works correctly:

```bash
npm test
```

The tests cover:
- Root endpoint returns correct response
- Health endpoint returns 200 status
- Response format validation

### Code Linting

I used ESLint to maintain code quality:

```bash
npm run lint
```

The linting rules enforce:
- Consistent code style
- Error prevention
- Best practices

## 🐳 Docker Containerization

### Multi-Stage Dockerfile

I created a multi-stage Dockerfile to keep the image size small and secure:

**Stage 1 (Builder):** Installs all dependencies
**Stage 2 (Production):** Copies only production dependencies and runs as non-root user

This approach:
- Reduces final image size by ~60%
- Improves security by not including build tools
- Makes deployments faster

### .dockerignore

I added a `.dockerignore` file to exclude unnecessary files from the Docker build:
- node_modules (installed fresh in container)
- .git directory
- Test files
- Documentation

This makes the build context smaller and faster.

## ⚙️ CI/CD Pipeline

### GitHub Actions Workflow

I set up a GitHub Actions pipeline that runs automatically on every push to the main branch.

**Pipeline Stages:**

1. **Lint & Test**
   - Checks out code
   - Installs dependencies
   - Runs ESLint
   - Runs unit tests
   - Pipeline fails if tests fail

2. **Build & Push**
   - Only runs if tests pass
   - Builds Docker image using multi-stage build
   - Pushes to GitHub Container Registry
   - Tags with `latest` and commit SHA

The pipeline ensures that only tested and validated code gets deployed.

## ☸️ Kubernetes Deployment

### Deployment Configuration

I created Kubernetes manifests in the `k8s/` folder:

**deployment.yaml**
- 2 replicas for high availability
- Resource limits (CPU: 200m, Memory: 256Mi)
- Liveness and readiness probes
- Health checks on `/health` endpoint

**service.yaml**
- NodePort service (port 30080)
- Exposes the API externally
- Load balances between pods

The setup ensures:
- Self-healing: if a pod crashes, Kubernetes restarts it
- Zero-downtime: rolling updates
- Resource management: prevents one app from using all resources

## 🏗️ Infrastructure (Terraform)

### Azure Infrastructure Setup

I used Terraform to provision all the infrastructure on Azure. Everything is defined as code in the `terraform/` folder.

**What Terraform Creates:**

1. **Resource Group** - Container for all resources
2. **Virtual Network** - Private network (10.0.0.0/16)
3. **Subnet** - Smaller network (10.0.1.0/24)
4. **Network Security Group** - Firewall rules for SSH, HTTP, NodePorts
5. **Public IP** - Static IP to access the VM
6. **Network Interface** - Connects VM to network
7. **Virtual Machine** - Ubuntu server with 2 vCPUs

**Configuration:**
- Region: East US 2 (eastus2)
- VM Size: Standard_B2s (2 vCPUs, 4GB RAM)
- OS: Ubuntu 22.04 LTS

### Infrastructure as Code Benefits

- **Repeatable:** Can recreate exact same setup anytime
- **Version Controlled:** Infrastructure changes tracked in Git
- **Automated:** No manual clicking in Azure portal
- **Documented:** Code itself is documentation

### Setup Script

The VM automatically runs a setup script on first boot that installs:
- Docker
- kubectl
- Minikube

This makes the VM ready to run Kubernetes immediately.

## 📊 Monitoring

### Prometheus & Grafana

I deployed monitoring using Kubernetes manifests:

**Prometheus**
- Collects metrics from Kubernetes and pods
- Accessible on NodePort 30900
- Monitors cluster health and application performance

**Grafana**
- Visualizes metrics from Prometheus
- Accessible on NodePort 30300
- Default credentials: admin/admin

### Monitoring Setup

The monitoring stack helps to:
- Track application uptime
- Monitor resource usage (CPU, memory)
- Identify performance issues
- Set up alerts (future improvement)

## 📁 Project Structure

```
.
├── app.js                          # Express API application
├── app.test.js                     # Unit tests
├── package.json                    # Dependencies and scripts
├── Dockerfile                      # Multi-stage Docker build
├── .dockerignore                   # Files to exclude from build
├── .eslintrc.json                  # Linting configuration
├── .github/
│   └── workflows/
│       └── ci.yml                  # CI/CD pipeline
├── k8s/
│   ├── deployment.yaml             # Kubernetes deployment
│   ├── service.yaml                # Service definition
│   └── monitoring.yaml             # Prometheus & Grafana
├── terraform/
│   ├── main.tf                     # All infrastructure resources
│   ├── variables.tf                # Input variables
│   ├── outputs.tf                  # Output values
│   ├── terraform.tfvars.example    # Example configuration
│   └── scripts/
│       └── setup.sh                # VM initialization script
└── README.md                       # This file
```

## 🚀 Deployment Steps

### 1. Setup Azure Infrastructure

```bash
cd terraform

# Create your variables file
cp terraform.tfvars.example terraform.tfvars

# Edit and add your SSH key
nano terraform.tfvars

# Deploy infrastructure
terraform init
terraform apply

# Get VM IP
terraform output vm_public_ip
```

### 2. SSH to VM and Start Kubernetes

```bash
ssh azureuser@<VM_IP>

# Start Minikube
minikube start --driver=docker

# Verify
kubectl get nodes
```

### 3. Deploy Application

```bash
# Clone repository on VM
git clone https://github.com/YOUR_USERNAME/sagility-assignment.git
cd sagility-assignment

# Build image locally (fix for ARM/AMD architecture)
docker build -t devops-demo-api:local .
minikube image load devops-demo-api:local

# Deploy to Kubernetes
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Check status
kubectl get pods
```

### 4. Deploy Monitoring

```bash
kubectl apply -f k8s/monitoring.yaml

# Wait for pods
kubectl get pods -n monitoring
```

### 5. Access Services

- **API:** http://VM_IP:30080
- **Prometheus:** http://VM_IP:30900
- **Grafana:** http://VM_IP:30300

## 🛠️ Technologies Used

- **Application:** Node.js 18, Express.js
- **Testing:** Jest, Supertest
- **Linting:** ESLint
- **Containerization:** Docker
- **CI/CD:** GitHub Actions
- **Container Registry:** GitHub Container Registry (GHCR)
- **Cloud:** Microsoft Azure
- **IaC:** Terraform
- **Orchestration:** Kubernetes (Minikube)
- **Monitoring:** Prometheus, Grafana

## ⚠️ Known Issues & Future Improvements

### Current Limitations

1. **Single Node Cluster:** Using Minikube for demo. In production would use AKS (Azure Kubernetes Service)
2. **NodePort Service:** Using NodePort for simplicity. Production would use LoadBalancer with Ingress
3. **No TLS/SSL:** HTTP only. Would add HTTPS with Let's Encrypt in production
4. **Simple Monitoring:** Basic setup. Would add more dashboards and alerts

### Future Improvements

- [ ] Add database (PostgreSQL/MongoDB)
- [ ] Implement horizontal pod autoscaling
- [ ] Add Helm charts for easier deployment
- [ ] Set up proper logging (ELK stack)
- [ ] Add API authentication
- [ ] Implement HTTPS
- [ ] Add more comprehensive tests
- [ ] Set up staging environment

## 📝 What I Learned

This project helped me understand:
- End-to-end CI/CD pipeline setup
- Infrastructure as Code with Terraform
- Kubernetes deployments and services
- Multi-stage Docker builds
- GitHub Actions workflows
- Monitoring and observability basics

## 👤 Author

**Your Name**
- GitHub: [@chavanakash](https://github.com/chavanakash)

## 📄 License

This project is for educational purposes as part of a job interview assignment.
