if [[ $(pactl list sinks | grep "Volume: "| awk '{print $5}'|head -n 1|cut -d'%' -f1) -lt 120 ]]; then pactl set-sink-volume @DEFAULT_SINK@ +5%; else exit 0; fi
