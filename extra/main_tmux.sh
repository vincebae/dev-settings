#!/bin/bash

session_name="sbbae"
if tmux has-session -t $session_name; then
    echo "Attaching to existing session..."
    tmux a -t $session_name
else
    echo "Starting a new session..."
    tmux new-session -s $session_name -n "main" -d -c "$HOME" \; \
        split-window -h -d -c "$HOME"
    tmux new-window -n "code" -c "$HOME/code" \; \
        split-window -h -d -c "$HOME/code"
    tmux new-window -n "bin" -c "$HOME/bin" \; \
        split-window -h -d -c "$HOME/bin"
    tmux new-window -n "nvim" -c "$HOME/.config/nvim" \; \
        split-window -h -d -c "$HOME/.config/nvim"
    tmux select-window -t "main"
    tmux attach-session -t $session_name
fi
