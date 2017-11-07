#!/bin/bash

zenity --timeout=10 --no-wrap --title "System Authority" --question --text="Are you sure you want to restart Bria? \n\nOnly use this if you are experiencing problems with Bria."
if [ $? = 0 ]; then
	killall -15 bria
	nohup bria &
else
	exit
fi
