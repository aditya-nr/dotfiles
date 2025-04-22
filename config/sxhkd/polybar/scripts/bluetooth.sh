#!/bin/bash
status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
[ "$status" == "yes" ] && echo "On" || echo "Off"

