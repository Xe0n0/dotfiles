#!/usr/bin/env bash

force=0
while getopts "f" opt; do
    case '$opt' in
        f) force=1
           ;;
    esac
done

pushd home
for fd in `ls -a`; do
    if [ $fd != '.' ] && [ $fd != '..' ]; then
        fd_path="`pwd`/$fd"
        if (( force >= 0 )); then
            ln -s -F $fd_path ~/
        else
            ln -s $fd_path ~/
        fi
    fi
done
popd
