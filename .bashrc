# exit early if non-interactive shell
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth # omit duplicate or space-leading lines from history
HISTSIZE=10000 # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=20000

shopt -s direxpand # fix ls tab expansion
shopt -s histappend # append to history file, no overwrites
shopt -s checkwinsize # resize window after each command

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # make less more friendly for non-text input files

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then debian_chroot=$(cat /etc/debian_chroot); fi

# ------------------------------------------------------------------------------
# path
# ------------------------------------------------------------------------------

paths=(
	#"new/path/here"
	"$HOME/homelab/ha-tools"
)

# Remove duplicates
for p in "${EXTRA_PATHS[@]}"; do
    if [ -d "$p" ] && [[ ":$PATH:" != *":$p:"* ]]; then
        PATH="$PATH:$p"
    fi
done

export PATH

# ------------------------------------------------------------------------------
# bash
# ------------------------------------------------------------------------------

# set color prompt for xterm-color/*-256color terminal
case "$TERM" in xterm-color|*-256color) color_prompt=yes ;; esac 

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# richer colors
export COLORTERM=truecolor



# ------------------------------------------------------------------------------
# ssh
# ------------------------------------------------------------------------------

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    eval "$(ssh-add $HOME/.ssh/id_ed25519)" > /dev/null
fi


# ------------------------------------------------------------------------------
# neovim
# ------------------------------------------------------------------------------

export XDG_CONFIG_HOME=~/.config


# ------------------------------------------------------------------------------
# autoit3
# ------------------------------------------------------------------------------

export AI3_PATH='/mnt/c/Program Files (x86)/AutoIt3'
export AI3_EXE='$AI3_PATH/AutoIt3.exe'


# ------------------------------------------------------------------------------
# python
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# herobot
# ------------------------------------------------------------------------------

# workspace root directory ($HOME\gw\_HeroBot)
export HEROBOT_ROOT_DIR=/mnt/c/Users/maxwe/gw/_HeroBot

# GWToolbox build files
export GWTOOLBOX_BUILD_DIR="C:/Users/maxwe/gw/_HeroBot/GWToolbox/build"


# ------------------------------------------------------------------------------
# tmux
# ------------------------------------------------------------------------------
  
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    session_count=$(tmux list-sessions 2>/dev/null | wc -l)
    if [ "$session_count" -eq 0 ]; then
        tmux new-session
    elif [ "$session_count" -eq 1 ]; then
        tmux attach-session
    else
        echo "Multiple tmux sessions running ($session_count). Use 'tmux ls' to list them."
    fi
fi


# ------------------------------------------------------------------------------
# nvm
# ------------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # loads nvm bash_completion

# Created by `pipx` on 2026-05-29 01:20:18
export PATH="$PATH:/home/max/.local/bin"


# ------------------------------------------------------------------------------
# homeassistant
# ------------------------------------------------------------------------------

HA_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIwYmY1ZjU4MzNhZmI0M2FmYWRiNTAyZTE5MTMzNjJhOCIsImlhdCI6MTc3OTMwMzcwNSwiZXhwIjoyMDk0NjYzNzA1fQ.16kvBOFQO-f5YlUdq7cZ-72oT9mhWzMZX48z1WRWT4s"  # ha:/config/.env

ha-reload() {
    local dashboard="${1,,}"
    local view="${2,,}"

    if [[ -z "$dashboard" || -z "$view" ]]; then
        echo "Usage: ha-reload <dashboard> <view>" >&2
        return 1
    fi

    ssh ha "ha-api call homeassistant reload_all" && \
        echo "OK — http://192.168.0.200:8123/lovelace/$dashboard/$view"
}


# ------------------------------------------------------------------------------
# devbox
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# doppler
# ------------------------------------------------------------------------------

source <(doppler completion bash) 			# bash auto complete


# ------------------------------------------------------------------------------
# starship
# ------------------------------------------------------------------------------

# init below


# ------------------------------------------------------------------------------
# mUsT bE aT tHe EnD oF yOuR .bAsHrC
# ------------------------------------------------------------------------------

# de-dupe $PATH
export PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')

# starship init
eval "$(starship init bash)"
