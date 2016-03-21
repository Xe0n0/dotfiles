# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zhann"
alias zshconfig="vim ~/.zshrc"

if [[ "$(uname)" != "Darwin" ]]; then
  ZSH_THEME="fwalch"
fi

# User configuration

export PATH="/usr/local/sbin:/Users/wuhaotian/bin:$PATH:/usr/local/share/npm/bin"
export NVM_DIR=~/.nvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR=vim

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export PATH=$HOME/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH

if [[ "$(uname)" == "Darwin" ]]; then
  plugins=(git brew ruby npm bower gem coffee bundler rails fasd sudo extract node history-substring-search zsh-syntax-highlighting)
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

alias c=cd
alias vi=vim
alias py=python
alias e=emacs

if [[ -e ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
