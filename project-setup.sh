#!/bin/bash
# ===========================================================================
# File: project-setup.sh
set -e

PROJECT_ROOT="devops-assignment"

echo "🚀 Creating empty project structure for $PROJECT_ROOT ..."

# --- Create folders ---
mkdir -p $PROJECT_ROOT/.github/workflows
mkdir -p $PROJECT_ROOT/helm/devops-demo-api/templates
mkdir -p $PROJECT_ROOT/k8s
mkdir -p $PROJECT_ROOT/scripts
mkdir -p $PROJECT_ROOT/terraform/modules/network
mkdir -p $PROJECT_ROOT/terraform/modules/vm

# --- Create empty files ---
touch $PROJECT_ROOT/.github/workflows/ci.yml

touch $PROJECT_ROOT/helm/devops-demo-api/Chart.yaml
touch $PROJECT_ROOT/helm/devops-demo-api/values.yaml
touch $PROJECT_ROOT/helm/devops-demo-api/templates/deployment.yaml
touch $PROJECT_ROOT/helm/devops-demo-api/templates/service.yaml
touch $PROJECT_ROOT/helm/devops-demo-api/templates/ingress.yaml
touch $PROJECT_ROOT/helm/devops-demo-api/templates/_helpers.tpl

touch $PROJECT_ROOT/k8s/deployment.yaml
touch $PROJECT_ROOT/k8s/service.yaml
touch $PROJECT_ROOT/k8s/ingress.yaml
touch $PROJECT_ROOT/k8s/servicemonitor.yaml

touch $PROJECT_ROOT/scripts/setup.sh
touch $PROJECT_ROOT/scripts/setup-monitoring.sh

touch $PROJECT_ROOT/terraform/main.tf
touch $PROJECT_ROOT/terraform/variables.tf
touch $PROJECT_ROOT/terraform/outputs.tf
touch $PROJECT_ROOT/terraform/modules/network/main.tf
touch $PROJECT_ROOT/terraform/modules/network/variables.tf
touch $PROJECT_ROOT/terraform/modules/network/outputs.tf
touch $PROJECT_ROOT/terraform/modules/vm/main.tf
touch $PROJECT_ROOT/terraform/modules/vm/variables.tf
touch $PROJECT_ROOT/terraform/modules/vm/outputs.tf

touch $PROJECT_ROOT/app.js
touch $PROJECT_ROOT/app.test.js
touch $PROJECT_ROOT/package.json
touch $PROJECT_ROOT/Dockerfile
touch $PROJECT_ROOT/.eslintrc.json
touch $PROJECT_ROOT/.gitignore
touch $PROJECT_ROOT/README.md

echo "✅ Empty project structure created successfully at $PROJECT_ROOT"
