alias sudo='sudo HOME="$HOME" SSH_CLIENT="$SSH_CLIENT" SSH_TTY="$SSH_TTY"'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias svim='sudo vim'
alias fuck='sudo $(history -p \!\!)' #https://twitter.com/liamosaur/status/506975850596536320/
alias gitclean='git branch --merged master | grep -v "\smaster$" | grep -v "*" | xargs git branch -d'
alias fixcs='php-cs-fixer fix'
alias latest='git tag | sort -V | tail -n 1'
alias myip='curl -sS https://ip.reenlokum.nl'
alias service='sudo service'
alias dclean='docker images -q --filter "dangling=true" | xargs docker rmi  > /dev/null 2>&1'
alias punit='phpunit --no-coverage'
alias openvpn='sudo openvpn'
alias d=docker
alias dc=docker-compose
alias gh=

complete -F _docker d
complete -F _docker_compose dc

function grh() { history | grep "$1"; } #Grep through command history | Nice alternative for ctrl + r