#!/bin/sh
#NS Lookup for domain listed in DomainList.txt
#And Generate Route add command for host
#Author:Bi Qin
#Website:http://www.lifetype.com
#Version:X00 
#Date2014-05-20
#set -x
DomainList="./Domains.txt"
CleanDNS="8.8.8.8"
TempScript-"./temproute.sh"
OutPutScript="/autoddvpn/route.sh"
if [ -f "$TempScript" ]
then
	rm "$TempScript"
fi
cat $DomainList | while read Domain
do
	echo "##Add for $Domain ##" >>$TempScript
nslookup $Domain $CleanDNS|grep "Address"|sed "1d"|\
awk -F " " '{print $3}'|grep -v ":"|\
sed -e "s#\(.*\)#\$1 -host \1 \$2#g"\
>>$TempScript
done
chmod +x $TempScript
/bin/sh $TempScript "route add" "dev pptp-GFWVPN"
cat $TempScript >> $OutPutScript
exit 0
