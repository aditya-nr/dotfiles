#!/bin/bash

# Dynamically get the default source ID
default_source_id=$(wpctl status | awk '/Sources:/,/Source endpoints:/' | grep '\*' | sed -E 's/[^0-9]*([0-9]+).*/\1/')
# Fallback
[ -z "$default_source_id" ] && default_source_id="@DEFAULT_AUDIO_SOURCE@"

# Check mute status
is_muted=$(wpctl get-volume "$default_source_id" | grep -q MUTED && echo "true" || echo "false")

if [ "$is_muted" = "true" ]; then
	echo " Muted"
else
	echo " On"
fi
