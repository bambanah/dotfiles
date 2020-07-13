#!/bin/sh

#
# Script to display the currently playing song on any player supported
# by playerctl (usually Spotify)
#

# If no players are open, show nothing
if [ "$(playerctl -l | grep -v playerctld | wc -l)" = 0 ]; then

  echo ""

# If music is playing, display a pause icon
elif [ "$(playerctl status)" = "Playing"  ]; then

  playerctl --player=playerctld metadata --format " {{ title }} - {{ artist }}"

# If music is paused, display a play icon
elif [ "$(playerctl status)" = "Paused"  ]; then

  playerctl --player=playerctld metadata --format " {{ title }} - {{ artist }}"

fi
