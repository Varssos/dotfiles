#!/bin/bash


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


# What with tmux config?