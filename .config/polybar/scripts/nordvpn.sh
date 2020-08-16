#!/bin/bash

status=$(nordvpn status | grep Status | cut -d ' ' -f 6)

echo " $status"
