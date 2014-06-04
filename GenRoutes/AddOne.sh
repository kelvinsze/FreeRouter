#!/bin/sh
#NS Lookup for domain passed through shell command 
#And Generate Route add command for host
#Author:Bi Qin
#Website:http://www.lifetype.com
#Version:X00 
#Date2014-05-20
set -x
CleanDNS=8.8.8.8
TempScript="./temproute.sh"
OutPutScript="/autoddvpn/route.sh"
Domain="$1"
DomainList="./Domains.txt"
if [ -f "$TempScript" ]
then
	rm "$TempScript"
fi
echo "#Add for $Domain" >>$TempScript
echo "$Domain" >>$DomainList
nslookup $Domain $CleanDNS|grep "Address"|sed '1d'|\
awk -F " " '{print $3'}|grep -v ":"|\
sed -e "s#\(.*\)#\$1 -host \1 \$2#g"\
>>$TempScript
chmod +x $TempScript
/bin/sh $TempScript "route add" "dev pptp-GFWVPN"
cat $TempScript >>$OutPutScript
exit 0
