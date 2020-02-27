#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

DEFAULT_USER=khonsu

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias ls="exa --long --header --git --color=auto --group-directories-first"
alias please="sudo"
alias wallpaper="feh --bg-fill --randomize ~/onedrive/wallpapers/*"
alias top="htop"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source /etc/zsh_completion.d/fzf-key-bindings

# Set R library location
export R_LIBS_USER="/home/khonsu/rlibrary/"

# Set GPU driver for hardware encoding
export LIBVA_DRIVER_NAME=radeonsi

# Ignore duplicate history
export HISTCONTROL=ignoreboth:erasedups
