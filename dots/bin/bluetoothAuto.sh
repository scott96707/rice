#!/bash/bin

pactl unload-module module-bluetooth-discover
pactl load-module module-bluetooth-discover
