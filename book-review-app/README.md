# Book Review Application

A full-stack book review application deployed using Terraform and Ansible on AWS.

## Architecture

- **Frontend**: Next.js application (port 3000)
- **Backend**: Node.js/Express API (port 3001)
- **Database**: MySQL RDS
- **Proxy**: Nginx reverse proxy (port 80)
- **Process Manager**: PM2

## Infrastructure

### AWS Resources

- VPC with public/private subnets
- 2 EC2 instances (frontend + backend)
- RDS MySQL database
- Security groups

### Deployment Flow

1. **Terraform**: Provisions AWS infrastructure
2. **Ansible**: Configures servers and deploys applications

## Quick Start

### 1. Deploy Infrastructure

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

### 2. Deploy Applications

```bash
cd ../ansible/
ansible-playbook -i inventory.ini bookreview.yaml
```

### 3. Access Application

- Frontend: `http://<frontend-public-ip>`
- API: `http://<frontend-public-ip>/api/books`

## Configuration

### Variables

- `terraform/variables.tf` - Infrastructure settings
- `ansible/group_vars/` - Application configuration

### Security

- RDS credentials in `group_vars/rds_info.yml`
- Use `ansible-vault` to encrypt sensitive data

## Architecture Details

### Network Flow

```txt
User → Nginx (port 80) → Frontend (port 3000)
                      → Backend (port 3001) → RDS
```

### Security Groups

- Frontend: Port 80 (HTTP) from internet
- Backend: Port 3001 from frontend subnet
- RDS: Port 3306 from backend subnet

## Troubleshooting

### Check Application Status

```bash
# On servers
pm2 status
pm2 logs <app-name>

# Test connectivity
curl http://localhost:3000  # Frontend
curl http://localhost:3001/api/books  # Backend
```

### Common Issues

- **CORS errors**: Check nginx origin headers
- **Database connection**: Verify RDS security groups
- **PM2 not starting**: Check ecosystem.config.js

## Clean Deployment

```bash
# Remove existing processes
ansible all -i inventory.ini -m shell -a "pm2 delete all || true"

# Remove app directories
ansible all -i inventory.ini -m file -a "path=/opt/backend state=absent" --become
ansible all -i inventory.ini -m file -a "path=/opt/frontend state=absent" --become

# Redeploy
ansible-playbook -i inventory.ini bookreview.yaml
```
