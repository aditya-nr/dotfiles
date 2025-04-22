#!/bin/bash
brightness=$(brightnessctl | grep -oP '\(\K[0-9]+(?=%\))')
echo " ${brightness}%"

