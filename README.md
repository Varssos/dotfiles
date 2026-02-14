# dotfiles

Dotfiles which can be installed on my laptop, home server and work laptop.
Please don't place sensitive informations etc.

Currently keeping configs for:
- bashrc
- tmux
- kitty

## Setup with Ansible (Recommended)

### Quick Start

```bash
# Install Ansible (if not already installed)
pip install ansible

# Run the setup
./run_ansible.sh
```

Or manually:
```bash
cd ansible
ansible-playbook playbook.yml -i inventory/hosts.ini
```

### Usage as Git Submodule

You can add this repository as a git submodule to include in another Ansible playbook:

```bash
git submodule add https://github.com/yourusername/dotfiles.git submodules/dotfiles
```

Then in your main playbook:
```yaml
roles:
  - submodules/dotfiles/ansible/roles/common
  - submodules/dotfiles/ansible/roles/bashrc
  - submodules/dotfiles/ansible/roles/tmux
  - submodules/dotfiles/ansible/roles/kitty
```

For more details, see [ansible/README.md](ansible/README.md).

## Legacy Setup with Bash

The original bash setup script is still available:

```bash
./DEPRECATED_setup_env.sh
```
