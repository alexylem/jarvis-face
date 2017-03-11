#!/usr/bin/env bash

pg_face_init () {
    : # do nothing / function definition needed for osx
}

pg_face_show () {
    local previous_face_pid="$(pgrep gifview)"
    gifview --display :$pg_face_display_num --title "Jarvis" --animate --no-interactive "$1" & # opens new window on top
    if [ -n "$previous_face_pid" ]; then
        (
            sleep 0.5 # because above (new) window takes time to open before below (previous) is closed
            kill $previous_face_pid # closes previous window behind
            #wait $previous_face_pid 2>/dev/null # to suppress Terminated messages
        ) & # sleep not blocking
    fi
}

pg_face_exit () {
    killall -q gifview
}
