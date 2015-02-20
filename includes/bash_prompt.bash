#
# Clean and minimalistic Bash prompt
# Author: Artem Sapegin, sapegin.me
# 
# Inspired by: https://github.com/sindresorhus/pure & https://github.com/dreadatour/dotfiles/blob/master/.bash_profile
#
# Notes:
# - $local_username - username you don’t want to see in the prompt - can be defined in ~/.bashlocal : `local_username="admin"`
# - Colors ($RED, $GREEN) - defined in ../tilde/bash_profile.bash
#

# User color
case $(id -u) in
    0) user_color="$RED" ;;  # root
    *) user_color="$GREEN" ;;
esac

# Symbols
prompt_symbol="❯"
prompt_venv_symbol="☁ "

function __promptline_git_status {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1

  local added_symbol="● "
  local unmerged_symbol="✖ "
  local modified_symbol="✚ "
  local clean_symbol="✔ "
  local has_untracked_files_symbol="…"

  local ahead_symbol="↑ "
  local behind_symbol="↓ "

  local unmerged_count=0 modified_count=0 has_untracked_files=0 added_count=0 is_clean=""

  set -- $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
  local behind_count=$1
  local ahead_count=$2

  local branch
  local color=$RED

  # Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R), changed (T), Unmerged (U), Unknown (X), Broken (B)
  while read line; do
    case "$line" in
      M*) modified_count=$(( $modified_count + 1 )) ;;
      U*) unmerged_count=$(( $unmerged_count + 1 )) ;;
    esac
  done < <(git diff --name-status)

  while read line; do
    case "$line" in
      *) added_count=$(( $added_count + 1 )) ;;
    esac
  done < <(git diff --name-status --cached)

  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    has_untracked_files=1
  fi

  if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
  fi

  if [ $(( unmerged_count + modified_count + has_untracked_files + added_count )) -eq 0 ]; then
    is_clean=1
    color=$GREEN
  fi

  printf $color;
  [[ $branch ]] && { printf " %s" $branch;}
  [[ $ahead_count -gt 0 ]]         && { printf " %s" "$ahead_symbol$ahead_count"; }
  [[ $behind_count -gt 0 ]]        && { printf " %s" "$behind_symbol$behind_count"; }
  [[ $modified_count -gt 0 ]]      && { printf " %s" "$modified_symbol$modified_count"; }
  [[ $unmerged_count -gt 0 ]]      && { printf " %s" "$unmerged_symbol$unmerged_count"; }
  [[ $added_count -gt 0 ]]         && { printf " %s" "$added_symbol$added_count"; }
  [[ $has_untracked_files -gt 0 ]] && { printf " %s" "$has_untracked_files_symbol"; }
  [[ $is_clean -gt 0 ]]            && { printf " %s" "$clean_symbol"; }
  printf $NOCOLOR;
}

function prompt_command() {
    # Local or SSH session?
    local remote=
    [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

    # Git branch name and work tree status (only when we are inside Git working tree)
    local git_prompt=$(__promptline_git_status)

    # Virtualenv
    local venv_prompt=
    if [ -n "$VIRTUAL_ENV" ]; then
        venv_prompt=" $BLUE$prompt_venv_symbol$(basename $VIRTUAL_ENV)$NOCOLOR"
    fi

    # Only show username if not default
    local user_prompt=
    [ "$USER" != "$local_username" ] && user_prompt="$user_color$USER$NOCOLOR"

    # Show hostname inside SSH session
    local host_prompt=
    [ -n "$remote" ] && host_prompt="@$YELLOW$HOSTNAME$NOCOLOR"

    # Show delimiter if user or host visible
    local login_delimiter=
    [ -n "$user_prompt" ] || [ -n "$host_prompt" ] && login_delimiter=":"

    # Format prompt
    first_line="$user_prompt$host_prompt$login_delimiter$WHITE\w$NOCOLOR$git_prompt$venv_prompt"
    # Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
    # $? is a status of last command, should be processed every time prompt prints
    second_line="\`if [ \$? = 0 ]; then echo \[\$CYAN\]; else echo \[\$RED\]; fi\`\$prompt_symbol\[\$NOCOLOR\] "
    PS1="\n$first_line\n$second_line"

    # Multiline command
    PS2="\[$CYAN\]$prompt_symbol\[$NOCOLOR\] "

    # Terminal title
    local title="$(basename $PWD)"
    [ -n "$remote" ] && title="$title | $HOSTNAME"
    echo -ne "\033]0;$title"; echo -ne "\007"
}

# Show awesome prompt only if Git is istalled
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=prompt_command
