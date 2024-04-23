#!/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

mpd() {
  song=$($HOME/.config/suckless/scripts/bar/sb-mpd)
  printf "^C7^$song^C8^"
}

pkg_updates() {
  updates=$({ timeout 20 checkupdates+aur 2>/dev/null || true; } | wc -l) # arch
  if [ -z "$updates" ]; then
    printf "^C6^ Fully Updated^C8^"
  else
    printf "^C6^ $updates updates^C8^"
  fi
}

cpu() {
  cpu_val=$($HOME/.config/suckless/scripts/bar/sb-cpu)
  printf "^C3^ $cpu_val^C8^"
}

temp() {
  temp=$($HOME/.config/suckless/scripts/bar/sb-temp)
  printf "^C1^ $temp°C^C8^"
}

mem() {
  mem=$($HOME/.config/suckless/scripts/bar/sb-mem)
  printf "^C5^ $mem C8^"
}

disk() {
   	space="$(df /dev/sda2 -h | awk 'NR ==2 {print $4}')"
   	printf "^C2^ $space free^C8^"
}

battery() {
	if [[ -d /sys/class/power_supply/AC ]]; then
 		printf "^C1^AC^C8^"
	else
  		# Loop through all attached batteries and format the info
		for battery in /sys/class/power_supply/BAT?*; do
			# If non-first battery, print a space separator.
			[ -n "${capacity+x}" ] && printf " "
			
   	
			case "$(cat "$battery/status" 2>&1)" in
				"Full") status="⚡ " ;;
				"Discharging") status="🔋  " ;;
				"Charging") status="🔌 " ;;
				"Not charging") status="🛑  " ;;
				"Unknown") status="♻️  " ;;
				*) exit 1 ;;
			esac
			
   			capacity="$(cat "$battery/capacity" 2>&1)"
			
   			# Will make a warn variable if discharging and low
			[ "$status" = "🔋" ] && [ "$capacity" -le 25 ] && warn="❗"
			
			printf "^C1^%s%s%d%%^C8^" "$status" "$warn" "$capacity"; unset warn
		done && printf "\\n"
  	fi
}

wlan() {
	wifi=$($HOME/.config/suckless/scripts/bar/sb-wifi)
 	[ -z "$wifi" ] && wifi="N/A"
	printf "^C4^󰤭 $wifi^C8^"
}

clock() {
	printf "^C6^$(date '+%H:%M')^C8^"
}

while true; do
	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  	interval=$((interval + 1))
  	sleep 1 && xsetroot -name "$(mpd) | $updates | $(cpu) | $(temp) | $(mem) | $(disk) | $(wlan) | $(battery) | $(clock) "
done
