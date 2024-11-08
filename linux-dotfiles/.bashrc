#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# LOCAL >
# xiaomi work
# alias gotowork='ssh wangyuxuan@relay.xiaomi.com'
# alias exitwork='ssh -O exit wangyuxuan@relay.xiaomi.com'

# golang
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

# podman
alias podman='sudo podman'
alias podman-compose='sudo podman-compose'
#export DOCKER_BUILDKIT=0

# no longger need since we set autoProxy=true
# export no_proxy='172.16.*,10.*,192.168.*,127.*,localhost,<local>'
# export NO_PROXY='172.16.*,10.*,192.168.*,127.*,localhost,<local>'
# export https_proxy='http://127.0.0.1:23333'
# export HTTPS_PROXY='http://127.0.0.1:23333'
# export HTTP_PROXY='http://127.0.0.1:23333'
# export http_proxy='http://127.0.0.1:23333'

# LOCAL <

# EVERYWHERE >
    # alias
    alias ll='ls -l'
    # let cursor in tmux blink
    printf "\e[?12h"
    # bash history
    export HISTCONTROL=ignoredups
    export HISTSIZE=10000
    export HISTFILESIZE=10000
    # https://unix.stackexchange.com/questions/139115/disable-ctrl-d-from-closing-my-window-with-the-terminator-terminal-emulator
    # press three times ctrl+d can send EOF to terminal
    export IGNOREEOF=3
		# editor for tmux
		export EDITOR=vim
    # bash prompt PS1 >
        # Define Powerline symbols
        readonly PS_SYMBOL_DARWIN=''
        readonly PS_SYMBOL_LINUX='$'
        readonly PS_SYMBOL_OTHER='%'
        readonly GIT_BRANCH_CHANGED_SYMBOL='+'
        readonly GIT_NEED_PUSH_SYMBOL='⇡'
        readonly GIT_NEED_PULL_SYMBOL='⇣'

        # Check the operating system and set the prompt symbol accordingly
        case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
        esac

        # Function to get the current git branch
        function parse_git_branch {
        git branch 2> /dev/null | grep '*' | sed 's/* //'
        }

        # Function to check the git status
        function parse_git_dirty {
        [[ $(git status --porcelain 2> /dev/null | wc -l) -gt 0 ]] && echo "$GIT_BRANCH_CHANGED_SYMBOL"
        }

        # Function to get the current git status (pull and push indicators)
        function parse_git_ahead_behind {
        git rev-parse --is-inside-work-tree &> /dev/null || return
        local branch="$(git rev-parse --abbrev-ref HEAD)"
        local tracking_branch="$(git for-each-ref --format='%(upstream:short)' refs/heads/"${branch}")"
        local remote_ref="$(git rev-parse "${tracking_branch}" 2>/dev/null)"
        local local_ref="$(git rev-parse HEAD)"
        if [[ -n "${remote_ref}" ]]; then
            if [[ "${local_ref}" != "${remote_ref}" ]]; then
            local git_status="$(git rev-list --left-right --count "${local_ref}...${remote_ref}")"
            local behind_count="$(cut -f1 <<< "$git_status")"
            local ahead_count="$(cut -f2 <<< "$git_status")"
            if [[ "${behind_count}" -gt 0 ]]; then
                echo -n "$GIT_NEED_PULL_SYMBOL"
            fi
            if [[ "${ahead_count}" -gt 0 ]]; then
                echo -n "$GIT_NEED_PUSH_SYMBOL"
            fi
            fi
        fi
        }
        # Timer functions to calculate the execution time of each command 
        function timer_start {
            # Check if timer_start_time is unset or empty, then assign the date
            if [ -z "${timer_start_time:-}" ]; then
                timer_start_time=$(date +%s%N)
            fi
        }
        function timer_stop {
            local timer_end_time=$(date +%s%N) 
            local elapsed_time=$((timer_end_time - timer_start_time)) 
            timer_show=$(awk "BEGIN {printf \"%.3f\", $elapsed_time/1000000000}") 
            unset timer_start_time
        }
        trap 'timer_start' DEBUG
        # Function to construct the PS1 variable
        function set_bash_prompt {
            local reset_color="\[\033[00m\]"
            local path_color="\[\033[01;34m\]"
            local user_color="\[\033[01;32m\]"
            local branch_color="\[\033[01;33m\]"
            local status_color="\[\033[01;31m\]"
            local time_color=" \[\033[01;35m\] "

            PS1="${user_color}\u@\h${reset_color} ${path_color}\w${reset_color} "
            PS1+="${branch_color}\$(parse_git_branch)\$(parse_git_dirty)${reset_color} "
            PS1+="${status_color}\$(parse_git_ahead_behind)${reset_color} "
            PS1+="${time_color}[\${timer_show}s]${reset_color}\n${PS_SYMBOL} "
        }
        function update_prompt {
            timer_stop
            set_bash_prompt
        }
        # Set the prompt command to update PS1
        PROMPT_COMMAND=update_prompt
    # bash prompt PS1 <

# EVERYWHERE <
