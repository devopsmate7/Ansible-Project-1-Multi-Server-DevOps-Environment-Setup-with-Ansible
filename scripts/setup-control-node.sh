#!/bin/bash
# ==========================================================
# Control Node Setup Script
# Installs Ansible and Python on the control node EC2
# ==========================================================

set -e

echo "============================================="
echo "🚀 Ansible Control Node Setup"
echo "============================================="

# Update system
echo "📦 Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

# Install Python
echo "🐍 Installing Python..."
sudo apt install -y python3 python3-pip

# Install Ansible
echo "⚙️  Installing Ansible..."
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Install Git
echo "📦 Installing Git..."
sudo apt install -y git

# Verify installations
echo ""
echo "============================================="
echo "✅ Installation Complete - Verifying..."
echo "============================================="
echo "🐍 Python:  $(python3 --version)"
echo "⚙️  Ansible: $(ansible --version | head -n1)"
echo "📦 Git:     $(git --version)"
echo "============================================="
echo ""
echo "🎯 Next Steps:"
echo "1. Copy your EC2 SSH key (.pem) to ~/.ssh/"
echo "2. Set permissions: chmod 400 ~/.ssh/your-key.pem"
echo "3. Update inventory.ini with 5 EC2 IPs"
echo "4. Run: ansible -i inventory.ini devops_servers -m ping"
echo "5. Run: ansible-playbook -i inventory.ini playbook.yml"
echo "============================================="
