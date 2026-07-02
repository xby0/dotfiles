# exit if non-interactive
case $- in
    *i*) ;;
      *) return;;
esac

# load secrets from doppler
eval "$(doppler secrets download --no-file --format env --project xby --config prd)"

# history options
HISTCONTROL=ignoreboth # omit duplicate or space-leading lines from history
HISTSIZE=10000 # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=20000

# shell options
shopt -s direxpand          # fix ls tab expansion
shopt -s histappend         # append to history file, no overwrites
shopt -s checkwinsize       # resize window after each command
shopt -s globstar           # enable glob expansion with "**"

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" 

# set debian chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then debian_chroot=$(cat /etc/debian_chroot); fi

# ------------------------------------------------------------------------------
# path
# ------------------------------------------------------------------------------

paths_start=(
	""
)

paths_end=(
	"$HOME/homelab/ha-tools"
)

# de-dupe
export PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!x[$0]++' | sed 's/:$//')

# custom
export PATH="$(IFS=:; echo "${paths_start[*]}"):$PATH:$(IFS=:; echo "${paths_end[*]}")"

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
fi

ssh-add -q $HOME/.ssh/devbox
ssh-add -q $HOME/.ssh/github
ssh-add -q $HOME/.ssh/homeassistant-honk
ssh-add -q $HOME/.ssh/pihole

# ------------------------------------------------------------------------------
# neovim
# ------------------------------------------------------------------------------

export XDG_CONFIG_HOME=~/.config

# ------------------------------------------------------------------------------
# python
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# herobot
# ------------------------------------------------------------------------------

# workspace
export HEROBOT_ROOT_DIR="$WSL_WINDOWS_HOME_DIR/gw/_HeroBot"

# GWToolbox build
export GWTOOLBOX_BUILD_DIR_WIN="$WINDOWS_HOME_DIR\\gw\\_HeroBot\\GWToolbox\\build"

# ------------------------------------------------------------------------------
# tmux
# ------------------------------------------------------------------------------
 
# re-attach to active session
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

# ------------------------------------------------------------------------------
# homeassistant
# ------------------------------------------------------------------------------

export HA_URL_LAN="http://$HA_IP_LAN:$HA_PORT_LAN"

# reload dashboard
ha-reload() {
    local dashboard="${1,,}"
    local view="${2,,}"

    if [[ -z "$dashboard" || -z "$view" ]]; then
        echo "Usage: ha-reload <dashboard> <view>" >&2
        return 1
    fi

    ssh ha "ha-api call homeassistant reload_all" && \
        echo "OK — http://$HA_IP_LAN:$HA_PORT_LAN/lovelace/$dashboard/$view"
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

export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# ------------------------------------------------------------------------------
# mUsT bE aT tHe EnD oF yOuR .bAsHrC
# ------------------------------------------------------------------------------

eval "$(starship init bash)"            # starship init
