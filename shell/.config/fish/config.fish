if status --is-login
    set -x PATH ~/bin $PATH ~/.cargo/bin ~/.local/bin /home/khonsu/applications/texlive/2020/bin/x86_64-linux
    set -x MANPATH ":/home/khonsu/applications/texlive/2020/texmf-dist/doc/man"
    set -x INFOPATH ":/home/khonsu/applications/texlive/2020/texmf-dist/doc/info"
end

set -Ux XDG_CURRENT_DESKTOP KDE
set -Ux GTK_USE_PORTAL "1"
set -Ux LIBVA_DRIVER_NAME radeonsi
set -Ux HISTCONTROL ignoreboth:erasedups
set -Ux EDITOR nvim

# load the currently set wal colour scheme
cat ~/.cache/wal/sequences &

# autojump keybindings
source /usr/share/autojump/autojump.fish
# fzf keybindings for voidlinux
source /usr/share/doc/fzf/key-bindings.fish

# All my aliases
# system aliases
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias ls="exa --long --header --git --color=auto --group-directories-first"
alias please="sudo"
alias top="htop"
alias night="sudo zzz"
alias off="sudo poweroff"

# editor aliases
alias vim="nvim"
alias code="code-oss"

# PS aliases.
alias psa='ps aux'
alias psg='ps aux | grep -i'

# Make cp & mv to be verbose.
alias cp='cp -v'
alias mv='mv -v'

# Updates.
alias update_os='sudo xbps-install -Su'

# theming aliases
alias wallpaper="wal -e -i ~/onedrive/wallpapers/"

# application aliases
alias foliate="com.github.johnfactotum.Foliate"

function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
end
