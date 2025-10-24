#!/bin/bash

# Install git for submodules
sudo apt update
sudo apt install git-all -y

# Initialize and update git submodules
git submodule init
git submodule update --remote

# Setup bashrc
IS_MY_BASHRC_SOURCED=$(grep -E 'source.*.my_bashrc' ~/.bashrc | wc -l)

if [ $IS_MY_BASHRC_SOURCED -lt 1 ]; then
    echo "source .my_bashrc is not included in ~/.bashrc. Appending at the bottom"
    echo -e "\nsource $PWD/bashrc/.my_bashrc" >> ~/.bashrc
else
    IS_MY_BASHRC_COMMENTED=$(grep -E '^source.*.my_bashrc' ~/.bashrc | wc -l)
    if [ $IS_MY_BASHRC_COMMENTED -lt 1 ]; then
        echo "WARNING! source  .my_bashrc is commented in ~/.bashrc. Uncommenting it..."
        ESCAPED_PWD=$(echo "$PWD" | sed 's/\//\\\//g')
        sed -i "s/^#[ ]*source.*my_bashrc/source ${ESCAPED_PWD}\/bashrc\/.my_bashrc/" ~/.bashrc
    else
        echo "source .my_bashrc exist in ~/.bashrc. No need to append."
    fi
fi

# Setup git
if [ -f ~/.gitconfig ]; then
    echo "File ~/.gitconfig exist. Script will create a symbolic link only if it doesn't exist."
else
    echo "Creating symbolic link for ~/.gitconfig"
    ln -s $PWD/git/.gitconfig ~/.gitconfig
fi

# Setup ssh
if [ -f ~/.ssh/config ]; then
    echo "File ~/.ssh/config exist. Script will create a symbolic link only if it doesn't exist."
else
    echo "Creating symbolic link for ~/.ssh/config"
    ln -s $PWD/ssh/config ~/.ssh/config
fi

# Setup keybindings
sudo apt update
sudo apt-get install xbindkeys -y

if [ -f ~/.xbindkeysrc ]; then
    echo "File ~/.xbindkeysrc exist. Script will create a symbolic link only if it doesn't exist."
else
    echo "Creating symbolic link for ~/.xbindkeysrc"
    ln -s $PWD/keybindings/.xbindkeysrc ~/.xbindkeysrc
fi

# Restart xbindkeys to apply new configuration
killall xbindkeys
xbindkeys