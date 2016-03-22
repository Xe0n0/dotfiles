#!/usr/bin/env bash

pushd () {
  command pushd "$@" > /dev/null
}

popd () {
  command popd > /dev/null
}

force=0
verbose=0
dry=
echo_when_verbose=true
install_all=0
while getopts "fvdA" opt; do
  case $opt in
    f) force=1
       echo "Force mode, will override existing file"
       ;;
    v) echo_when_verbose=echo
       ;;
    d) dry=echo
       echo "Dry run mode, print out commands only"
       ;;
    A) install_all=1
  esac
done

log () {
  $echo_when_verbose $1
}

deploy_to () {
  log "deploy $1 to $2"
  pushd $1
  FILTER="sed -e s/^\.\///g" 	
  for fd in `find . -not -path '.' -type d | $FILTER`; do
    fd_path="`pwd`/$fd"
    log "creating ~/$fd"
    $dry mkdir -p ~/$fd
  done
  
  for fd in `find . -type f | $FILTER`; do
    fd_path="`pwd`/$fd"
    log "linking $fd to ~/$fd"
    if (( force > 0 )); then
      $dry ln -s -F $fd_path ~/$fd
    else
      $dry ln -s $fd_path ~/$fd
    fi
  done
  popd
}

deploy_to home ~/
