# EpicBook App Deployment using Terraform + Ansible

Automated deployment of the EpicBook Node.js application on AWS EC2 using Terraform for infrastructure provisioning and Ansible for application configuration.

## Architecture

- **Infrastructure**: AWS VPC, EC2 instance, Security Groups
- **Application**: Node.js EpicBook app with MariaDB database
- **Web Server**: Nginx reverse proxy
- **Region**: ap-southeast-1 (Singapore)

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Ansible >= 2.9
- SSH key pair (`~/.ssh/id_rsa`)

## Quick Start

### 1. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

This creates:

- VPC with public subnet (10.0.0.0/16)
- EC2 instance (t2.micro, Amazon Linux 2023)
- Security groups (SSH, HTTP, HTTPS)
- Auto-generates Ansible inventory

### 2. Deploy Application

```bash
cd ../ansible
ansible-playbook -i inventory.ini site.yaml
```

This configures:

- System packages (Node.js, MariaDB, Nginx)
- EpicBook application from GitHub
- Database schema and seed data
- Nginx reverse proxy
- Systemd services

## Configuration

### Terraform Variables

- `prefix`: Resource naming prefix (default: "epkbk")
- `instance_type`: EC2 instance type (default: "t2.micro")
- `ami_id`: Amazon Linux 2023 AMI
- `ssh_key_pair`: SSH key configuration

### Ansible Variables

- `project_repo_url`: https://github.com/pravinmishraaws/theepicbook
- `db_name`: bookstore
- `db_user`: theepicbook
- Application runs on port 8080, proxied via Nginx on port 80

## Access

After deployment, access the application at:

```sh
http://<EC2_PUBLIC_IP>
```

## Cleanup

```bash
cd terraform
terraform destroy
```

## File Structure

```sh
├── README.md
├── ansible
│   ├── ansible.cfg
│   ├── inventory.ini
│   ├── site.yaml
│   ├── inventories
│   │   └── inventory.ini
│   ├── roles
│   │   ├── app
│   │   │   ├── handlers
│   │   │   │   └── main.yaml
│   │   │   ├── tasks
│   │   │   │   └── main.yaml
│   │   │   └── templates
│   │   │       └── my.cnf.j2
│   │   ├── database
│   │   │   └── tasks
│   │   │       └── main.yaml
│   │   ├── epicbook
│   │   │   ├── handlers
│   │   │   │   └── main.yaml
│   │   │   ├── tasks
│   │   │   │   └── main.yaml
│   │   │   └── templates
│   │   │       ├── config.json.j2
│   │   │       └── epicbook.service.j2
│   │   └── nginx
│   │       ├── handlers
│   │       │   └── main.yaml
│   │       ├── tasks
│   │       │   └── main.yaml
│   │       └── templates
│   │           └── nginx.conf.j2
│   └── vars
│       ├── env.yml
│       └── vault.yml
└── terraform
    ├── backend.tf
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── variables.tf
    └── modules
        ├── instance
        │   ├── main.tf
        │   ├── outputs.tf
        │   └── variables.tf
        └── vpc
            ├── main.tf
            ├── outputs.tf
            └── variables.tf
```
