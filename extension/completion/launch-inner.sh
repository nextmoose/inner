#!/bin/sh

_UseGetOpt() {
    local CUR &&
        COMPREPLY=() &&
        CUR=${COMP_WORDS[COMP_CWORD]} &&
        case "${CUR}" in
            -*)
                COMPREPLY=($( compgen -W "--name --major --minor --patch" -- ${CUR}))
            ;;
        esac
  return 0
} &&
    complete -F _UseGetOpt -o filenames /usr/local/bin/launch-inner launch-inner --