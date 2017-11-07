#!/bin/bash

#includes
source /mnt/.system/global/functions.sh

PERSON=`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1`


# Force Zenity Status message box to always be on top.
sleep 1 && wmctrl -r "Starting up" -b add,above &

(
# =================================================================
set_background_televinken
slacktee_logon_televinken
set_launcher_televinken
set_menues_televinken
backup_bria
wmctrl -r "Starting up" -b add,above &
echo "# Setting Preferences" ; sleep 4

# =================================================================
#start_pidgin
start_slack
wmctrl -r "Starting up" -b add,above &
echo "30"
echo "# Starting up" ; sleep 2

# =================================================================
start_firefox_televinken
wmctrl -r "Starting up" -b add,above &
echo "40"
echo "# Starting Web Browser" ; sleep 2

# =================================================================
startvm_televinken
timeout_televinken &
wmctrl -r "Starting up" -b add,above &
echo "60"
echo "# Starting Virtual Machine" ; sleep 3


# =================================================================
wmctrl -r "Starting up" -b add,above &
echo "# System Ready" ; sleep 2
echo "100"


) |
zenity --progress \
  --title="Starting up" \
  --text="First Task." \
  --percentage=0 \
  --pulsate \
  --auto-close \
  --auto-kill

(( $? != 0 )) && zenity --error --text="Error: Could not complete task."

zenity --info --title "System Authority" --text "Welcome, $PERSON. System ready for use. V2.1" --timeout 5

exit 0
