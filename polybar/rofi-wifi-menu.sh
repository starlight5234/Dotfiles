#!/usr/bin/env bash

# Starts a scan of available broadcasting SSIDs
# nmcli dev wifi rescan

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FIELDS=SSID,SECURITY,BARS
FONT="FuraCode Nerd Font Mono 8"
POSITION=3
YOFF=40
XOFF=-10

LIST=$(nmcli --fields "$FIELDS" device wifi list | awk -F'  +' '{ if (!seen[$1]++) print}' | sed -n '1!p')
if [ -z $LIST ];then
	LIST="No visible networks found"
fi

# For some reason rofi always approximates character width 2 short... hmmm
RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+3))

# Dynamically change the height of the rofi menu
LINENUM=$(($(echo "$LIST" | wc -l) + 2))
if [  $LINENUM -le "3" ];then
	LINENUM=3
elif [  $LINENUM -ge "10" ];then
	LINENUM=10
fi

# Gives a list of known connections so we can parse it later
KNOWNCON=$(nmcli connection show)
# Really janky way of telling if there is currently a connection
CONSTATE=$(nmcli -fields WIFI g)

CURRSSID=$(LANGUAGE=C nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')

if [[ ! -z $CURRSSID ]]; then
	HIGHLINE=$(echo  "$(echo "$LIST" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}') + 1" | bc )
fi

# HOPEFULLY you won't need this as often as I do
# If there are more than 8 SSIDs, the menu will still only have 8 lines

if [[ "$CONSTATE" =~ "enabled" ]]; then
	CHENTRY=$(echo -e "Toggle Off\nManual\n$LIST" | uniq -u | rofi -dmenu -p "Wi-Fi SSID " -lines "$LINENUM" -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -font "$FONT" -width -"$RWIDTH")
elif [[ "$CONSTATE" =~ "disabled" ]]; then
	LINENUM=1
	RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+25))
	CHENTRY=$(echo -e "Toggle On" | uniq -u | rofi -dmenu -p "Wi-Fi SSID " -lines "$LINENUM" -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -font "$FONT" -width -"$RWIDTH")
fi

CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')

# If the user inputs "manual" as their SSID in the start window, it will bring them to this screen
if [ "$CHENTRY" = "Manual" ] ; then
	# Manual entry of the SSID and password (if appplicable)
	MSSID=$(echo "Enter the SSID of the network" | rofi -dmenu -p "SSID " -font "$FONT" -lines 1)
	# Separating the password from the entered string
	MPASS=$(echo "Enter the password of the network" | rofi -dmenu -p "Password " -font "$FONT" -lines 1)

	# Exit if no Manual SSID Entered
	if [ "$(echo $MSSID | awk '{print $3}')" = "SSID" ]; then
		echo "No SSID was given" | rofi -dmenu -p "" -lines "1" -location -font "$FONT" -width -"25"
		exit 0
	elif [ "$(echo $MPASS | awk '{print $3}')" = "password" ]; then
		nmcli dev wifi con "$MSSID" password "$MPASS"
	else
		nmcli dev wifi con "$MSSID"
	fi
	# If the user entered a manual password, then use the password nmcli command
	if [ "$MPASS" = "" ]; then
		nmcli dev wifi con "$MSSID"
	else
		nmcli dev wifi con "$MSSID" password "$MPASS"
	fi

elif [ "$CHENTRY" = "Toggle On" ]; then
	nmcli radio wifi on

elif [ "$CHENTRY" = "Toggle Off" ]; then
	nmcli radio wifi off

else

	# If the connection is already in use, then this will still be able to get the SSID
	if [ "$CHSSID" = "*" ]; then
		CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')
	fi

	# Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
	if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
		nmcli con up "$CHSSID"
	else
		if [[ "$CHENTRY" =~ "WPA2" ]] || [[ "$CHENTRY" =~ "WEP" ]]; then
			WIFIPASS=$(echo "If connection is stored, hit enter." | rofi -dmenu -p "Passphrase " -lines 1 -font "$FONT" )
		fi

		if [ $(echo "$WIFIPASS" | sed 's/.*connection.*/connection/g') = "connection" ];then
			WIFI_PASS=$(nmcli -s -g 802-11-wireless-security.psk connection show $CHSSID)
			nmcli dev wifi con "$CHSSID" password "$WIFI_PASS"
		else
			nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
		fi
	fi

fi
