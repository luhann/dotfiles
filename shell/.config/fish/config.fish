if status --is-login
    set -x PATH $PATH ~/bin ~/.cargo/bin ~/.local/bin /home/khonsu/applications/texlive/2019/bin/x86_64-linux
    set -x MANPATH ":/home/khonsu/applications/texlive/2019/texmf-dist/doc/man"
    set -x INFOPATH ":/home/khonsu/applications/texlive/2019/texmf-dist/doc/info"
end


set -Ux XDG_CURRENT_DESKTOP KDE
set -Ux GTK_USE_PORTAL "1"
set -Ux LIBVA_DRIVER_NAME radeonsi
set -Ux HISTCONTROL ignoreboth:erasedups
set -Ux EDITOR nvim

cat ~/.cache/wal/sequences &

source /usr/share/autojump/autojump.fish
source /usr/share/doc/fzf/key-bindings.fish

# Customize to your needs...
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias ls="exa --long --header --git --color=auto --group-directories-first"
alias please="sudo"
alias wallpaper="wal -i ~/onedrive/wallpapers/"
alias top="htop"
alias foliate="com.github.johnfactotum.Foliate"

function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
end
