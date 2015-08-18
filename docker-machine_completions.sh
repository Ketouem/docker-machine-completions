#!/bin/bash
#
# bash completion file for docker-machine commands
#
# To enable the completions:
#   1) Copy this file inside /etc/bash_completion.d
#   2) `source` the file directly
#   3) Copy this file to a given location (e.g. ~/comps/docker-machine_completions)
#      and add the following to your .bashrc: . ~/comps/docker-machine_completions
#
__get_machines()
{
    local machines

    case "$1" in
        "all")
            machines=($(docker-machine ls | tail -n +2 | cut -d" " -f1))
            ;;

        "running")
            machines=($(docker-machine ls | grep Running | tail | cut -d" " -f1))
            ;;

    esac
    COMPREPLY=( $(compgen -W "${machines[*]}" -- "$cur") )
}

_docker-machine_docker-machine()
{
    local options_boolean="
        $global_options_boolean
        --help -h
        --version -v
    "

    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "$options_boolean $global_options_with_args" -- "$cur" ) )
            ;;
        *)
            COMPREPLY=( $( compgen -W "${commands[*]}" -- "$cur") )
            ;;
    esac
}

_docker-machine_ip()
{
    case "$cur" in
        *)
            __get_machines "running"
            ;;
        esac
}

_docker-machine_rm()
{
    case "$cur" in
    *)
        __get_machines "all"
        ;;
    esac
}

_docker-machine_ssh()
{
    case "$cur" in
        *)
            __get_machines "running"
            ;;
        esac
}

_docker-machine_status()
{
    case "$cur" in
        *)
            __get_machines "all"
            ;;
        esac
}

_docker-machine()
{
    local commands=(
                        active
                        config
                        create
                        env
                        inspect
                        ip
                        kill
                        ls
                        regenerate-certs
                        restart
                        rm
                        ssh
                        scp
                        start
                        status
                        stop
                        upgrade
                        url
                        help
                        h
    )

    local global_options_boolean="
        --debug -D
        --tls-ca-cert
        --tls-ca-key
        --tls-client-cert
        --tls-client-key
        --native-ssh
    "

    local global_options_with_args="
        --storage-path -s
    "

    COMPREPLY=()
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword

    local command='docker-machine' command_pos=0
    local counter=1

    while [ $counter -lt $cword ]; do
        case "${words[$counter]}" in
            *)
                command="${words[$counter]}"
                command_pos=$counter
                break 
                ;;
        esac
        (( counter++ ))
    done

    local completions_func=_docker-machine_${command}
    declare -F $completions_func >/dev/null && $completions_func

    return 0
}

complete -F _docker-machine docker-machine
