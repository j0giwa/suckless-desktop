#!/bin/sh

pidof -s picom || picom &
pidof -s unclutter || unclutter &
pidof -s udiskie || udiskie  &
pidof -s dwm && pidof -s $HOME/.config/suckless/master/scripts/bar.sh || $HOME/.config/master/suckless/scripts/bar.sh & # dwm bar

while type dwm >/dev/null; 
do 
	dwm && 
	continue || 
	break; 
done
