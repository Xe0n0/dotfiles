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

alias python=python3

export PATH="/usr/local/sbin:/Users/wuhaotian/bin:$PATH:/usr/local/share/npm/bin"
export PATH=$PATH:/Users/wuhaotian/go/bin
export NVM_DIR=~/.nvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR=vim

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export PATH=$HOME/bin:$PATH
export PATH=$HOME/homebrew/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/usr/local/bin:$PATH
USER_BASE_PATH=$(python -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH/bin
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
export PATH=$PATH:/usr/local/kubebuilder/bin
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin":$PATH

if [[ "$(uname)" == "Darwin" ]]; then
  plugins=(git brew ruby npm bower gem coffee bundler rails fasd sudo extract node history-substring-search)
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
  plugins=(git fasd history-substring-search mercurial-prompt)
  #ufasd setup
  eval "$(fasd --init auto)"
  # eval "$(fasd --init posix-alias zsh-hook zsh-ccomp)"
  source $ZSH/oh-my-zsh.sh
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey \^U backward-kill-line

alias c=cd
alias vi=vim
alias py=python
alias e=emacs
alias r=racket
alias tt=tmx2
alias pp=proxychains4

# hg theme config
#PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c%{$fg_bold[blue]%}$(git_prompt_info)$(hg_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
#ZSH_THEME_HG_PROMPT_PREFIX=" %{$fg_bold[magenta]%}hg:(%{$fg[red]%}"
#ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%}"
#ZSH_THEME_HG_PROMPT_CLEAN=""

if [[ -e ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
export PATH="/Users/wuhaotian/homebrew/opt/mysql@5.7/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"

## QT5
export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib"
export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include"

export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/wuhaotian/Developer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/wuhaotian/Developer/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/wuhaotian/Developer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/wuhaotian/Developer/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export PATH="/Users/wuhaotian/bin:$PATH"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"


# Created by `pipx` on 2025-03-27 09:30:11
export PATH="$PATH:/Users/wuhaotian/.local/bin"
