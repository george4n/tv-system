#!/bin/bash

#includes
. /mnt/.system/global/functions.sh

COUNT=11

START=$COUNT                                                # Set a start point.

until [ "$COUNT" -eq "0" ]; do                              # Countdown loop.
    ((COUNT-=1))                                            # Decrement seconds.
    PERCENT=$((100-100*COUNT/START))                        # Calc percentage.
    echo "#Automatic Reboot$(echo "obase=60;$COUNT" | bc)"  # Convert to H:M:S.
      echo $PERCENT                                         # Outut for progbar.
    sleep 1
done | zenity --title "System Authority" --progress --percentage=0 --text=""\
    --window-icon=$ICON --auto-close --height=100 --width=360
    if [ $? = 0 ]; then

      # Force Zenity Status message box to always be on top.
      sleep 1 && wmctrl -r "Logging out..." -b add,above &

      (
      # =================================================================
      close_apps
      echo "10"
      echo "# Closing Applications" ; sleep 1

      # =================================================================
      savevm_televinken
      echo "60"
      echo "# Saving User Settings" ; sleep 1

      # =================================================================

      set_logon_script_televinken
      logout_wallpaper
      slacktee_logout_televinken
      echo "# Reverting Preferences" ; sleep 1

      ) |
      zenity --progress \
        --title="Logging out..." \
        --text="First Task." \
        --percentage=0 \
        --pulsate \
        --auto-close \
        --auto-kill

      (( $? != 0 )) && zenity --error --text="Error: Could not complete task."
      sleep 1
      /sbin/reboot
      pkill -u $USER
      /sbin/reboot
      exit 0


  else
   exit
  fi
