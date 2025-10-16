#!/bin/bash
# Monitoring setup script
kubectl apply -f https://github.com/prometheus-operator/prometheus-operator/raw/main/bundle.yaml
echo "✅ Prometheus and monitoring stack setup completed!"
