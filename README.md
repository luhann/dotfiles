# dotfiles

Personal dotfiles for fish, Hyprland, Neovim, and more.

Colour palette: [patroclus](.chezmoitemplates/patroclus.yaml), generated from the patroclus design system and consumed by every themed config.

## OS

[Gentoo](https://wiki.gentoo.org/wiki/Main_Page) ~amd64.

## Management

I have upgraded my dotfile management to use [chezmoi](https://www.chezmoi.io/) for better multi-system dotfile management.
I used to use [GNU stow](https://www.gnu.org/software/stow/) to manage symlinking my dotfiles on new machines.

Run `./install.sh` on a new machine to install chezmoi and apply everything.

## Desktop Environment
I currently use [Hyprland](https://hyprland.org/) as my window manager, run as a systemd graphical session through [uwsm](https://github.com/Vladimir-csp/uwsm):
`exec uwsm start hyprland.desktop` from the tty1 login shell. waybar, dunst and hypridle run as systemd user services, and the session environment comes from `config.fish` (see `dot_config/uwsm/env`).
I also keep a [niri](https://github.com/YaLTeR/niri) config around as an alternative.

I used to use plasma with bspwm, in a similar manner to the examples below.
* [Setup i3/bspwm to run with plasma](https://userbase.kde.org/Tutorials/Using_Other_Window_Managers_with_Plasma)
* [An example from another user](https://www.reddit.com/r/unixporn/comments/64mihc/i3_kde_plasma_a_match_made_in_heaven/)

## Dependencies
Here is a list of the main dependencies and programs I use in my setup.

| Dependency | Description | Why/Where is it needed? |
| --- | --- | --- |
| `Hyprland` | Window manager | (explains itself) |
| `uwsm` | Wayland session manager | Runs Hyprland and its services under systemd's graphical session |
| `alacritty` | Terminal emulator | (explains itself) |
| `waybar` | Status bar | (explains itself) |
| `rofi` | Window switcher, application launcher and dmenu replacement | App launching, clipboard history picker (`fuzzel` on niri) |
| `dunst` | Notification daemon | (explains itself) |
| `awww` | Wallpaper daemon | Wallpapers |
| `grim` + `slurp` | Screenshot tools | Screenshot keybinds |
| `cliphist` + `wl-clip-persist` | Clipboard history and persistence | Clipboard keybinds |
| `fzf` | A command-line fuzzy finder | An interactive Unix filter for command-line that can be used with any list |
| `eza` | A modern version of ‘ls’ | (explains itself) |
| `playerctl` | Mpris command-line controller | Used to set media control keybinds |

### Fonts

Currently I use the following fonts for most of my configuration:
* Monaspace (Neon and Krypton) — terminals, editors, waybar
* Iosevka Nerd Font — rofi, dunst

Alternate fonts can be seen in the config files that use them.
