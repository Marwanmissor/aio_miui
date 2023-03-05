
RD="$RANDOM"
while true; do
echo > /sdcard/$RD
if [ -e /sdcard/$RD ];then
rm -fr /sdcard/$RD
break
else
sleep 2
fi
done

sleep 20
# Fix

( while true; do

kncfgvv="$(grep -m1 "ListApp=" ${0%/*}/module.prop | cut -d "=" -f2 | tr ',' '\n')";
[ "$kncfgvv" ] || kncfgvv="$(pm list packages -3 | cut -d : -f2)";

for Ksksn in $kncfgvv; do
dumpsys deviceidle whitelist +$Ksksn >/dev/null
appops set $Ksksn 10008 allow
appops set $Ksksn 10021 allow
appops set $Ksksn RUN_IN_BACKGROUND allow
appops set $Ksksn RUN_ANY_IN_BACKGROUND allow
appops set $Ksksn START_FOREGROUND allow
sleep 2
done
sleep 120

done ) &
