# CONFIGURATION
# The default configuration that can be overwritten in your .zshrc file

## PROMPT
INFOSTRIP_PROMPT_CHAR=${:-"\u276f "} #❱
INFOSTRIP_PROMPT_ORDER=${:-"hostname dir git ruby venv"}

## CONTEXT
INFOSTRIP_PROMPT_USER_BG=${:-default}
INFOSTRIP_PROMPT_USER_FG=${:-cyan}
INFOSTRIP_PROMPT_HOST_BG=${:-default}
INFOSTRIP_PROMPT_HOST_FG=${:-cyan}

## DIR
INFOSTRIP_DIR_BG=${:-default}
INFOSTRIP_DIR_FG=${:-blue}
INFOSTRIP_DIR_LEN=${:-0}

## TIME
INFOSTRIP_TIME_BG=${:-white}
INFOSTRIP_TIME_FG=${:-black}

## VIRTUALENV
INFOSTRIP_VIRTUALENV_BG=${:-default}
INFOSTRIP_VIRTUALENV_FG=${:-green}
INFOSTRIP_VIRTUALENV_PREFIX=${:-"\ue73c"} # or \ue606

## RUBY
INFOSTRIP_RUBY_BG=${:-default}
INFOSTRIP_RUBY_FG=${:-red}
INFOSTRIP_RUBY_PREFIX=${:-"\ue739"} # or \ue605
INFOSTRIP_RUBY_ALWAYS=${:-false}

## GIT
INFOSTRIP_GIT_BG=${:-default}
INFOSTRIP_GIT_FG=${:-white}
## GIT INFO
ZSH_THEME_GIT_PROMPT_PREFIX=${:-"\ue0a0 "} # or \ue702
ZSH_THEME_GIT_PROMPT_SUFFIX=${:-""}
ZSH_THEME_GIT_PROMPT_DIRTY=${:-"%F{red} ✘ %f"}
ZSH_THEME_GIT_PROMPT_CLEAN=${:-"%F{green} ✔ %f"}
ZSH_THEME_GIT_PROMPT_ADDED=${:-"%F{cyan}✚ %f"}
ZSH_THEME_GIT_PROMPT_MODIFIED=${:-"%F{blue}✹ %f"}
ZSH_THEME_GIT_PROMPT_DELETED=${:-"%F{red}✖ %f"}
ZSH_THEME_GIT_PROMPT_UNTRACKED=${:-"%F{yellow}✭ %f"}
ZSH_THEME_GIT_PROMPT_RENAMED=${:-"➜ "}
ZSH_THEME_GIT_PROMPT_UNMERGED=${:-"═ "}
ZSH_THEME_GIT_PROMPT_AHEAD=${:-"⬆ "}
ZSH_THEME_GIT_PROMPT_BEHIND=${:-"⬇ "}
ZSH_THEME_GIT_PROMPT_DIVERGED=${:-"⬍ "}

# SEGMENT DRAWING FUNCTION

infostrip_draw() {
    # INPUT -> $1: Background color,
    #          $2: Foreground color,
    #          $3: Function with data output
    # OUTPUT -> Data with background and foreground present

    print -n "%{%K{${1-default}}%F{${2-default}}$3 %k%f%}"
}

# PROMPT COMPONENTS

## User
user_infostrip() { infostrip_draw $INFOSTRIP_PROMPT_USER_BG $INFOSTRIP_PROMPT_USER_FG '%n' }

## Hostname
hostname_infostrip() { infostrip_draw $INFOSTRIP_PROMPT_HOST_BG $INFOSTRIP_PROMPT_HOST_FG '%m' }

## Context
context_infostrip() { print -n "$(user_infostrip)@$(hostname_infostrip) " }

## Status of last process and prompt
status_infostrip() { print -n '%(0?..%F{red}%?)'${INFOSTRIP_PROMPT_CHAR}%f }

## Directory
dir_infostrip() {

    local dir_info='%0~'

    if [[ $INFOSTRIP_DIR_LEN == 1 ]]; then
        dir_info='%1~'
    elif [[ $INFOSTRIP_DIR_LEN == 2 ]]; then
        dir_info='%2~'
    fi

    infostrip_draw $INFOSTRIP_DIR_BG $INFOSTRIP_DIR_FG $dir_info
}

## Time
time_infostrip() {

    if [[ $INFOSTRIP_TIME_12HR == true ]]; then
        infostrip_draw $INFOSTRIP_TIME_BG $INFOSTRIP_TIME_FG '%D{%r}'
    else
        infostrip_draw $INFOSTRIP_TIME_BG $INFOSTRIP_TIME_FG '%D{%X}'
    fi
}

## Git
git_infostrip() {

    if git rev-parse --is-inside-work-tree &> /dev/null; then
        local git_info="$(git_prompt_info) $(git_prompt_status)"
        infostrip_draw $INFOSTRIP_GIT_BG $INFOSTRIP_GIT_FG $git_info
    fi
}

## Chruby
ruby_infostrip() {

    if command -v chruby &> /dev/null; then
        if [[ $INFOSTRIP_RUBY_ALWAYS == true ]]; then
            infostrip_draw $INFOSTRIP_RUBY_BG $INFOSTRIP_RUBY_FG $INFOSTRIP_RUBY_PREFIX" $RUBY_VERSION"
        elif (ls *.rb || ls .ruby_version) &> /dev/null; then
            infostrip_draw $INFOSTRIP_RUBY_BG $INFOSTRIP_RUBY_FG $INFOSTRIP_RUBY_PREFIX" $RUBY_VERSION"
        fi
    fi
}

## Virtualenv
VIRTUAL_ENV_DISABLE_PROMPT=true
venv_infostrip() {

    if [[ -n $VIRTUAL_ENV ]]; then
        local venv_info=$(basename $VIRTUAL_ENV)
        infostrip_draw $INFOSTRIP_VIRTUALENV_BG $INFOSTRIP_VIRTUALENV_FG $INFOSTRIP_VIRTUALENV_PREFIX" $venv_info"
    fi
}

## VI-mode. Taken from (http://pawelgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/)
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
function TRAPINT() {
    vim_mode=$vim_ins_mode
    return $(( 128 + $1 ))
}

# MAIN
prompt_infostrip() {
  local prompt_array
  # Transform the order string in an Array
  for f in ${(A)=prompt_array::=${INFOSTRIP_PROMPT_ORDER}}; do
    ${f}_infostrip
  done
}

PROMPT='%{%f%b%k%}$(prompt_infostrip)
$(status_infostrip)'

RPROMPT='$vim_mode'
