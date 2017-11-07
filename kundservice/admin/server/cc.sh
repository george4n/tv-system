#!/bin/bash

CHOICE=$(zenity --height=300 --width=360 --list \
   --title="Televinken Control Center" \
   --column="Task" --column="Description" \
   "1" "Logout Session" \
   "2" "Restart Bria" \
   "3" "Restore Bria Settings" \
   "4" "Refresh Logon Process" \
   "5" "Kill Remote" \
   "6" "Check Latency PBX" \
   "7" "Check Latency Remote" \
   "8" "Beta - Configure Remote" \
   "9" "Remote Legacy" \
   "10" "Refresh Sound System" \
)

if [[ $CHOICE = "1" ]]; then
  /mnt/.system/kundservice/admin/server/./logout.sh &
elif [[ $CHOICE = "2" ]]; then
  /mnt/.system/kundservice/admin/server/./fixbria.sh &
elif [[ $CHOICE = "3" ]]; then
  /mnt/.system/kundservice/admin/server/./restorebria.sh &
elif [[ $CHOICE = "4" ]]; then
  /mnt/.system/kundservice/admin/server/./logon.sh &
elif [[ $CHOICE = "5" ]]; then
  killall rdesktop &
elif [[ $CHOICE = "6" ]]; then
  gnome-terminal --geometry=800x800 -e "mtr 172.28.191.24" &
elif [[ $CHOICE = "7" ]]; then
  gnome-terminal --geometry=800x800 -e "mtr 172.28.64.150" &
elif [[ $CHOICE = "8" ]]; then
  rm /mnt/kundservice/$USER/.config/tv_profile.conf
  /mnt/.system/kundservice/admin/server/./remote.sh
elif [[ $CHOICE = "9" ]]; then
  /mnt/.system/kundservice/admin/server/./remote-legacy.sh &
elif [[ $CHOICE = "10" ]]; then
  /mnt/.system/kundservice/admin/server/./fixpulse.sh &
      exit
fi
