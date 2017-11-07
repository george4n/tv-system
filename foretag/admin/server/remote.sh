#/bin.bash

USER=`whoami`

rdesktop -d 3INTERNAL 172.28.64.150 -k sv -g 1853x1056 -P -b -D -N -a 16 -z -5 -x m -z -B -r sound:off -r disk:share=/mnt/foretag/$USER/Documents/



# -z add for RDP datastream compression
# -P bitmap aching, speeds up xfers
# -F forcibly disable the internal backing buffer
# -b Force the server to send screen updates as bitmaps rather than using higher-level drawing operations.
