#!/bin/bash

default_source_id=$(wpctl status | awk '/Sources:/,/Source endpoints:/' | grep '\*' | sed -E 's/[^0-9]*([0-9]+).*/\1/')
[ -z "$default_source_id" ] && default_source_id="@DEFAULT_AUDIO_SOURCE@"
wpctl set-mute "$default_source_id" toggle

