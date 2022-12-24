run_state=$(pgrep -l iwd.sh | head -n1 | awk '{print $2}')

if [[ $run_state == 'iwd.sh' ]]; then
	exit
else
	case $1 in
	0)
	 urxvt -name iwd -e ~/.config/bspwm/scripts/iwd.sh 0 ;;
	1)
	 ~/.config/bspwm/scripts/iwd.sh 1 ;;
	 esac
fi
