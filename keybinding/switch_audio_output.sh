#!/bin/bash

# First way. Simpler one, but for some reason this wasnt working for me one day.
suspend_sink=$(pactl list short sinks | grep -E 'SUSPENDED|IDLE' | awk '{print $2}')
pactl set-default-sink $suspend_sink



# Second way
# # Take sinks index
# sinks_input_index=$(pacmd list-sink-inputs | grep index | awk '{print $2}')

# # running_sink=$(pactl list short sinks | grep -E 'RUNNING' | awk '{print $2}')
# # In my case one sink is running, the other one is not. Just check which one is not running and switch all sinks to that
# suspend_sink=$(pactl list short sinks | grep -E 'SUSPENDED|IDLE' | awk '{print $2}')


# # For every sink switch from suspend/idle to running
# for sink in $sinks_input_index; do
# 	pactl move-sink-input $sink $suspend_sink
# done