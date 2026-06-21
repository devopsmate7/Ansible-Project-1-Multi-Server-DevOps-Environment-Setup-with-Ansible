<div align="center">

# 🚀 Ansible Project 1
## Multi-Server DevOps Environment Setup with Ansible

[![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](.)
[![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)](.)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](.)
[![Servers](https://img.shields.io/badge/Servers-5%20Nodes-00C853?style=for-the-badge)](.)

### Automated installation of Git, Docker, Terraform, and Python across 5 AWS EC2 instances using Ansible

</div>

---

<!-- ==================== AGENDA ==================== -->

<table>
<tr>
<td>

## 📋 Agenda

| # | Step | Description |
|:---:|:---|:---|
| **1** | 🖥️ **Control Node Setup** | Create 1 EC2 and install Ansible + Python |
| **2** | 🖥️ **Target Nodes Setup** | Create 5 EC2 instances in AWS Console |
| **3** | 🔑 **SSH Configuration** | Setup passwordless SSH from control → targets |
| **4** | 📝 **Inventory Setup** | Add 5 EC2 IPs to `inventory.ini` |
| **5** | 🚀 **Run Playbook** | Execute `ansible-playbook` to install tools |
| **6** | ✅ **Verify Installation** | SSH into each EC2 and verify versions |

</td>
</tr>
</table>

---

<!-- ==================== ARCHITECTURE ==================== -->

<table>
<tr>
<td>

## 🏗️ Architecture Diagram

```
                            ┌─────────────────────────────────────┐
                            │      🖥️ ANSIBLE CONTROL NODE         │
                            │         (1 EC2 - Ubuntu)            │
                            │                                     │
                            │  ✅ Ansible                          │
                            │  ✅ Python                           │
                            │  ✅ Git                              │
                            │  📄 inventory.ini (5 IPs)            │
                            │  📄 playbook.yml                     │
                            │  📂 roles/                           │
                            └──────────────────┬──────────────────┘
                                               │
                                               │ SSH (Passwordless)
                                               │ Port 22
                                               │
            ┌──────────────────┬───────────────┼───────────────┬──────────────────┐
            │                  │               │               │                  │
            ▼                  ▼               ▼               ▼                  ▼
   ┌───────────────┐  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐
   │   🖥️ TARGET-1  │  │   🖥️ TARGET-2  │ │   🖥️ TARGET-3  │ │   🖥️ TARGET-4  │ │   🖥️ TARGET-5  │
   │               │  │               │ │               │ │               │ │               │
   │  📦 Git       │  │  📦 Git       │ │  📦 Git       │ │  📦 Git       │ │  📦 Git       │
   │  🐍 Python    │  │  🐍 Python    │ │  🐍 Python    │ │  🐍 Python    │ │  🐍 Python    │
   │  🐳 Docker    │  │  🐳 Docker    │ │  🐳 Docker    │ │  🐳 Docker    │ │  🐳 Docker    │
   │  ⚙️  Terraform│  │  ⚙️  Terraform│ │  ⚙️  Terraform│ │  ⚙️  Terraform│ │  ⚙️  Terraform│
   └───────────────┘  └───────────────┘ └───────────────┘ └───────────────┘ └───────────────┘
```

</td>
</tr>
</table>

---

<!-- ==================== PROJECT STRUCTURE ==================== -->

<table>
<tr>
<td>

## 📁 Project Structure

```
📦 Ansible-Project-1-Multi-Server-DevOps-Environment-Setup-with-Ansible/
│
├── 📄 README.md                       # Project documentation
├── 📄 ansible.cfg                     # Ansible configuration
├── 📄 inventory.ini                   # Target EC2 inventory (5 IPs)
├── 📄 playbook.yml                    # Main playbook
├── 📄 .gitignore                      # Git ignore rules
│
├── 📂 roles/                          # Ansible roles
│   ├── 📂 common/
│   │   └── tasks/main.yml             # System updates & basic packages
│   ├── 📂 python/
│   │   └── tasks/main.yml             # Python installation
│   ├── 📂 git/
│   │   └── tasks/main.yml             # Git installation
│   ├── 📂 docker/
│   │   └── tasks/main.yml             # Docker installation
│   └── 📂 terraform/
│       └── tasks/main.yml             # Terraform installation
│
└── 📂 scripts/                        # Helper scripts
    ├── setup-control-node.sh          # Setup Ansible on control node
    └── verify-installations.sh        # Verify tools on all targets
```

</td>
</tr>
</table>

---

<!-- ==================== STEP 1: CONTROL NODE ==================== -->

<table>
<tr>
<td>

## 🖥️ Step 1: Create Control Node (1 EC2)

### 1.1 Launch EC2 in AWS Console

| Setting | Value |
|:---|:---|
| **Name** | `ansible-control-node` |
| **AMI** | Ubuntu 22.04 LTS |
| **Instance Type** | `t2.micro` (free tier) |
| **Key Pair** | Create or use existing |
| **Security Group** | Allow SSH (22) from your IP |
| **Storage** | 8 GB |

### 1.2 SSH into Control Node

```bash
ssh -i your-key.pem ubuntu@<CONTROL-NODE-PUBLIC-IP>
```

### 1.3 Install Ansible & Python

```bash
# Clone this project
git clone https://github.com/devopsmate7/Ansible-Project-1-Multi-Server-DevOps-Environment-Setup-with-Ansible.git
cd Ansible-Project-1-Multi-Server-DevOps-Environment-Setup-with-Ansible

# Run setup script
bash scripts/setup-control-node.sh
```

**OR manually:**

```bash
sudo apt update -y
sudo apt install -y python3 python3-pip
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Verify
ansible --version
python3 --version
```

</td>
</tr>
</table>

---

<!-- ==================== STEP 2: TARGET NODES ==================== -->

<table>
<tr>
<td>

## 🖥️ Step 2: Create 5 Target EC2s (AWS Console)

### 2.1 Launch 5 EC2 Instances

| Setting | Value |
|:---|:---|
| **Names** | `target-1`, `target-2`, `target-3`, `target-4`, `target-5` |
| **AMI** | Ubuntu 22.04 LTS |
| **Instance Type** | `t2.micro` |
| **Number** | **5 instances** |
| **Key Pair** | Same as control node |
| **Security Group** | Allow SSH (22) from Control Node's IP |
| **Storage** | 8 GB each |

### 2.2 Collect Public IPs

Note down all 5 EC2 public IPs:

```
target-1: <IP-1>
target-2: <IP-2>
target-3: <IP-3>
target-4: <IP-4>
target-5: <IP-5>
```

</td>
</tr>
</table>

---

<!-- ==================== STEP 3: SSH SETUP ==================== -->

<table>
<tr>
<td>

## 🔑 Step 3: Setup SSH Access

### 3.1 Copy Private Key to Control Node

From your **local machine**:

```bash
scp -i your-key.pem your-key.pem ubuntu@<CONTROL-NODE-IP>:~/.ssh/
```

### 3.2 Set Correct Permissions

On **Control Node**:

```bash
chmod 400 ~/.ssh/your-key.pem
```

### 3.3 Test SSH to Targets

```bash
# Test connection to one target
ssh -i ~/.ssh/your-key.pem ubuntu@<TARGET-IP-1>
exit
```

</td>
</tr>
</table>

---

<!-- ==================== STEP 4: INVENTORY ==================== -->

<table>
<tr>
<td>

## 📝 Step 4: Configure Inventory

### 4.1 Update `inventory.ini`

Edit the file and replace placeholders with your **actual EC2 IPs** and **key file name**:

```ini
[devops_servers]
target1 ansible_host=54.x.x.1
target2 ansible_host=54.x.x.2
target3 ansible_host=54.x.x.3
target4 ansible_host=54.x.x.4
target5 ansible_host=54.x.x.5

[devops_servers:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/your-key.pem
ansible_python_interpreter=/usr/bin/python3
```

### 4.2 Test Ansible Connectivity

```bash
ansible -i inventory.ini devops_servers -m ping
```

**Expected output:**

```
target1 | SUCCESS => { "ping": "pong" }
target2 | SUCCESS => { "ping": "pong" }
target3 | SUCCESS => { "ping": "pong" }
target4 | SUCCESS => { "ping": "pong" }
target5 | SUCCESS => { "ping": "pong" }
```

</td>
</tr>
</table>

---

<!-- ==================== STEP 5: RUN PLAYBOOK ==================== -->

<table>
<tr>
<td>

## 🚀 Step 5: Run the Playbook

### 5.1 Syntax Check

```bash
ansible-playbook -i inventory.ini playbook.yml --syntax-check
```

### 5.2 Dry Run (Preview)

```bash
ansible-playbook -i inventory.ini playbook.yml --check
```

### 5.3 Run the Playbook 🚀

```bash
ansible-playbook -i inventory.ini playbook.yml
```

### 5.4 Run Specific Tags Only

```bash
# Only install Docker
ansible-playbook -i inventory.ini playbook.yml --tags docker

# Only install Terraform
ansible-playbook -i inventory.ini playbook.yml --tags terraform

# Only install Git
ansible-playbook -i inventory.ini playbook.yml --tags git

# Only install Python
ansible-playbook -i inventory.ini playbook.yml --tags python
```

</td>
</tr>
</table>

---

<!-- ==================== STEP 6: VERIFY ==================== -->

<table>
<tr>
<td>

## ✅ Step 6: Verify Installation

### 6.1 Quick Verification (from Control Node)

```bash
# Run verification script
bash scripts/verify-installations.sh
```

**OR manually:**

```bash
# Check Git
ansible -i inventory.ini devops_servers -m shell -a "git --version"

# Check Python
ansible -i inventory.ini devops_servers -m shell -a "python3 --version"

# Check Docker
ansible -i inventory.ini devops_servers -m shell -a "docker --version"

# Check Terraform
ansible -i inventory.ini devops_servers -m shell -a "terraform --version"
```

### 6.2 Manual Verification (SSH into each EC2)

```bash
# SSH into target-1
ssh -i ~/.ssh/your-key.pem ubuntu@<TARGET-IP-1>

# Run all verification commands
git --version
python3 --version
docker --version
terraform --version

# Exit and repeat for target-2 to target-5
exit
```

### 6.3 Expected Output

```
✅ git version 2.34.1
✅ Python 3.10.12
✅ Docker version 24.0.7, build afdd53b
✅ Terraform v1.6.6
```

</td>
</tr>
</table>

---

<!-- ==================== VERIFICATION CHECKLIST ==================== -->

<table>
<tr>
<td>

## 📊 Installation Checklist

| Server | Git ✅ | Python ✅ | Docker ✅ | Terraform ✅ |
|:---:|:---:|:---:|:---:|:---:|
| **target-1** | ⬜ | ⬜ | ⬜ | ⬜ |
| **target-2** | ⬜ | ⬜ | ⬜ | ⬜ |
| **target-3** | ⬜ | ⬜ | ⬜ | ⬜ |
| **target-4** | ⬜ | ⬜ | ⬜ | ⬜ |
| **target-5** | ⬜ | ⬜ | ⬜ | ⬜ |

</td>
</tr>
</table>

---

<!-- ==================== QUICK COMMANDS ==================== -->

<table>
<tr>
<td>

## ⚡ Quick Commands Reference

| Action | Command |
|:---|:---|
| **Setup Control Node** | `bash scripts/setup-control-node.sh` |
| **Test Ping** | `ansible -i inventory.ini devops_servers -m ping` |
| **Syntax Check** | `ansible-playbook -i inventory.ini playbook.yml --syntax-check` |
| **Dry Run** | `ansible-playbook -i inventory.ini playbook.yml --check` |
| **Run Playbook** | `ansible-playbook -i inventory.ini playbook.yml` |
| **Verbose Run** | `ansible-playbook -i inventory.ini playbook.yml -vv` |
| **Verify All** | `bash scripts/verify-installations.sh` |
| **Run Specific Tag** | `ansible-playbook -i inventory.ini playbook.yml --tags docker` |
| **List Hosts** | `ansible -i inventory.ini devops_servers --list-hosts` |
| **Ad-hoc Command** | `ansible -i inventory.ini devops_servers -m shell -a "uptime"` |

</td>
</tr>
</table>

---

<!-- ==================== TROUBLESHOOTING ==================== -->

<table>
<tr>
<td>

## 🔧 Troubleshooting

| Issue | Solution |
|:---|:---|
| **SSH permission denied** | Check key permissions: `chmod 400 ~/.ssh/your-key.pem` |
| **Host key verification failed** | Add `ansible_ssh_common_args='-o StrictHostKeyChecking=no'` in inventory |
| **Connection timeout** | Verify Security Group allows SSH from Control Node IP |
| **Sudo password required** | Add `become_password` or use `--ask-become-pass` |
| **Python not found** | Add `ansible_python_interpreter=/usr/bin/python3` in inventory |
| **Docker GPG key error** | Re-run with: `--tags docker` after clearing `/etc/apt/keyrings/` |

</td>
</tr>
</table>

---

<!-- ==================== AUTHOR ==================== -->

<div align="center">

## 👤 Author

**devopsmate7**

[![GitHub](https://img.shields.io/badge/GitHub-devopsmate7-181717?style=for-the-badge&logo=github)](https://github.com/devopsmate7)

---

<p>⭐ <b>Star this repository if you found it helpful!</b> ⭐</p>
<p>Made with ❤️ for DevOps Learning</p>

</div>
