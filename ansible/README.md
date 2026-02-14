# Ansible Dotfiles Setup

This directory contains Ansible roles to automate the setup of `bashrc`, `tmux`, and `kitty` configurations.

## Quick Start

### Prerequisites
```bash
pip install ansible
```

### Run Setup (Standalone)

From the repository root:
```bash
./run_ansible.sh
```

Or manually:
```bash
cd ansible
ansible-playbook playbook.yml -i inventory/hosts.ini
```

## Usage as Git Submodule

If you want to use this repo as a submodule in another Ansible playbook:

### Add as Submodule
```bash
git submodule add https://github.com/yourusername/dotfiles.git roles/dotfiles
```

### Include in Your Playbook

In your main playbook, you can include the roles:

```yaml
---
- name: Setup system
  hosts: localhost
  connection: local
  become: true

  roles:
    - dotfiles/ansible/roles/common
    - dotfiles/ansible/roles/bashrc
    - dotfiles/ansible/roles/tmux
    - dotfiles/ansible/roles/kitty
```

Or include specific roles as needed:

```yaml
---
- name: Setup tmux only
  hosts: localhost
  connection: local
  become: true

  vars:
    dotfiles_path: "{{ playbook_dir }}/roles/dotfiles"

  roles:
    - dotfiles/ansible/roles/tmux
```

## Directory Structure

```
ansible/
├── playbook.yml              # Main playbook
├── ansible.cfg              # Ansible configuration
├── inventory/
│   └── hosts.ini            # Local inventory
├── group_vars/
│   └── all.yml              # Global variables
└── roles/
    ├── common/              # Common setup (stow, git, etc.)
    ├── bashrc/              # Bashrc configuration
    ├── tmux/                # Tmux setup and plugins
    └── kitty/               # Kitty terminal setup
```

## Variables

The main variable used across roles is:
- `dotfiles_path`: Path to the dotfiles repository (default: `{{ playbook_dir }}/..`)

You can override this when running the playbook:

```bash
ansible-playbook playbook.yml -i inventory/hosts.ini -e "dotfiles_path=/path/to/dotfiles"
```

## What Each Role Does

### common
- Updates apt cache
- Installs stow, git, wget, unzip

### bashrc
- Removes existing bashrc stow
- Ensures `source ~/.my_bashrc` is present in `~/.bashrc`
- Applies bashrc stow to create symlinks

### tmux
- Removes existing tmux stow
- Installs tmux and xclip
- Downloads and installs Meslo Nerd Font
- Rebuilds font cache
- Installs tmux plugin manager (tpm)
- Applies tmux stow
- Installs tmux plugins via tpm
- Sources tmux configuration

### kitty
- Removes existing kitty stow
- Installs kitty terminal
- Applies Catppuccin Mocha theme
- Applies kitty stow
- Ensures `include kitty-private.conf` in kitty.conf

## Running Specific Roles

You can run specific roles:

```bash
# Only setup bashrc
ansible-playbook playbook.yml -i inventory/hosts.ini --tags bashrc

# Skip tmux
ansible-playbook playbook.yml -i inventory/hosts.ini --skip-tags tmux
```

## Notes

- The playbook runs with `become: true` to allow sudo operations
- All file operations for symlinks use the non-root user account
- The playbook is idempotent - you can run it multiple times safely
- Font cache is rebuilt after installing Meslo fonts
- Errors in plugin installation are ignored to prevent full failure

## Troubleshooting

### Permission Denied
Make sure you can run `sudo` without password, or run with `--ask-become-pass`:

```bash
ansible-playbook playbook.yml -i inventory/hosts.ini --ask-become-pass
```

### Ansible Not Found
Install Ansible first:
```bash
pip install ansible
```

### Specific Role Fails
Run with verbose output:
```bash
ansible-playbook playbook.yml -i inventory/hosts.ini -vv
```

## Migration from setup_env.sh

The `setup_env.sh` script can still be used, but we recommend using Ansible for:
- **Idempotency**: Safe to run multiple times
- **Modularity**: Run specific components
- **Integration**: Easy to add to larger automation workflows
- **Submodule Support**: Include in other Ansible projects

The original `setup_env.sh` has been preserved for reference.
