#!/bin/bash
for i in 1 2 3; do
    echo "Starting loop $i"
    # Simulating mpv in background
    sleep 1 &
    PID=$!
    while kill -0 $PID 2>/dev/null; do
        echo "Loop $i still running"
        sleep 0.5
    done
    echo "Loop $i finished"
done
