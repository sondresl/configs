# Sondre Lunde
# .zshrc

# zmodload zsh/zprof

export LC_ALL=en_US.UTF-8

# autoload -Uz compinit && compinit
# autoload bashcompinit && bashcompinit
ZSH_DISABLE_COMPFIX="true"

# Autocomplete for k8s
# [[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# User configuration
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

setopt auto_cd

# Mouse support
set -g mode-mouse on
set -g mouse-resize-pane on

set -o emacs

# Homebrew Python 3
# export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH="/Users/sondrelunde/Library/Python/3.10/bin:$PATH"
export PATH="/Users/sondrelunde/.pyenv/versions/3.7.16/bin:$PATH"
#
# Homebrew wants this path
# export PATH="/usr/local/sbin:$PATH"

# Add ~/.local/bin to path (for various scripts)
export PATH="~/.local/bin:$PATH"

# Tex 
export PATH="/Library/TeX/texbin:$PATH"

# Gradle
export PATH=$PATH:/opt/gradle/gradle-7.3/bin

# Path for Go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Path for Haskell
[ -f "/Users/sondrelunde/.ghcup/env" ] && source "/Users/sondrelunde/.ghcup/env" # ghcup-env

export EDITOR="nvim"

# Rust / Cargo
source $HOME/.cargo/env

# Use vim to view man pages with colors
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# ZPLUG ===============================================================================
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  echo "Cloning fresh zplug ..."
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "plugins/git",   from:oh-my-zsh
zplug "skywind3000/z.lua"
zplug "romkatv/powerlevel10k", use:"powerlevel10k.zsh-theme"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load
# ==== End of zplug ==================================================================

export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"
source ~/.purepower

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Aliases
alias ls='exa --icons'
alias l='clear; exa -la --icons --group-directories-first --icons'
alias tree='exa -la -T --git-ignore'
alias scm='rlwrap /Applications/Racket\ v8.2/bin/plt-r5rs'
alias racket='rlwrap /Applications/Racket\ v8.2/bin/racket'
alias drracket='/Applications/Racket\ v8.2/DrRacket.app/Contents/MacOS/DrRacket &'
alias rpi='ssh pi@192.168.0.10'
alias vim='nvim'
alias sml='rlwrap sml'
alias swipl='rlwrap swipl'
alias tls='tmux ls'
alias ta='tmux a -t'
alias tn='tmux new -s'
alias timel='python ~/dev/Timeliste/timeliste.py Sondre Lunde IN2040 26-01-1993'
alias cat='bat --plain'

alias bra='git forgit checkout_branch'
alias gdiff='git forgit diff'
alias gl25='git log -n 25 --oneline'
alias ten='git log -n 10'
alias five='git log -n 5'

alias rmkube='kubectl delete deployments,pods,services,replicasets,statefulsets,cronjobs,daemonsets --all'
alias python='/usr/bin/python3'

alias cc='exec_common_commands'
alias rbup='git fetch upstream && git rebase upstream/master'
alias pushf='git fetch upstream && git rebase upstream/master && git push -f'
alias common='vim ~/.common_commands'

# alias gproxy='sudo ssh -f -nNT gitproxy'
# alias gproxy-status='sudo ssh -O check gitproxy'
# alias gproxy-off='sudo ssh -O exit gitproxy'
alias gproxy='~/dev/repositories/gitproxy-login-helper/devicelogin-helper/gproxy-auto.sh'
alias pim='/Users/sondrelunde/dev/repositories/markets/map-gists/azure-pim-activate/activate-pims.sh'

# Hub
# eval "$(hub alias -s)"

# Functions -----------------
take() {
    mkdir $1
    cd $1
}

copyAll() {
    cat $1/*.md | pbcopy
}

runhs() {
    ghcid $1 -r
}

### FZF Functions

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_zlua -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# Git
# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m --height ${FZF_TMUX_HEIGHT:-40%}) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Common commands
# 
exec_common_commands() {
  local cmd
  cmd=$(cat ~/.common_commands | fzf --height ${FZF_TMUX_HEIGHT:-40%}) && 
      eval $cmd
}

source ~/.fzf.zsh
bindkey '^X' fzf-cd-widget
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color auto'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"

# TMUX

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height ${FZF_TMUX_HEIGHT:-40%} --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# Shell performance testing
timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Shell prompt
# export STARSHIP_CONFIG=~/.config/shell/starship.toml
# eval "$(starship init zsh)"
