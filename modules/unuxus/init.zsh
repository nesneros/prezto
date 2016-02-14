source /etc/unuxus/env

if [[ "$OSTYPE" == darwin* ]] ; then
    # Use zsh-completions from Homebrew if installed
    [ -d /usr/local/share/zsh-completions ]  && fpath=(/usr/local/share/zsh-completions $fpath)

    # if zsh is install with Homebrew, warn if system zsh is shell
    local homebrewZsh=/usr/local/bin/zsh
    if [[ -f $homebrewZsh ]] && [[ $SHELL == "/bin/zsh" ]] ; then
        echo "Warning: Shell is /bin/zsh but zsh is also install in $homebrewZsh"
    fi

    if [[ $homebrewZsh == $SHELL ]] ; then
        # Use git completion from system zsh.
        local git_completion=$(echo /usr/share/zsh/[[:digit:]].*/functions/_git(N[-1]))
        if [[ -f "$git_completion" ]] ; then
            local fpathDir=${0:h}/unuxus_fpath
            command rm -rf $fpathDir
            mkdir -p $fpathDir
            fpath=($fpathDir $fpath)
            ln -s $git_completion $fpathDir
        fi
    fi

    # Function to enable/disable usb network
    function usbNetwork {
        _networkHelper "USB 10/100/1000 LAN" $1
    }

    function _networkHelper {
        local serviceName=$1
        local onOff=$2
        if [[ -n "$onOff" ]] ; then
            sudo networksetup -setnetworkserviceenabled $serviceName $onOff
        fi
        networksetup -listallnetworkservices | grep $serviceName

    }

fi

