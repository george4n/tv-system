#!/bin/bash

#includes
. /mnt/.system/global/functions.sh

PERSON=`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1`


# Force Zenity Status message box to always be on top.
sleep 1 && wmctrl -r "Starting up" -b add,above &

(
# =================================================================
set_background_foretag
slacktee_logon_foretag
set_launcher_foretag
set_menues_foretag
backup_bria
backup_vm_conf
wmctrl -r "Starting up" -b add,above &
echo "# Setting Preferences" ; sleep 4

# =================================================================
start_firefox_foretag
wmctrl -r "Starting up" -b add,above &
echo "40"
echo "# Starting Web Browser" ; sleep 2

# =================================================================
startvm_foretag
wmctrl -r "Starting up" -b add,above &
echo "60"
echo "# Starting Virtual Machine" ; sleep 3

# =================================================================
#start_remote_foretag
timeout_foretag &
wmctrl -r "Starting up" -b add,above &
echo "70"
echo "# Starting RDS" ; sleep 2

# =================================================================
wmctrl -r "Starting up" -b add,above &
echo "# System Ready" ; sleep 2
echo "100"
#TEST COMMAND
remmina -i &

) |
zenity --progress \
  --title="Starting up" \
  --text="First Task." \
  --percentage=0 \
  --pulsate \
  --auto-close \
  --auto-kill

(( $? != 0 )) && zenity --error --text="Error: Could not complete task."

zenity --info --text "Welcome, $PERSON. System ready for use. V2.1" --timeout 5

exit 0
