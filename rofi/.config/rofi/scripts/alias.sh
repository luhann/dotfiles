# fetch all zsh aliases 
alias | awk -F'[ =]' '{print $1}'