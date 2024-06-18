#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export HISTSIZE=10000
export HISTFILESIZE=10000

# https://unix.stackexchange.com/questions/139115/disable-ctrl-d-from-closing-my-window-with-the-terminator-terminal-emulator
# press three times ctrl+d can send EOF to terminal
export IGNOREEOF=3

alias ll='ls -l'
alias gotowork='ssh wangyuxuan@relay.xiaomi.com'
alias exitwork='ssh -O exit wangyuxuan@relay.xiaomi.com'

#eval `dircolors ~/.dircolors/solarized.256dark`

export GO111MODULE=on
export GOPROXY=https://goproxy.cn

export HISTCONTROL=ignoredups

# podman
alias podman='sudo podman'
alias podman-compose='sudo podman-compose'
#export DOCKER_BUILDKIT=0

# wsl
wsl_mount_root=/mnt
wsl_windir="${wsl_mount_root}/c/WINDOWS/System32"
wsl_distro=Arch
wsl_wslg_display=0
# wsl proxy
#win_ip=`ip route show | grep -i default | awk '{ print $3}'`
#export http_proxy="${win_ip}:23333"
#export https_proxy="${win_ip}:23333"
#export no_proxy="localhost;127.*;192.168.*;10.*;172.16.*"

export no_proxy='172.16.*,10.*,192.168.*,127.*,localhost,<local>'
export NO_PROXY='172.16.*,10.*,192.168.*,127.*,localhost,<local>'
export https_proxy='http://127.0.0.1:23333'
export HTTPS_PROXY='http://127.0.0.1:23333'
export HTTP_PROXY='http://127.0.0.1:23333'
export http_proxy='http://127.0.0.1:23333'

# after wsl 1.0.3 no longer need this
# check if in-built wslg socket exists at all
#if test -S $wsl_mount_root/wslg/.X11-unix/X0; then
#        # fix is needed in case system socket in /tmp doesn't exist or it's true, canonical path isn't the wslg socket's one
#        if ! test -e /tmp/.X11-unix/X${wsl_wslg_display} || ! test "$(readlink -f /tmp/.X11-unix/X${wsl_wslg_display})" = "$wsl_mount_root/wslg/.X11-unix/X0"; then
#			echo -e "* WSL: restoring WSLG X11 server socket on /tmp/.X11-unix/X${wsl_wslg_display}"
#			# recreate /tmp/.X11-unix directory if needed
#			if test ! -d /tmp/.X11-unix; then
#				$wsl_windir/wsl.exe -d $wsl_distro -u root install -dm 1777 -o root /tmp/.X11-unix
#			fi
#			# delete existing socket if needed. this must obviously break something that created that socket
#			# and you'd rather define display not colliding with other sockets
#			if test -e /tmp/.X11-unix/X${wsl_wslg_display}; then
#				$wsl_windir/wsl.exe -d $wsl_distro -u root rm -Rf /tmp/.X11-unix/X${wsl_wslg_display} /tmp/.X${wsl_wslg_display}-lock
#			fi
#			# if desired display is different than wslg's default 0, check if WSLG socket doesn't already exist on X0
#			# if yes, delete it aswell to avoid having the same wslg socket bound to two separate display numbers
#			if test $wsl_wslg_display -ne 0; then
#				if test -e /tmp/.X11-unix/X0 && test "$(readlink -f /tmp/.X11-unix/X0)" = "$wsl_mount_root/wslg/.X11-unix/X0"; then
#					$wsl_windir/wsl.exe -d $wsl_distro -u root rm -Rf /tmp/.X11-unix/X0 /tmp/.X0-lock
#				fi
#			fi
#			# create symlink to wslg socket
#			$wsl_windir/wsl.exe -d $wsl_distro -u root ln -s $wsl_mount_root/wslg/.X11-unix/X0 /tmp/.X11-unix/X${wsl_wslg_display}
#			# export updated display number for user's convenience
#			export DISPLAY=:${wsl_wslg_display}
#        fi
#fi
