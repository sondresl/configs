# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/sondrelunde/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mh"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  z
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  

# Mouse support
set -g mode-mouse on
set -g mouse-resize-pane on

#
# Main prompt
#


local host_name="%{$fg[red]%}Sondre"
local path_string="%{$fg[white]%}%1d"
local prompt_string="$"

# Make prompt_string red if the previous command failed.
local return_status="%(?:%{$fg[blue]%}$prompt_string:%{$fg[red]%}$prompt_string)"


# PROMPT='${host_name} ${path_string} ${return_status} %{$reset_color%}'
PROMPT='${path_string} ${return_status} %{$reset_color%}'

git config --global oh-my-zsh.hide-status 0

# export MANPATH="/usr/local/man:$MANPATH"

# Homebrew Python 3
# export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"

# added by Anaconda3 5.0.0 installer (Copied from .bash_profile)
export PATH="/Users/sondrelunde/anaconda3/bin:$PATH"

# Add ghcid path for Haskell
export PATH="$HOME/Library/Haskell/bin:$PATH"


# Add path for SML
export PATH=/usr/local/Cellar/smlnj/110.74/libexec/bin:$PATH

# Path for Base-16 colours
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Allow Ctrl-z to toggle between suspend and resume 
function Resume {  
    fg
    zle push-input 
    BUFFER=""
    zle accept-line
} 
zle -N Resume
bindkey "^Z" Resume

function c() {
    cd $1
    clear
    exa -la
}

# fzf
# fda - including hidden directories
function fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
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

# Aliases
alias work='cd ~/Workspace'
alias k='javac *java'
alias rmcl='rm *.class'
alias j='java'
alias jc='rm *.class'
alias l='clear; exa -la'
alias ls='exa'
alias uio='ssh -YC sondrslu@login.ifi.uio.no'
alias uiofiler='sshfs sondrslu@login.uio.no: ~/uio -o reconnect,modules=iconv,from_code=utf8'
alias scheme='rlwrap /Applications/Racket\ v7.2/bin/plt-r5rs'
alias rpi='ssh pi@192.168.0.10'
alias vim='nvim'
alias ff='fzf-tmux'
alias sml='rlwrap sml'
alias swipl='rlwrap swipl'
alias tls='tmux ls'
alias ta='tmux a -t '
alias clojure='rlwrap clojure'
alias ml='rlwrap python /Users/sondrelunde/Workspace/Koding/minilisp/minilisp.py /Users/sondrelunde/Workspace/Koding/minilisp/lib.mini'
alias rasp='/Users/sondrelunde/Workspace/Koding/Rust/rasp/target/release/rasp'

source /Users/sondrelunde/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

set -o vi
