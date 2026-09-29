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

6. Setup kitty as default terminal (Ubuntu)
```
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Kitty Terminal'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'kitty'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control><Alt>t'
```

Expect:
Settings->Keyboard->View and Customize Shortcuts->Custom Shortcuts -> Add Shortcut
Name: kitty terminal
Command: kitty
Shortcut: ctrl + alt + t


## Known issues
If in your OS kitty version < 0.26 install from source and setup with:
https://sw.kovidgoyal.net/kitty/binary/
For Ubuntu:
Setup default terminal: https://linuxconfig.org/ubuntu-change-default-terminal-emulator
gsettings set org.gnome.desktop.default-applications.terminal exec '.local/bin/kitty'