#!/bin/sh

set -x
export PATH="/bin:/sbin:/usr/sbin:/usr/bin"

LOG='/tmp/autoddvpn.log'

case $1 in
     "pptp-GFWVPN")
        goto addRoute
        ;;
      *)
        # others
        exit 0
        ;;
esac

addRoute:
## add route which was generated from autoddvpn
echo "VPN Connected! Time:$(date)" >> $LOG
echo "Adding static routes...." >>$LOG
/bin/sh /autoddvpn/route.sh "route add" "dev pptp-GFWVPN"
echo "vpnup.sh completed! Time:$(date)" >> $LOG
sleep 5

## restart dnsmasq
/etc/init.d/dnsmasq restart

exit 0

