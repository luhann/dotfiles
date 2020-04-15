# dotfiles

Personal dotfiles for zsh, KDE, Firefox, and more.

## Management

I use [GNU stow](https://www.gnu.org/software/stow/) to manage symlinking my dotfiles on new machines. The folders are structured so that I just have to run (for example) `stow i3` to have all my i3 configs symlinked to the correct place. 

## Desktop Environment
I currently use plasma on openSUSE Tumbleweed with bspwm as my window manager.
* [Setup i3/bspwm to run with plasma](https://userbase.kde.org/Tutorials/Using_Other_Window_Managers_with_Plasma)
* [An example from another user](https://www.reddit.com/r/unixporn/comments/64mihc/i3_kde_plasma_a_match_made_in_heaven/)

## Dependencies
Here is a list of dependencies and programs I use in my setup.

| Dependency | Description | Why/Where is it needed? |
| --- | --- | --- |
| `i3-gaps` | Window manager | (explains itself, not using at the moment) |
| `bspwm` | Window manager | (explains itself) |
| `picom` | Compositor | (explains itself) |
| `rofi` | Window switcher, application launcher and dmenu replacement | (explains itself) |
| `pulseaudio`, `libpulse` | Sound system **(Installed by default on most distros)** | Volume widgets and keybinds |
| `pywal` | Generate colour schemes | Used to automatically generate colour schemes from wallpaper |
| `redshift` | Controls screen temperature | Night mode command |
| `feh` | Image viewer and wallpaper setter | Screenshot previews, wallpapers |
| `fzf` | A command-line fuzzy finder  | An interactive Unix filter for command-line that can be used with any list |
| `exa` | A modern version of ‘ls’ | (explains itself) |
| `playerctl` | Mpris command-line controller | Used to set i3 media control keybinds |

### Fonts
Currently I only use the following three main fonts for most of my configuration:
* Iosevka Term Nerd Font
* MesloLGS Nerd Font 
* Hurmit Nerd Font 

## Screenshots
A screenshot of my current setup.

<img src="screenshots/current.png" align="center"/>
