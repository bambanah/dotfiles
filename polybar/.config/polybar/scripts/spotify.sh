#!/bin/bash

if [ "$(playerctl --player=playerctld status)" = "Stopped" ]; then

  echo ""

elif [ "$(playerctl --player=playerctld status)" = "Paused"  ]; then

  playerctl --player=playerctld metadata --format " {{ title }} - {{ artist }}"

else # Can be configured to output differently when player is paused

  playerctl --player=playerctld metadata --format " {{ title }} - {{ artist }}"

fi
