#!/bin/bash
# Setup script for VM initialization
sudo apt update -y
sudo apt install -y docker.io nodejs npm
sudo systemctl enable docker
sudo systemctl start docker
echo "✅ VM setup completed!"
