# Ansible Ad-hoc Commands on Azure

Automated VM provisioning and management using Terraform and Ansible on Azure.

## Architecture

- **Infrastructure**: 4 Ubuntu VMs on Azure (2 web, 1 app, 1 db)
- **Networking**: Virtual network with public subnet
- **Automation**: Terraform for provisioning, Ansible for configuration

## What We Built

### Terraform Infrastructure

- Reused network module from external GitHub repository
- Created 4 VMs with count-based deployment
- Auto-generated Ansible inventory with public IPs
- Used `null_resource` with `local-exec` for inventory generation

### Ansible Configuration

- Dynamic inventory grouping: `[web]`, `[app]`, `[db]`
- SSH key-based authentication
- Host key verification disabled for new VMs

## Commands Executed

```bash
# Test connectivity
ansible all -i ./ansible/inventory.ini -m shell -a "whoami"

# Install nginx on app servers
ansible app -i ./ansible/inventory.ini -m apt -a "name=nginx state=present" --become

# Start and enable nginx service
ansible app -i ./ansible/inventory.ini -m service -a "name=nginx state=started enabled=yes" --become

# Check system info
ansible all -i ./ansible/inventory.ini -m setup -a "df -h"
```

## Key Learnings

- **Idempotency**: Ansible modules show "changed" vs "ok" based on actual system changes
- **Best Practices**: Use dedicated modules (`service`) over shell commands
- **Inventory Management**: Dynamic generation with Terraform outputs
- **SSH Configuration**: Proper key management and host verification settings

## File Structure

```ini
automation-on-azure/
├── terraform/
│   ├── main.tf              # Main infrastructure
│   ├── variables.tf         # Input variables
│   ├── outputs.tf          # Output values
│   └── modules/vm/         # VM module
└── ansible/
    ├── ansible.cfg         # Ansible configuration
    └── inventory.ini       # Generated inventory
```

## Next Steps

- Convert ad-hoc commands to playbooks
- Add configuration management for web servers
- Implement rolling deployments
- Add monitoring and logging setup
