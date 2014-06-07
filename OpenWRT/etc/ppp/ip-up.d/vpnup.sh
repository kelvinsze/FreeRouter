#!/bin/sh

set -x

LOG="/tmp/autoddvpn.log"
VPNGW=$(ifconfig | grep "pptp" | sed -e "s#^\([^ ]*\) .*#\1#g")
FINAL_GW="dev ""$VPNGW"
RouteScript="/autoddvpn/route.sh"

## add route which was generated from autoddvpn
echo "VPN Connected! Time:$(date)" >> $LOG
echo "Adding static routes...." >>$LOG

/bin/sh "$RouteScript" "route add" "$FINAL_GW"

echo "vpnup.sh completed! Time:$(date)" >> $LOG
sleep 5

## restart dnsmasq
/etc/init.d/dnsmasq restart

exit 0

