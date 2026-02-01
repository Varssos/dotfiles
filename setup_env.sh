#!/bin/bash

sudo apt update
sudo apt install stow -y

# ------Setup bashrc------
function setup_bashrc(){
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
}



# ------Setup tmux------
function install_nerd_fonts(){
# Based on https://firstan.org/en/software/tmux-linux-mint/
    TMP_MESLO_DIR="/tmp/Meslo"

    wget -q -O /tmp/Meslo.zip \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip

    rm -rf "$TMP_MESLO_DIR"
    mkdir -p "$TMP_MESLO_DIR"

    unzip -q /tmp/Meslo.zip -d "$TMP_MESLO_DIR"
    rm /tmp/Meslo.zip

    sudo mv "$TMP_MESLO_DIR" /usr/share/fonts/opentype/Meslo
    fc-cache -f -v
}

function install_catppuccin_tmux_plugin(){
    CATPUCCIN_DIR="$HOME/.config/tmux/plugins/catppuccin"
    mkdir -p "$CATPUCCIN_DIR"
    if [ ! -d "$CATPUCCIN_DIR/tmux/.git" ]; then
        echo "Installing catppuccin/tmux plugin…"
        git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$CATPUCCIN_DIR/tmux"
    else
        echo "catppuccin/tmux plugin already installed, skipping"
    fi
}
function setup_tmux(){
    sudo apt install tmux git xclip -y # or xsel for tmux-yank

    ## Installl nerd fonts
    install_nerd_fonts

    ## Install tmux plugin manager (tpm)
    TPM_DIR="$HOME/.tmux/plugins/tpm"

    if [ ! -d "$TPM_DIR/.git" ]; then
        echo "Installing tmux plugin manager (tpm)…"
        git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
    else
        echo "tpm already installed, skipping"
    fi

    ## Install catppuccin/tmux plugin manually(due to issues with tpm)
    # install_catppuccin_tmux_plugin

    ## Apply tmux configuration
    mkdir -p ~/.config/tmux
    stow tmux

    ## Install tmux plugins
    ~/.tmux/plugins/tpm/scripts/source_plugins.sh
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh

    ## Source the tmux configuration
    tmux source ~/.config/tmux/tmux.conf

    echo "Tmux configuration applied."
}


# ------Setup kitty------

function setup_kitty(){
    sudo apt install kitty -y

    kitty +kitten themes --reload-in=all Catppuccin-Mocha

    mkdir -p ~/.config/kitty
    stow kitty

    # Ensure the main kitty.conf includes a private conf file
    KITTY_CONF="$HOME/.config/kitty/kitty.conf"
    INCLUDE_LINE="include kitty-private.conf"

    # ensure file exists so grep/sed won't fail
    if [ ! -f "$KITTY_CONF" ]; then
        touch "$KITTY_CONF"
    fi

    IS_INCLUDED=$(grep -E '^\s*include\s+kitty-private\.conf' "$KITTY_CONF" | wc -l)

    if [ "$IS_INCLUDED" -lt 1 ]; then
        IS_COMMENTED=$(grep -E '^\s*#\s*include\s+kitty-private\.conf' "$KITTY_CONF" | wc -l)

        if [ "$IS_COMMENTED" -lt 1 ]; then
            echo "Include line is not present in $KITTY_CONF. Appending at the bottom."
            echo -e "\n$INCLUDE_LINE" >> "$KITTY_CONF"
        else
            echo "WARNING! Include line is commented in $KITTY_CONF. Uncommenting it..."
            sed -i 's/^\s*#\s*include\s\+kitty-private\.conf$/include kitty-private.conf/' "$KITTY_CONF"
        fi
    else
        echo "Include line already exists in $KITTY_CONF. No need to append."
    fi

    echo "Kitty configuration applied."
}

# Execute setup functions
setup_bashrc
setup_tmux
setup_kitty