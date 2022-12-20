#!/bin/bash

if [[ -z $(pgrep -l cmus) ]]; then
	urxvt -e cmus
else
	pkill cmus
fi
