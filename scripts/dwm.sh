#!/bin/sh

pidof -s picom || picom &
pidof -s unclutter || unclutter &
pidof -s udiskie || udiskie  &
#pidof -s nm-applet || nm-applet  &
pidof -s dwm && pidof -s $HOME/.config/suckless/master/scripts/bar.sh || $HOME/.config/suckless/master/scripts/bar.sh & # dwm bar

setbg # fix wallpaper just in case

while type dwm >/dev/null; 
do 
	dwm && 
	continue || 
	break; 
done
