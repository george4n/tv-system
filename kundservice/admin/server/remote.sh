#/bin.bash

target=/mnt/kundservice/$USER/.config/tv_profile.conf
. /mnt/kundservice/$USER/.config/tv_profile.conf
USER=`whoami`

if [[ ! -e $target ]]; then
  zenity --question --title "First time Setup" --text "Would you like to setup Remote Desktop Services?"
    if [[ $? = 1 ]]; then
      exit
    else
      REMOTE=$(zenity --entry --text "Enter your REMOTE Username" --entry-text "username");
        if [[ $? = 1 ]]; then
          exit
        else
          zenity --question --title "Confirmation" --text "Is your username correct? \n\nThis operation cannot be undone without a System Administrator"
        fi
      if [[ $? = 0 ]]; then
        echo "REMOTEUSER=$REMOTE" >> $target
        zenity --info --text "Configured Successfully!" --timeout 2
        /mnt/.system/kundservice/admin/server/./remote.sh &
        exit 0
      else
        exit
      fi
    fi
else
  # rdesktop -d 3INTERNAL 172.28.64.150 -u $REMOTEUSER -k sv -g 1853x1056 -P -b -D -N -a 16 -z -5 -x m -z -B -r sound:off -r disk:share=/mnt/kundservice/$USER/Documents/ &
  rdesktop -d 3INTERNAL 172.28.64.150 -k sv -g 1853x1056 -P -b -D -N -a 16 -z -5 -x m -z -B -r sound:off -r disk:share=/mnt/kundservice/$USER/Documents/ &
  echo "$HOSTNAME remote desktop by `getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1` ($USER)" | /mnt/.system/kundservice/admin/server/slacktee.sh -p -a good
fi

# -z add for RDP datastream compression
# -P bitmap aching, speeds up xfers
# -F forcibly disable the internal backing buffer
# -b Force the server to send screen updates as bitmaps rather than using higher-level drawing operations.
