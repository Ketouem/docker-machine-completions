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

_docker-machine_create()
{
    local options_with_args="
        --amazonec2-access-key
        --amazonec2-ami
        --amazonec2-iam-instance-profile
        --amazonec2-instance-type
        --amazonec2-monitoring
        --amazonec2-private-address-only
        --amazonec2-region
        --amazonec2-request-spot-instance
        --amazonec2-root-size
        --amazonec2-secret-key
        --amazonec2-security-group
        --amazonec2-session-token
        --amazonec2-spot-price
        --amazonec2-ssh-user
        --amazonec2-subnet-id
        --amazonec2-vpc-id
        --amazonec2-zone
        --azure-docker-port
        --azure-docker-swarm-master-port
        --azure-image
        --azure-location
        --azure-password
        --azure-publish-settings-file
        --azure-size
        --azure-ssh-port
        --azure-subscription-cert
        --azure-subscription-id
        --azure-username
        --digitalocean-access-token
        --digitalocean-backups
        --digitalocean-image
        --digitalocean-ipv6
        --digitalocean-private-networking
        --digitalocean-region
        --digitalocean-size
        --exoscale-api-key
        --exoscale-api-secret-key
        --exoscale-availability-zone
        --exoscale-disk-size
        --exoscale-image
        --exoscale-instance-profile
        --exoscale-security-group
        --exoscale-url
        --generic-ip-address
        --generic-ssh-key
        --generic-ssh-port
        --generic-ssh-user
        --google-address
        --google-auth-token
        --google-disk-size
        --google-disk-type
        --google-machine-type
        --google-preemptible
        --google-project
        --google-scopes
        --google-username
        --google-zone
        --openstack-auth-url
        --openstack-availability-zone
        --openstack-domain-id
        --openstack-domain-name
        --openstack-endpoint-type
        --openstack-flavor-id
        --openstack-flavor-name
        --openstack-floatingip-pool
        --openstack-image-id
        --openstack-image-name
        --openstack-insecure
        --openstack-net-id
        --openstack-net-name
        --openstack-password
        --openstack-region
        --openstack-sec-groups
        --openstack-ssh-port
        --openstack-ssh-user
        --openstack-tenant-id
        --openstack-tenant-name
        --openstack-username
        --rackspace-api-key
        --rackspace-docker-install
        --rackspace-endpoint-type
        --rackspace-flavor-id
        --rackspace-image-id
        --rackspace-region
        --rackspace-ssh-port
        --rackspace-ssh-user
        --rackspace-username
        --softlayer-api-endpoint
        --softlayer-api-key
        --softlayer-cpu
        --softlayer-disk-size
        --softlayer-domain
        --softlayer-hostname
        --softlayer-hourly-billing
        --softlayer-image
        --softlayer-local-disk
        --softlayer-memory
        --softlayer-private-net-only
        --softlayer-private-vlan-id
        --softlayer-public-vlan-id
        --softlayer-region
        --softlayer-user
        --url
        --virtualbox-boot2docker-url
        --virtualbox-cpu-count
        --virtualbox-disk-size
        --virtualbox-hostonly-cidr
        --virtualbox-import-boot2docker-vm
        --virtualbox-memory
        --vmwarefusion-boot2docker-url
        --vmwarefusion-cpu-count
        --vmwarefusion-disk-size
        --vmwarefusion-memory-size
        --vmwarevcloudair-catalog
        --vmwarevcloudair-catalogitem
        --vmwarevcloudair-computeid
        --vmwarevcloudair-cpu-count
        --vmwarevcloudair-docker-port
        --vmwarevcloudair-edgegateway
        --vmwarevcloudair-memory-size
        --vmwarevcloudair-orgvdcnetwork
        --vmwarevcloudair-password
        --vmwarevcloudair-provision
        --vmwarevcloudair-publicip
        --vmwarevcloudair-ssh-port
        --vmwarevcloudair-username
        --vmwarevcloudair-vdcid
        --vmwarevsphere-boot2docker-url
        --vmwarevsphere-compute-ip
        --vmwarevsphere-cpu-count
        --vmwarevsphere-datacenter
        --vmwarevsphere-datastore
        --vmwarevsphere-disk-size
        --vmwarevsphere-memory-size
        --vmwarevsphere-network
        --vmwarevsphere-password
        --vmwarevsphere-pool
        --vmwarevsphere-username
        --vmwarevsphere-vcenter
        --driver -d
        --engine-install-url
        --engine-opt
        --engine-insecure-registry
        --engine-registry-mirror
        --engine-label
        --engine-storage-driver
        --engine-env
        --swarm
        --swarm-image
        --swarm-master
        --swarm-discovery
        --swarm-strategy
        --swarm-opt
        --swarm-host
        --swarm-addr
    "

    case "$prev" in
        --driver|-d)
            local vm_driver="
                amazonec2
                azure
                digitalocean
                exoscale
                generic
                google
                none
                openstack
                rackspace
                softlayer
                virtualbox
                vmwarefusion
                vmwarevcloudair
                vmwarevsphere
            "
            COMPREPLY=( $( compgen -W "$vm_driver" -- "$cur" ) )
            return
            ;;
    esac

    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W "$options_with_args" -- "$cur" ) )
            ;;
    esac
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
