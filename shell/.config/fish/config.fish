export PATH="$HOME/.cargo/bin:$PATH"


source /usr/share/autojump/autojump.fish

# Customize to your needs...
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias ls="exa --long --header --git --color=auto --group-directories-first"
alias please="sudo"
alias wallpaper="wal -i ~/onedrive/wallpapers/"
alias top="htop"


function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
end
