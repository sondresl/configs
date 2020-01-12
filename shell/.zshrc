# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export LC_ALL=en_US.UTF-8


# User configuration
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Mouse support
set -g mode-mouse on
set -g mouse-resize-pane on

set -o emacs

# Homebrew Python 3
# export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
#
# Homebrew wants this path
export PATH="/usr/local/sbin:$PATH"

# added by Anaconda3 5.0.0 installer (Copied from .bash_profile)
export PATH="/Users/sondrelunde/anaconda3/bin:$PATH"

# Add path for SML
export PATH=/usr/local/smlnj/bin:$PATH

# Add path for ABS
export PATH=/Users/sondrelunde/dev/UiO/master/abstools/frontend/bin/bash:$PATH

export AOC='53616c7465645f5ffc3eea7ff953a35fa10ac6c7697f33a971f7453bd5e082b26a84ec2f29b815a19f95b15817e3e10c'

# ZPLUG ===============================================================================
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

    zplug "plugins/git",   from:oh-my-zsh
    zplug "rupa/z", use:"z.sh"
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

source ~/.purepower

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Aliases
alias k='javac *java'
alias j='java'
alias jc='rm *.class'
alias l='clear; exa -la --group-directories-first'
alias ls='exa'
alias uio='ssh -YC sondrslu@login.ifi.uio.no'
alias uiofiler='sshfs sondrslu@login.uio.no: ~/uio -o reconnect,modules=iconv,from_code=utf8'
alias scm='rlwrap /Applications/Racket\ v7.4/bin/plt-r5rs'
alias racket='rlwrap /Applications/Racket\ v7.4/bin/racket'
alias drracket='/Applications/Racket\ v7.4/DrRacket.app/Contents/MacOS/DrRacket &'
alias rpi='ssh pi@192.168.0.10'
alias vim='nvim'
alias ff='fzf-tmux'
alias sml='rlwrap sml'
alias swipl='rlwrap swipl'
alias tls='tmux ls'
alias ta='tmux a -t'
alias ml='rlwrap python /Users/sondrelunde/Workspace/Koding/minilisp/minilisp.py /Users/sondrelunde/Workspace/Koding/minilisp/lib.mini'
alias rasp='/Users/sondrelunde/Workspace/Koding/Rust/rasp/target/release/rasp'
alias tree='exa -la -T'
alias host='cd ~/dev/UiO/H19'
alias timel='python ~/dev/Timeliste/timeliste.py Sondre Lunde IN2040 26-01-1993'
alias vimo='vim -O'
alias todo='vim ~/.todo.md'

# Hub
eval "$(hub alias -s)"

# Functions -----------------
take() {
    mkdir $1
    cd $1
}

copyAll() {
    cat $1/retting.md
    grep poeng $1/retting.md
}

runhs() {
    ghcid $1 -r
}

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

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

source ~/.fzf.zsh
bindkey '^X' fzf-cd-widget
export FZF_DEFAULT_COMMAND='fd --hidden --type f --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --hidden --type d"
