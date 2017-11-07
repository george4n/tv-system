#!/bin/bash

CHOICE=$(zenity --height=260 --width=360 --list \
   --title="Televinken Control Center" \
   --column="Task" --column="Description" \
    "1" "Logout Session" \
    "2" "Restart Bria" \
    "3" "Restore Bria Settings" \
    "4" "Refresh Logon Process" \
    "5" "Check Latency Dialing" \
    "6" "Change Password" \
    "7" "Refresh Sound System" \
)

if [[ $CHOICE = "1" ]]; then
  /mnt/.system/televinken/admin/server/./logout.sh &
elif [[ $CHOICE = "2" ]]; then
  /mnt/.system/televinken/admin/server/./fixbria.sh &
elif [[ $CHOICE = "3" ]]; then
  /mnt/.system/televinken/admin/server/./restorebria.sh &
elif [[ $CHOICE = "4" ]]; then
  /mnt/.system/televinken/admin/server/./logon.sh &
elif [[ $CHOICE = "5" ]]; then
  gnome-terminal --geometry=800x800 -e "mtr tv.dialingozone.com" &
elif [[ $CHOICE = "6" ]]; then
  zenity --info --text="$(gnome-terminal -e "passwd" 2>&1)"
elif [[ $CHOICE = "7" ]]; then
  /mnt/.system/televinken/admin/server/./fixpulse.sh &
      exit
fi
