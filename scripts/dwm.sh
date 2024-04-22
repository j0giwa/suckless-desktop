#!/bin/sh

pidof -s picom || picom &
pidof -s unclutter || unclutter &
pidof -s udiskie || udiskie  &
#pidof -s nm-applet || nm-applet  &
pidof -s $HOME/.config/suckless/scripts/bar.sh || $HOME/.config/suckless/scripts/bar.sh & # dwm bar

[[ -f .cache/wallpaper/wal.png ]] && setbg || setbg $HOME/.config/suckless/dwm/wallpaper.jpg # set the wallpaper

while type dwm >/dev/null; 
do 
	dwm && 
	continue || 
	break; 
done
