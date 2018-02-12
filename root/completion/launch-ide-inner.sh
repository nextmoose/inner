#!/bin/sh

_UseGetOpt() {
    local CUR &&
        COMPREPLY=() &&
        CUR=${COMP_WORDS[COMP_CWORD]} &&
        case "${CUR}" in
            -)
                COMPREPLY=($( compgen -W "--host --master-branch --upstream- --origin- --report- --cloud9-port --checkout-branch --gpg --user-" -- ${CUR}))
            ;;
            --h*)
                COMPREPLY=($( compgen -W "--host-name --host-port" -- ${CUR}))
            ;;
            --host-n)
                COMPREPLY=($( compgen -W "--host-name github.com" -- ${CUR}))
            ;;
            --host-p)
                COMPREPLY=($( compgen -W "--host-port 22" -- ${CUR}))
            ;;
            --m*)
                COMPREPLY=($( compgen -W "--master-branch master" -- ${CUR}))
            ;;
            --u*)
                COMPREPLY=($( compgen -W "--upstream-id-rsa --upstream-organization --upstream-organization --upstream-repository" -- ${CUR}))
            ;;
            --upstream-id-rsa)
                COMPREPLY=($( compgen -W "--upstream-id-rsa --upstream-organization --upstream-organization --upstream-repository" -- ${CUR}))
            ;;
        esac
  return 0
} &&
    complete -F _UseGetOpt -o filenames /usr/local/bin/launch-ide-inner launch-ide-inner --