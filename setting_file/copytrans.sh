#!/usr/bin/env bash

# ref:https://www.cnblogs.com/maxuewei2/archive/2018/05/03/8986905.html
se=$(xsel -b -n -o | tr '\n' ' '| tr '\r' ' ' | sed 's/  / /g')
re=$(trans -b en:zh "$se")
notify-send "$se" "$re" -i accessories-dictionary -t 2000
