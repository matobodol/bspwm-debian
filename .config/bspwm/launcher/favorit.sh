#!/usr/bin/env bash
source ~/.config/bspwm/globalrc

if [ "$@" ]; then
	case "$@" in
		LOCK) coproc Lock ;;
		SLEEP) coproc Sleep ;;
		LOGOUT) coproc Logout ;;
		REBOOT) coproc Reboot ;;
		SHUTDOWN) coproc Shutdown ;;
	esac
else
	echo "LOCK"
	echo "SLEEP"
	echo "LOGOUT"
	echo "REBOOT"
	echo "SHUTDOWN"
fi
"$@"

