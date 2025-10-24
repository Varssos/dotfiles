# keybinding

## Setup

### Install xbindkeys
```
sudo apt update
sudo apt-get install xbindkeys
```

### Create symbolic link for config

```
ln -s $PWD/.xbindkeysrc ~/.xbindkeysrc
```

### Restart xbindkeys 

Kill existing and 
```
killall xbindkeys
xbindkeys
```


## Useful xbindkeys commands

### Reload config in case of any changes
```
xbindkeys -p
```

### How to check what is 
```
xbindkeys -k
```

### What means that?
```
"xdotool key F3"
  b:9
```

xdotool - is a command-line tool that lets you simulate keyboard input and mouse activity
key - is the subcommand that tells xdotool to simulate a keypress
F3 - specifies which key to simulate (in this case, the F3 function key)