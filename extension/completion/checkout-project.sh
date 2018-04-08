#!/bin/sh

_UseGetOpt() {
    local CUR &&
        COMPREPLY=() &&
        CUR=${COMP_WORDS[COMP_CWORD]} &&
        case "${CUR}" in
            -*)
                COMPREPLY=($( compgen -W "--branch-name --project-name" -- ${CUR}))
            ;;
        esac
  return 0
} &&
    complete -F _UseGetOpt -o filenames /usr/local/bin/checkout-project checkout-project --