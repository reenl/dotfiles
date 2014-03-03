# Git related Bash aliases

# `cd` to repo root
alias git-root='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
