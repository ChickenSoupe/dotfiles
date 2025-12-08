if pgrep -x "hypridle" >/dev/null ;then
  killall hypridle
else
  hypridle
fi
