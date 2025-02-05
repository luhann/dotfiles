# dotfiles

Personal dotfiles for zsh, KDE, Firefox, and more.

## OS

[Gentoo](https://wiki.gentoo.org/wiki/Main_Page) ~amd64.

## Management

I use [GNU stow](https://www.gnu.org/software/stow/) to manage symlinking my dotfiles on new machines. The folders are structured so that I just have to run (for example) `stow i3` to have all my i3 configs symlinked to the correct place. 

## Desktop Environment
I currently use awesome as my window manager, with picom as the compositor.

I used to use plasma with bspwm, in a similar manner to the examples below.
* [Setup i3/bspwm to run with plasma](https://userbase.kde.org/Tutorials/Using_Other_Window_Managers_with_Plasma)
* [An example from another user](https://www.reddit.com/r/unixporn/comments/64mihc/i3_kde_plasma_a_match_made_in_heaven/)

## Dependencies
Here is a list of dependencies and programs I use in my setup.

| Dependency | Description | Why/Where is it needed? |
| --- | --- | --- |
| `awesome` | Window manager | (explains itself) |
| `picom` | Compositor | (explains itself) |
| `rofi` | Window switcher, application launcher and dmenu replacement | (explains itself) |
| `feh` | Image viewer and wallpaper setter | Screenshot previews, wallpapers |
| `fzf` | A command-line fuzzy finder  | An interactive Unix filter for command-line that can be used with any list |
| `eza` | A modern version of ‘ls’ | (explains itself) |
| `playerctl` | Mpris command-line controller | Used to set media control keybinds |

### Fonts
Currently I only use the following main font for most of my configuration:
* Iosevka Nerd Font

Alternate fonts can be seen in the config files that use them.

## Screenshots
A screenshot of my current setup.

<img src="screenshots/current.png" align="center"/>
