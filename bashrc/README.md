# bashrc

## Manual setup
Please update `dotfiles_ansible` in case of any changes!

1. Install stow
```
sudo apt update && sudo apt install stow
```

2. Remove existing bashrc stow
```
cd ~/dotfiles
stow -D bashrc
```

4. Apply bashrc stow
```
stow bashrc
```

5. Append to `~/.bashrc`
```
source ~/.my_bashrc
```

6. Restart terminal or source
```
source ~/.bashrc
```