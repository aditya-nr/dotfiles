#!/bin/bash

# Get default sink (output device) ID
default_sink_id=$(wpctl status | awk '/Sinks:/,/Sink endpoints:/' | grep '\*' | sed -E 's/[^0-9]*([0-9]+).*/\1/')

# Fallback
[ -z "$default_sink_id" ] && default_sink_id="@DEFAULT_AUDIO_SINK@"

# Get volume + mute status
volume_line=$(wpctl get-volume "$default_sink_id")
volume_percent=$(echo "$volume_line" | grep -oP '[0-9.]+')
is_muted=$(echo "$volume_line" | grep -q MUTED && echo "true" || echo "false")

# Format output
if [ "$is_muted" = "true" ]; then
	echo " Muted"
else
	echo " ${volume_percent}"
fi

