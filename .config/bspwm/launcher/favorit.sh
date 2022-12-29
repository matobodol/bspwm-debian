#!/usr/bin/env bash
source ~/.config/bspwm/globalrc

if [ "$@" ]; then
	case "$1" in
		*Lock) coproc Lock ;;
		*Sleep) coproc Sleep ;;
		*Logout) coproc Logout ;;
		*Reboot) coproc Reboot ;;
		*Shutdown) coproc Shutdown ;;
	esac
else
	echo "   Lock"
	echo "   Sleep"
	echo "   Logout"
	echo "   Reboot"
	echo "   Shutdown"
fi


