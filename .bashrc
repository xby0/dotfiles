# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# history length (max lines and max HISTFILE lines)
HISTSIZE=10000
HISTFILESIZE=20000

# resize the window after each command
shopt -s checkwinsize

# uncomment to enable "**" pathname expansion
#shopt -s globstar

# improve less compatability for non-text files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# capture chroot in new var for use in prompt below
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias llt='ls -alF --sort time'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#####################
# BEGIN USER CONFIG #
#####################

# --------------
# PATH
# --------------

#PATH="$PATH:/home/max/local/bin"

# --------------
# bash
# --------------

# Bind Up and Down arrows to search history with prefix
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


# --------------
# SSH
# --------------

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    eval "$(ssh-add $HOME/.ssh/id_ed25519)" > /dev/null
fi


# --------------
# CMake
# --------------

export CMAKE_MSVC_EXE='/mnt/c/Program\ Files/Microsoft\ Visual\ Studio/18/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe'


# --------------
# Utilities
# --------------

# ps -> tasklist.exe (dumping Windows system process information)
#alias ps='TaskList.exe' # TODO: replace with absolute path


# --------------
# AutoIt3
# --------------

export AI3_PATH='/mnt/c/Program Files (x86)/AutoIt3'
export AI3_EXE='$AI3_PATH/AutoIt3.exe'
alias ait3='/mnt/c/Program\ Files\ \(x86\)/AutoIt3/AutoIt3.exe'
alias ai3='/mnt/c/Program\ Files\ \(x86\)/AutoIt3/AutoIt3.exe'


# --------------
# Git
# --------------

alias gst='git status'


# =======================================
# ===             Python              ===
# =======================================

alias python="python3.13"
alias python3="python3.13"


# =======================================
# ===             HeroBot             ===
# =======================================

# Path to HeroBot workspace root directory ($HOME\gw\_HeroBot)
export HEROBOT_ROOT_DIR=/mnt/c/Users/maxwe/gw/_HeroBot

# Path to GWToolbox build files
export GWTOOLBOX_BUILD_DIR="C:/Users/maxwe/gw/_HeroBot/GWToolbox/build"

# Build and GWToolbox plugin with CMake
alias herobot-build='$CMAKE_MSVC_EXE --build "$GWTOOLBOX_BUILD_DIR" --config RelWithDebInfo --target HeroBotPlugin 2>&1 | tail -50'


# =======================================
# ===              tmux               ===
# =======================================
  
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


# =======================================
# ===              nvm                ===
# =======================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # loads nvm bash_completion

# Created by `pipx` on 2026-05-29 01:20:18
export PATH="$PATH:/home/max/.local/bin"


# =======================================
# ===        Home Assistant          ===
# =======================================

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

# devbox (LXC 103 @ 192.168.0.203)
alias devbox-on="ssh proxmox 'pct start 103' && echo 'devbox starting — connect with: ssh max@192.168.0.203'"
alias devbox-off="ssh proxmox 'pct shutdown 103' && echo 'devbox shutting down'"
alias devbox="ssh max@192.168.0.203"
