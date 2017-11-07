#!/bin/bash
source /mnt/.system/global/functions.sh

COUNT=360

START=$COUNT                                                # Set a start point.

until [ "$COUNT" -eq "0" ]; do                              # Countdown loop.
    ((COUNT-=1))                                            # Decrement seconds.
    PERCENT=$((100-100*COUNT/START))                        # Calc percentage.
    echo "#Automatic Logout$(echo "obase=60;$COUNT" | bc)"  # Convert to H:M:S.
      echo $PERCENT                                         # Outut for progbar.
    sleep 1
done | zenity --title "System Authority" --progress --percentage=0 --text=""\
    --window-icon=$ICON --auto-close --height=100 --width=360

    if [[ $? = 0 ]]; then

      # Force Zenity Status message box to always be on top.
      sleep 1 && wmctrl -r "Logging out..." -b add,above &

      (
      # =================================================================
      set_logon_script_televinken
      logout_wallpaper
      echo "# Reverting Preferences" ; sleep 3

      # =================================================================
      savevm_televinken
      echo "60"
      echo "# Saving VM"

      # =================================================================
      close_apps
      echo "90"
      echo "# Closing Applications"

      ) |
      zenity --progress \
        --title="Logging out..." \
        --text="First Task." \
        --percentage=0 \
        --pulsate \
        --auto-close \
        --auto-kill

      (( $? != 0 )) && zenity --error --text="Error: Could not complete task."
      DISPLAY=:0 gnome-session-quit --force
      DISPLAY=:0 gnome-session-quit --force
      exit 0

    else
       exit
    fi
