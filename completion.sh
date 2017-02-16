_lav4 ()
{
    local ENDPOINTS='/linode/instances /linode/instances/ /linode/kernels /linode/distributions
                     /linode/types /linode/stackscripts \
                     /dns/zones \
                     /datacenters
                     /account/events /account/profile /account/profile/password /account/profile/tfa-enable /account/profile/tfa-disable /account/profile/tfa-enable/confirm /account/tokens /account/settings /account/clients /account/users \
                     /networking/ipv4 /networking/ipv6 /networking/ip-assign'
    local INSTANCE_ENDPOINTS='/disks /configs /boot /shutdown /reboot /backups /backups/enable /backups/cancel /ips /ips/sharing /rebuild /resize /rescue'
    local cur
    local ids
    local argfields
    local instance_endpoints

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    case "$cur" in
        /linode/instances/)
            ids=$(lav4.sh -s /linode/instances | jq -r '.linodes | map(("/linode/instances/" + (.id | tostring)) + "/") | join(" ")')
            COMPREPLY=( $( compgen -W "$ids" -- $cur ) )
            ;;
        /linode/instances/*)
            argfields=(${cur//[^\/]})
            if [[ "${#argfields}" == 4 ]]; then
                instance_endpoints=()
                for endpoint in $INSTANCE_ENDPOINTS; do
                    instance_endpoints+=("${cur%/*}$endpoint")
                done

                COMPREPLY=($(compgen -W "${instance_endpoints[*]}" -- $cur))
            else
                ids=($(lav4.sh -s /linode/instances | jq -r '.linodes | map(("/linode/instances/" + (.id | tostring) + "/")) | join(" ")'))
                for id in ${ids[*]}; do
                    ids+=("${id%/*}")
                done

                COMPREPLY=($(compgen -W "${ids[*]}" -- $cur))
            fi
            ;;
        /*)
            COMPREPLY=($(compgen -W "$ENDPOINTS" -- $cur))
            ;;
    esac
}

if [[ "$SHELL" == *"zsh"* ]]
then
    autoload -U +X compinit && compinit
    autoload -U +X bashcompinit && bashcompinit
fi

complete -F _lav4 -o display lav4.sh
