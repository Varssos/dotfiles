# kitty

## Manual setup
Please update `dotfiles_ansible` in case of any changes!

1. Install stow and kitty
```
sudo apt update && sudo apt install stow kitty -y
kitty --version
# Minimal version supported: 0.29
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