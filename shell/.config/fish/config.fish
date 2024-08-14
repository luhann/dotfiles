set -gx PATH ~/bin $PATH ~/.cargo/bin ~/.local/bin /home/khonsu/applications/texlive/2024/bin/x86_64-linux ~/applications/cmdstan/bin/ ~/applications/xbps/usr/bin

set -gx GPG_TTY (tty)
set -gx HISTCONTROL ignoreboth:erasedups
set -gx EDITOR nvim
set -gx BROWSER /bin/firefox
set -gx FZF_DEFAULT_COMMAND "fd --type file --color=always"
set -gx XSECURELOCK_SAVER saver_mpv
set -gx XSECURELOCK_PASSWORD_PROMPT time_hex
set -gx XSECURELOCK_LIST_VIDEOS_COMMAND "fd . '/home/khonsu/pictures/lockscreen/'"
set -gx XSECURELOCK_IMAGE_DURATION_SECONDS 300
set -gx XSECURELOCK_SHOW_KEYBOARD_LAYOUT 0
set -gx XDG_CURRENT_DESKTOP kde

# All my aliases
# system aliases
alias preview="fzf --preview 'bat --color=always {}'"
alias ls="eza --long --header --git --color=auto --group-directories-first"
alias find="fd"
alias top="htop"
alias grep="rg"
alias off="sudo poweroff"

# editor aliases
alias vim="nvim"

# PS aliases.
alias psa='ps aux'
alias psg='ps aux | rg -i'

# Make cp & mv to be verbose.
alias cp='cp -v --reflink=auto'
alias mv='mv -v'

# Updates.
alias xup='sudo xbps-install -Su'
alias xrm='sudo xbps-remove -R'
alias xinstall='sudo xbps-install -S'
alias einstall="sudo emerge --ask --verbose"
alias eupdate="sudo emerge --ask --verbose --newuse --update --deep @world"
alias edepclean="sudo emerge --ask --depclean"
alias esync="sudo eix-sync"
alias esearch="eix"

# application aliases
alias obs="env XDG_CURRENT_DESKTOP= obs"
# Curl aliases
alias weather="curl -4 wttr.in/Cape+Town"

function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
end

gh completion --shell fish | source
zoxide init fish | source
starship init fish | source
