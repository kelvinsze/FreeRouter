#!/bin/sh
set -x
export PATH="/bin:/sbin:/usr/sbin:/usr/bin"

LOG='/tmp/autoddvpn.log'
echo "VPN Disconnected!! Time:$(date)" >> $LOG
exit 0

