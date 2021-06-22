#!/bin/sh

#
# Script to display the currently playing song on any player supported
# by playerctl (usually Spotify)
#

# Check if there are any players open
playerctl status &> /dev/null

# If previous command returns with an error, then no
# players are open so show nothing
if [ "$?" = 1 ]; then

  echo ""

# If music is playing, display a pause icon
elif [ "$(playerctl status)" = "Playing"  ]; then

  playerctl --player=playerctld metadata --format " {{ title }} - {{ artist }}"

# If music is paused, display a play icon
elif [ "$(playerctl status)" = "Paused"  ]; then

  playerctl --player=playerctld metadata --format " {{ title }} - {{ artist }}"

fi
