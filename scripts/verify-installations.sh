#!/bin/bash
# ==========================================================
# Verification Script
# Verify all tools are installed on all target EC2s
# ==========================================================

echo "============================================="
echo "🧪 Verifying DevOps Tools on All Target Nodes"
echo "============================================="

echo ""
echo "📦 Checking Git version on all servers..."
ansible -i inventory.ini devops_servers -m shell -a "git --version"

echo ""
echo "🐍 Checking Python version on all servers..."
ansible -i inventory.ini devops_servers -m shell -a "python3 --version"

echo ""
echo "🐳 Checking Docker version on all servers..."
ansible -i inventory.ini devops_servers -m shell -a "docker --version"

echo ""
echo "⚙️  Checking Terraform version on all servers..."
ansible -i inventory.ini devops_servers -m shell -a "terraform --version"

echo ""
echo "============================================="
echo "✅ Verification Complete"
echo "============================================="
