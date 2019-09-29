# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export LC_ALL=en_US.UTF-8

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

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

# User configuration
zstyle ':completion:*' menu select

# Mouse support
set -g mode-mouse on
set -g mouse-resize-pane on

set -o emacs

# Homebrew Python 3
# export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"

# added by Anaconda3 5.0.0 installer (Copied from .bash_profile)
export PATH="/Users/sondrelunde/anaconda3/bin:$PATH"

# Add ghcid path for Haskell
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Add path for SML
export PATH=/usr/local/Cellar/smlnj/110.74/libexec/bin:$PATH

# ZPLUG
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

    zplug "plugins/git",   from:oh-my-zsh
    zplug "rupa/z", use:"z.sh"
    # zplug "denysdovhan/spaceship-prompt", use:"spaceship.zsh", from:github, as:theme
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
# ==== End of zplug

source ~/.purepower

# SPACESHIP_PROMPT_ORDER=(
#     time          # Time stampts section
#     user          # Username section
#     dir           # Current directory section
#     host          # Hostname section
#     git           # Git section (git_branch + git_status)
#     # hg            # Mercurial section (hg_branch  + hg_status)
#     package       # Package version
#     # node          # Node.js section
#     # ruby          # Ruby section
#     # elm           # Elm section
#     # elixir        # Elixir section
#     # xcode         # Xcode section
#     # swift         # Swift section
#     # golang        # Go section
#     # php           # PHP section
#     rust          # Rust section
#     haskell       # Haskell Stack section
#     # julia         # Julia section
#     # docker        # Docker section
#     # aws           # Amazon Web Services section
#     venv          # virtualenv section
#     conda         # conda virtualenv section
#     # pyenv         # Pyenv section
#     # dotnet        # .NET section
#     # ember         # Ember.js section
#     # kubecontext   # Kubectl context section
#     # terraform     # Terraform workspace section
#     # exec_time     # Execution time
#     line_sep      # Line break
#     # battery       # Battery level and status
#     # vi_mode       # Vi-mode indicator
#     jobs          # Background jobs indicator
#     exit_code     # Exit code section
#     char          # Prompt character
# )

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
alias scm='rlwrap /Applications/Racket\ v7.2/bin/plt-r5rs'
alias racket='rlwrap /Applications/Racket\ v7.2/bin/racket'
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

# Functions

take() {
    mkdir $1
    cd $1
}

# fzf
#
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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
