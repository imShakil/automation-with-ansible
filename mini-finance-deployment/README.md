# Mini Finance Project Deployment using Terraform + Ansible

Automated deployment of the Mini Finance web application using Terraform for infrastructure provisioning and Ansible for application deployment.

## Architecture

- **Infrastructure**: Azure VM with public IP
- **Web Server**: Nginx serving static files
- **Application**: Mini Finance project from GitHub
- **Automation**: Terraform + Ansible integration

## Prerequisites

- Azure CLI configured
- Terraform installed
- Ansible with `ansible.posix` collection
- SSH key pair (`~/.ssh/id_rsa`)

## Deployment

### 1. Infrastructure Provisioning

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

### 2. Application Deployment

```bash
cd ../ansible/
ansible-playbook -i inventory.ini site.yaml
```

## Components

### Terraform

- Creates Azure resource group and VM
- Configures networking with public subnet
- Generates Ansible inventory automatically
- Uses remote backend for state management

### Ansible

- Installs and configures Nginx
- Clones Mini Finance project from GitHub
- Syncs files to web root with proper permissions
- Restarts services

## Files

- `terraform/main.tf` - Infrastructure definition
- `terraform/variables.tf` - Configuration variables
- `ansible/site.yaml` - Deployment playbook
- `ansible/inventory.ini` - Auto-generated host inventory

## Access

After deployment, access the application at: `http://<VM_PUBLIC_IP>`
