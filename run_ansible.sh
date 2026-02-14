#!/bin/bash
set -e

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ANSIBLE_DIR="$SCRIPT_DIR/ansible"

# Check if ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo -e "${RED}Error: ansible-playbook is not installed.${NC}"
    echo "To install Ansible, run:"
    echo "  pip install ansible"
    exit 1
fi

# Run the playbook
cd "$ANSIBLE_DIR"

# If first argument is --no-password:
if [[ "$1" == "--no-password" ]]; then
    ansible-playbook playbook.yml -i inventory/hosts.ini -e 'ansible_become_password=""'
else
    ansible-playbook playbook.yml -i inventory/hosts.ini -K
fi