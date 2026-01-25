#!/bin/bash

sudo apt update
sudo apt install stow -y

# ------Setup bashrc------
BASHRC="$HOME/.bashrc"
SOURCE_LINE="source ~/.my_bashrc"

IS_PRESENT=$(grep -E '^\s*#?\s*source\s+~/.my_bashrc' "$BASHRC" | wc -l)

if [ "$IS_PRESENT" -lt 1 ]; then
    echo "source ~/.my_bashrc is not included in ~/.bashrc. Appending at the bottom"
    echo -e "\n$SOURCE_LINE" >> "$BASHRC"
else
    # Check if it's commented out
    IS_COMMENTED=$(grep -E '^\s*#\s*source\s+~/.my_bashrc' "$BASHRC" | wc -l)

    if [ "$IS_COMMENTED" -gt 0 ]; then
        echo "WARNING! source ~/.my_bashrc is commented in ~/.bashrc. Uncommenting it..."
        sed -i 's/^\s*#\s*source\s\+~\/.my_bashrc/source ~\/.my_bashrc/' "$BASHRC"
    else
        echo "source ~/.my_bashrc exists in ~/.bashrc. No need to append."
    fi
fi

stow bashrc
echo "Bashrc configuration applied."


# ------Setup tmux------
sudo apt install tmux git xclip -y # or xsel for tmux-yank

## Install tmux plugin manager (tpm)
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR/.git" ]; then
    echo "Installing tmux plugin manager (tpm)…"
    git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
else
    echo "tpm already installed, skipping"
fi

## Apply tmux configuration
stow tmux

## Install tmux plugins
~/.tmux/plugins/tpm/scripts/source_plugins.sh
~/.tmux/plugins/tpm/scripts/install_plugins.sh

## Source the tmux configuration
tmux source ~/.config/tmux/tmux.conf

echo "Tmux configuration applied."