#!/bin/bash

# This script sets up pulseaudio virtual devices
# The following variables must be set to the names of your own microphone and speakers devices
# You can find their names with the following commands :
# pacmd list-sources
# pacmd list-source-outputs
# Use pavucontrol to make tests for your setup, and to make the runtime configuration

MICROPHONE="alsa_input.pci-0000_00_1b.0.analog-stereo"
SPEAKERS="alsa_output.pci-0000_00_1b.0.analog-stereo"

# Create the null sinks
# virtual1 is to send line in/mic to discord
# virtual2 takes all streams you want to mix to your speakers/headphones
# virtual3 is the audio stream sent to twitch (song requests music)
pactl load-module module-null-sink sink_name=virtual1 sink_properties=device.description="speakers_out"
pactl load-module module-null-sink sink_name=virtual2 sink_properties=device.description="stream_out"

# Now create the loopback devices, all arguments are optional and can be configured with pavucontrol
# pactl load-module module-loopback source=$MICROPHONE sink=virtual1
pactl load-module module-loopback source=virtual1.monitor sink=$SPEAKERS
pactl load-module module-loopback source=virtual2.monitor sink=$SPEAKERS

# If you struggle to find the correct values of your physical devices, you can also simply let these undefined, and configure evrything manually via pavucontrol
# pactl load-module module-loopback source=virtual1.monitor
# pactl load-module module-loopback source=virtual1.monitor sink=virtual2
# pactl load-module module-loopback sink=virtual2
