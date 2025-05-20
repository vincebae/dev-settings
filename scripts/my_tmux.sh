#!/bin/bash

session_name="sbbae"
window_name_1="one"
window_path_1="$HOME"
window_name_2="two"
window_path_2="$HOME"
window_name_3="three"
window_path_3="$HOME"
window_name_4="four"
window_path_4="$HOME/.config/myconfig"
split_window_size="70%"

if tmux has-session -t $session_name; then
    echo "Attaching to existing session..."
    tmux a -t $session_name
else
    echo "Starting a new session..."
    tmux new-session -s $session_name -n $window_name_1 -c $window_path_1 \; \
        split-window -h -d -c $window_path_1 -l $split_window_size \; \
        split-window -v -d -c $window_path_1 -t 2 \; \
        detach
    tmux attach-session -t $session_name \; \
        new-window -n $window_name_2 -c $window_path_2 \; \
        split-window -h -d -c $window_path_2 -l $split_window_size \; \
        split-window -v -d -c $window_path_2 -t 2 \; \
        detach
    tmux attach-session -t $session_name \; \
        new-window -n $window_name_3 -c $window_path_3 \; \
        split-window -h -d -c $window_path_3 -l $split_window_size \; \
        split-window -v -d -c $window_path_3 -t 2 \; \
        detach
    tmux attach-session -t $session_name \; \
        new-window -n $window_name_4 -c $window_path_4 \; \
        split-window -h -d -c $window_path_4 -l $split_window_size \; \
        detach

    # Attach to seesion with the first window selected
    tmux attach-session -t $session_name \; \
        select-window -t $window_name_1
fi
