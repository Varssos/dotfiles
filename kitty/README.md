# kitty

## Manual setup
Please update `dotfiles_ansible` in case of any changes!

1. Install stow and kitty
```
sudo apt update && sudo apt install stow kitty -y
kitty --version
# Minimal version supported: 0.26
```

2. Remove existing kitty stow
```
cd ~/dotfiles
stow -D kitty
```

3. Apply Catppuccin Mocha theme
```
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

4. Apply kitty stow
```
cd ~/dotfiles
stow kitty
```

5. Append to `~/.config/kitty/kitty.conf`
```
include kitty-private.conf
```

## Known issues
If in your OS kitty version < 0.26 install from source and setup with:
https://sw.kovidgoyal.net/kitty/binary/
For Ubuntu:
Setup default terminal: https://linuxconfig.org/ubuntu-change-default-terminal-emulator
gsettings set org.gnome.desktop.default-applications.terminal exec '.local/bin/kitty'