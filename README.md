# Automation With Ansible

Workstation setup for Ansible development with VS Code integration.

## Environment

- **OS**: macOS 14.x (Sonoma)
- **Python**: 3.11+ (installed via Homebrew)
- **Ansible**: 12.1.0 with core 2.19.3 (pip install)

## VS Code Extensions

- **Ansible**: Red Hat Ansible extension for syntax highlighting and IntelliSense
- **YAML**: YAML language support with validation
- **Python**: Python language support
- **GitLens**: Enhanced Git capabilities
- **EditorConfig**: Consistent coding styles

## SSH Configuration

- SSH keys stored in `~/.ssh/`
- Config file: `~/.ssh/config`
- Add your public keys to target hosts
- Never commit private keys to repository

## Git Configuration

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@company.com"
# Optional: GPG signing
git config --global user.signingkey <GPG_KEY_ID>
git config --global commit.gpgsign true
```

> Checkout [this medium blog](https://medium.com/big0one/how-to-create-a-verified-commit-in-github-using-gpg-key-signature-16acee004e0f?sk=f77eeb4e80048bcee5eab277f80fe22a) to setup signed commit

## Virtual Environment

```bash
# Create and activate venv
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run linting
ansible-lint playbooks/
yamllint .
```

## New Machine? Do This

- [ ] Install Homebrew and Python 3.11+
- [ ] Clone this repository
- [ ] Create and activate Python virtual environment
- [ ] Install requirements: `pip install -r requirements.txt`
- [ ] Install pre-commit hooks: `pre-commit install`
- [ ] Configure Git user name and email
- [ ] Generate SSH key pair and add to ssh-agent
- [ ] Install VS Code and required extensions
- [ ] Test Ansible connection to target hosts
- [ ] Run `ansible-lint` and `yamllint` to verify setup
- [ ] Create inventories directory and add your hosts
