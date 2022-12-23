#!/bin/bash

if [[ -z $(pgrep -l cmus) ]]; then
	urxvt -name 'cmus' -e cmus
else
	pkill cmus
fi
