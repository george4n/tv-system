#/bin.bash

USER=`whoami`
zenity --timeout=20 --title "System Authority - Remote Desktop" --question --text="Do you want to run in Split-Screen mode?"
if [ $? = 0 ]; then
rdesktop -d 3INTERNAL 172.28.64.150 -k sv -g 926x1056-0-10 -b -D -N -a 15 -z -P -5 -x m -r sound:off -r disk:share=/mnt/telesales/$USER/Documents/
else
rdesktop -d 3INTERNAL 172.28.64.150 -k sv -g 1853x1056 -b -D -N -a 15 -z -P -5 -x m -r sound:off -r disk:share=/mnt/telesales/$USER/Documents/
fi

#-r disk:share=/home/bayo/store
