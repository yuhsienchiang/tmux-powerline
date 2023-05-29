# tmux-powerline
## Intro

tmux-powerline is a light-weighted tmux plugin that gives you a powerline status bar with clean and aesthetic window segments.

This backbone of this plugin is derived from the [dracula/tmux](https://github.com/dracula/tmux) plugins. 

## Screenshot
![tmux-powerline screenshot](img/tmux-powerline.png)

## Install
1. Install the plugin manager [tpm](https://github.com/tmux-plugins/tpm) and make sure it works
2. Add the following line in your `.tmux.conf` file:
```
set -g @plugin 'yuhsienchiang/tmux-powerline'
```
3. Install the plugin with `<prefix> + I`


## Configuration
- Enabling window flags (default: `false`)
```
set -g @powerline-show-flags true
```

- Switch left segment icon (default: `smiley`)
It can accept `session`, `smiley`, `window`, or any character.
```
set -g @powerline-show-left-icon session
```

- Add padding to the left segment icon (default: `1`)
```
set -g @powerline-left-icon-padding 1
```

- Enable high contrast pane border (default: `false`)
```
set -g @powerline-border-contrast true
```

- Set the segment seperator symbol (default: shown as below)
```
set -g @powerline-show-left-sep 
set -g @powerline-show-left-head 
set -g @powerline-show-left-tail 
```

- Enable military time (default: `false`)
```
set -g @powerline-military-time true
```

- Adjust the refresh rate for the status bar (default: 5)
```
set -g @powerline-refresh-rate 5
```
