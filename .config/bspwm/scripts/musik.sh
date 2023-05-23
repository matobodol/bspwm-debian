#!/bin/bash

if [[ -z $(pgrep -l cmus) ]]; then
	xterm -class 'cmus' -e cmus
else
	pkill cmus
fi
