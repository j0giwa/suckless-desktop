#!/bin/sh

pidof -s picom || picom &
pidof -s unclutter || unclutter &
pidof -s udiskie || udiskie  &
pidof -s dwm && pidof -s $HOME/.config/suckless/scripts/bar.sh || $HOME/.config/suckless/scripts/bar.sh & # dwm bar

bar.sh &
while type dwm >/dev/null; 
do 
	dwm && 
	continue || 
	break; 
done
