# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zhann"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)


if [[ "$(uname)" != "Darwin" ]]; then
  ZSH_THEME="fwalch"
fi

# User configuration

export PATH="/usr/local/sbin:/Users/wuhaotian/bin:$PATH:/usr/local/share/npm/bin"
export NVM_DIR=~/.nvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export TZ=Asia/Hong_Kong
export EDITOR=vim

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

##Google Mac Configuration
#P4 setup on OS X

export PATH=$HOME/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH

if [[ "$(uname)" == "Darwin" ]]; then
  plugins=(git brew ruby npm bower gem coffee bundler rails fasd sudo extract node history-substring-search zsh-syntax-highlighting)
  . $HOME/.bagpipe/setup.sh $HOME/.bagpipe haotian.hot.corp.google.com
  eval "$(fasd --init posix-alias zsh-hook zsh-wcomp zsh-wcomp-install)"
  # fasd_cache="$HOME/.fasd-init"
  # if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  #   fasd --init posix-alias zsh-hook zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
  #   # fasd --init auto >| "$fasd_cache"
  # fi
  # source "$fasd_cache"
  # unset fasd_cache

  bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
  bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
  bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
  source $ZSH/oh-my-zsh.sh
else

  alias s='fasd -si'       # show / search / select
  alias d='fasd -d'        # directory
  alias f='fasd -f'        # file
  alias sd='fasd -sid'     # interactive directory selection
  alias sf='fasd -sif'     # interactive file selection
  alias z='fasd_cd -d'     # cd, same functionality as j in autojump
  alias zz='fasd_cd -d -i' # cd with interactive selection
  plugins=(git fasd  history-substring-search zsh-syntax-highlighting)
  #ufasd setup
  eval "$(fasd --init auto)"
  # eval "$(fasd --init posix-alias zsh-hook zsh-ccomp)"
  source $ZSH/oh-my-zsh.sh
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down


export P4CONFIG=.p4config
export P4EDITOR=vim

alias c=cd
alias linux='ssh haotian.wat.corp.google.com'
alias hot='ssh haotian.hot.corp.google.com'
alias vi=vim
alias py=python
alias gg=git5
export PATH=$PATH:/Users/wuhaotian/gfvmobile/google3/googlemac/iPhone/Applecrisp/Crisp/bin
# source /Users/wuhaotian/AppleCrisp/google3/googlemac/iPhone/Applecrisp/Crisp/bash_completion.sh
git() { if [[ $1 == 'merge' ]]; then echo 'Use git5 merge, not git merge. git merge does not understand how to merge the READONLY link and it can corrupt your branch, so stay away from it.  type "unset -f git" to remove this warning'; else command git "$@"; fi; }

alias git-new-workdir=~/git/contrib/workdir/git-new-workdir
alias fuck='eval $(thefuck $(fc -ln -1))'
alias e=emacs

export PATH=$PATH:/Users/wuhaotian/Docs/google3/googlemac/iPhone/Applecrisp/Crisp/bin
export tv=192.168.1.242

alias git5=/Users/wuhaotian/Projects/WeaverShell/git5-wrapper.sh
