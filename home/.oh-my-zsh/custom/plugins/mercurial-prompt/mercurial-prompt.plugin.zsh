# Mercurial
alias hga='hg add'
alias hgc='hg commit'
alias hgb='hg branch'
alias hgba='hg branches'
alias hgbk='hg bookmarks'
alias hgco='hg checkout'
alias hgd='hg diff'
alias hged='hg diffmerge'
# pull and update
alias hgi='hg incoming'
alias hgl='hg pull -u'
alias hglr='hg pull --rebase'
alias hgo='hg outgoing'
#alias hgp='hg push'
alias hgs='hg status'
alias hgsl='hg log --limit 20 --template "{node|short} | {date|isodatesec} | {author|user}: {desc|strip|firstline}\n" '
alias hgca='hg commit --amend'
# list unresolved files (since hg does not list unmerged files in the status command)
alias hgun='hg resolve --list'
alias hgn='hg next'
alias hgprev='hg prev'
alias hgstash='hg shelve'
alias hgunstash='hg unshelve'
alias ha='hg commit --amend'

# Updates hg root
function update_hg_root() {
  local path=$(pwd)
  while [[ $path != "/" && ( ! -d "$path/.hg" ) ]]; do
    local v="$path/.."
    path=$v:A
  done

  if [[ $path != "/" ]]; then
    HG_ROOT=$path
  else
    HG_ROOT="" # hg repository not found
  fi
}

function preexec_update_hg_root() {
    case "$2" in
        hg*)
        __EXECUTED_HG_COMMAND=1
        ;;
    esac
}

function precmd_update_hg_root() {
    if [ -n "$__EXECUTED_HG_COMMAND" ]; then
        update_hg_root
        unset __EXECUTED_HG_COMMAND
    fi
}

# Will update hg root every time user changes dir.
# This approach fast but doesn't work with some corner
# cases:
# - user deletes .hg  directory.

# Only one function
if  [[ ${chpwd_functions[(r)update_hg_root]} != update_hg_root ]]; then
  chpwd_functions+=(update_hg_root)
fi

if [[ ${precmd_functions[(r)precmd_update_hg_root]} != precmd_update_hg_root ]]; then
  precmd_functions+=(precmd_update_hg_root)
fi

if [[ ${preexec_functions[(r)preexec_update_hg_root]} != preexec_update_hg_root ]]; then
  preexec_functions+=(preexec_update_hg_root)
fi

function hg_status_info() {
    if [[ -n $HG_ROOT ]]; then
        local output=$(hg parent --template "{tags};{clnumber};{clid};{p4head}" 2> /dev/null)
	IFS=';' read -A items <<< "$output"
	local result="$ZSH_THEME_HG_PROMPT_PREFIX$(hg_branch)"
	# adding branch info
        if [[ -z $items[1] ]]; then
	  result="$result/$items[4]"
        else
	  result="$result/$items[1]"
        fi
	# adding cl info
	if [[ ! -z $items[2] ]]; then
	  result="$result $ZSH_THEME_HG_PROMPT_DETIAL_COLOR(cl/$items[2])"
	fi
	echo $result
    fi
}
function hg_branch() {
    if [[ -n $HG_ROOT ]]; then
        local branch=$(cat "$HG_ROOT/.hg/branch" 2> /dev/null)
        if [[ -n $branch ]]; then
          echo $branch
        else
          # After creation of empty repository branch technicaly
          # is `default`. But .hg/branch is not created until
          # hg up -C will be run.
          echo "default"
        fi
    fi
}

function hg_dirty_choose {
  if [[ -n $HG_ROOT ]]; then
    hg st 2> /dev/null | command grep -Eq '[ACDIM!\?L]'
    if [ $pipestatus[-1] -eq 0 ]; then
      # Grep exits with 0 when "One or more lines were selected", return "dirty".
      echo $1
    else
      # Otherwise, no lines were found, or an error occurred. Return clean.
      echo $2
    fi
  fi
}

function hg_dirty {
  hg_dirty_choose $ZSH_THEME_HG_PROMPT_DIRTY $ZSH_THEME_HG_PROMPT_CLEAN
}

function hg_prompt_info() {
  if [[ -n $HG_ROOT ]]; then
    echo "$ZSH_PROMPT_BASE_COLOR$ZSH_THEME_REPO_NAME_COLOR$(hg_status_info)$ZSH_PROMPT_BASE_COLOR$ZSH_PROMPT_BASE_COLOR$(hg_dirty)$ZSH_THEME_HG_PROMPT_SUFFIX$ZSH_PROMPT_BASE_COLOR"
    unset _DISPLAY
  fi
}

# Default values for the appearance of the prompt.
ZSH_PROMPT_BASE_COLOR="%{${fg_bold[blue]}%}"
ZSH_THEME_HG_PROMPT_PREFIX=" %{$fg_bold[magenta]%}hg:"
ZSH_THEME_HG_PROMPT_DETIAL_COLOR="%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_SUFFIX=""
ZSH_THEME_HG_PROMPT_SEPARATOR="|"
ZSH_THEME_HG_PROMPT_BRANCH_COLOR="%{$fg_bold[magenta]%}"

