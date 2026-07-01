# --------------
# dotfiles
# --------------

alias dotfiles='~/dotfiles'

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
alias ga='git add'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gl='git log'
alias gr='git restore'
alias grs='git restore --staged'
alias gresoft='git reset --soft'
alias grehard='git reset --hard'

# semantic commit message helpers
# https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716

_gc_help() {
  echo ""
  echo "Usage:"
  echo ""
  echo "    gcch: \`git commit -m \"chore: <message>\"\`"
  echo "    gcft: \`git commit -m \"feat: <message>\"\`"
  echo "    gcdc: \`git commit -m \"docs: <message>\"\`"
  echo "    gcst: \`git commit -m \"style: <message>\"\`"
  echo "    gcrf: \`git commit -m \"refactor: <message>\"\`"
  echo "    gcts: \`git commit -m \"test: <message>\"\`"
  echo "    gcfx: \`git commit -m \"fix: <message>\"\`"
  echo ""

  return 0
}

_gc_do() {
  if [[ "$#" -gt 3 ]]; then
    echo "Semantic Commit Mesages: wrong number of arguments" >&2
    _gc_help && return 1
  fi
  git commit -m "$1: ${2}"
  return $?
}

gcch() {
  _gc_do "chore" $1
  return $?
}

gcft() {
  _gc_do "feat" $1
  return $?
}

gcdc() {
  _gc_do "docs" $1
  return $?
}

gcst() {
  _gc_do "style" $1
  return $?
}

gcrf() {
  _gc_do "refactor" $1
  return $?
}

gcts() {
  _gc_do "test" $1
  return $?
}

gcfx() {
  _gc_do "fix" $1
  return $?
}


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

