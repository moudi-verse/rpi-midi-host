#!/bin/bash

while true; do
  MPK_CLIENT=$(aconnect -l | awk '/MPK/ {gsub(":", "", $2); print $2; exit}')
  CME_CLIENT=$(aconnect -l | awk '/U2MIDI/ {gsub(":", "", $2); print $2; exit}')

  if [ -n "$MPK_CLIENT" ] && [ -n "$CME_CLIENT" ]; then
    echo "MIDI devices found: MPK=$MPK_CLIENT CME=$CME_CLIENT"
    aconnect -d "${CME_CLIENT}:0" "${MPK_CLIENT}:0" 2>/dev/null
    aconnect "${MPK_CLIENT}:0" "${CME_CLIENT}:0" 2>/dev/null
    echo "MIDI connected!"
    exit 0
  fi

  sleep 0.2
done
