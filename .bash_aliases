# --------------
# ls
# --------------

alias ll='ls -alF'
alias llt='ls -alF --sort time'
alias la='ls -A'
alias l='ls -CF'


# --------------
# autoit3
# --------------

alias ait3='/mnt/c/Program\ Files\ \(x86\)/AutoIt3/AutoIt3.exe'
alias ai3='/mnt/c/Program\ Files\ \(x86\)/AutoIt3/AutoIt3.exe'


# --------------
# git
# --------------

alias gst='git status'
alias gd='git diff'


# --------------
# python
# --------------

alias python="python3.13"
alias python3="python3.13"


# --------------
# herobot
# --------------

# build and run custom GWToolbox plugin
alias herobot-build='$CMAKE_MSVC_EXE --build "$GWTOOLBOX_BUILD_DIR" --config RelWithDebInfo --target HeroBotPlugin 2>&1 | tail -50'

# --------------
# devbox
# --------------

alias devbox-on="ssh proxmox 'pct start 103' && echo 'devbox starting — connect with: ssh max@192.168.0.203'"
alias devbox-off="ssh proxmox 'pct shutdown 103' && echo 'devbox shutting down'"
alias devbox="ssh max@192.168.0.203"


# --------------
# doppler
# --------------

alias dpl="doppler"

