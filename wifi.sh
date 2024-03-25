nmcli radio wifi on
sleep 4
w=$(nmcli -f SSID,RATE device wifi list | awk 'NR > 1 { print NR-1, $0 }' | smenu -c -W $'\n')

p=$(echo $w | awk '{for (i=2; i<=NF-2; i++) printf $i" "; print ""}')
#p=$(echo "$p" | sed 's/ \+/ /g')
#echo $p

p=$(echo "$p" | sed -e 's/[[:space:]]*$//')


echo -n "Enter password for $p: "
read -s password


nmcli dev wifi connect "$p" password "$password" &>/dev/null

if [ $? -eq 0 ]; then
    echo "Successfully connected to Wi-Fi network."
else
    echo "Error: Unable to connect to Wi-Fi network."
fi


