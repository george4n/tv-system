!/bin/bash
# Filename: progbar-timer.sh
# Version: 110212
# Author: robz
# Improved from the "Egg Timer" script, a countdown timer with progress bar.
# This one has an indication of time remaining provided by Zenity's progress
# bar function. As usual you'll need to find a sound and icon for the variables
# below, you might find the icon variable is correct, check the directory.

ICON=/usr/share/app-install/icons/kalarm.png              # Existing icon?
SOUND=$HOME/Audio/2tone.wav                               # Your sound pref.

COUNT=$(zenity --title "Egg Timer" --window-icon $ICON --text "No decimals"\
    --entry-text "eg. 10s or 5m or 2h" --entry)           # Input dialogue.
if [ $? = 1 ]; then exit $?; fi

# Determine number of seconds to count down from depending on input suffix.
case "${COUNT: -1}" in
    "S" | "s" ) COUNT=$(echo $COUNT | sed -s "s/[Ss]//") ;;
    "M" | "m" ) COUNT=$(echo $COUNT | sed -s "s/[Mm]//"); ((COUNT*=60)) ;;
    "H" | "h" ) COUNT=$(echo $COUNT | sed -s "s/[Hh]//"); ((COUNT*=3600)) ;;
    *         ) zenity --error --text "<span color=\"red\"><b>\
    \nUse the form of 10s or 5m or 2h\nNo decimals allowed either.</b></span>"
    sh -c "$0"                                            # On error restart.
    exit ;;
esac

START=$COUNT                                              # Set a start point.

until [ "$COUNT" -eq "0" ]; do                            # Countdown loop.
    ((COUNT-=1))                                          # Decrement seconds.
    PERCENT=$((100-100*COUNT/START))                      # Calc percentage.
    echo "#Time remaining$(echo "obase=60;$COUNT" | bc)"  # Convert to H:M:S.
    echo $PERCENT                                         # Outut for progbar.
    sleep 1
done | zenity --title "Egg Timer" --progress --percentage=0 --text=""\
    --window-icon=$ICON --auto-close                      # Progbar/time left.
if [ $? = 1 ]; then exit $?; fi
notify-send -i $ICON "Egg Timer > ## TIMES UP ##"         # Attention finish!
/usr/bin/canberra-gtk-play --volume 4 -f $SOUND           # Ding-dong finish!
zenity --notification --window-icon="$ICON"\
    --text "Egg Timer > ## TIMES UP ##"                   # Indicate finished!
