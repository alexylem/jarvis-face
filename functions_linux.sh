#!/usr/bin/env bash

pg_face_init () {
    : # do nothing / function definition needed for osx
}

pg_face_show () {
    local previous_face_pid="$(pgrep gifview)"
    gifview --display :$pg_face_display_num --title "Jarvis" --animate --no-interactive "$1" & # opens new window on top
    # add sleep?
    [ -n "$previous_face_pid" ] && kill $previous_face_pid # closes previous window behind
    # add wait $previous_face_pid 2>/dev/null to suppress Terminated messages
}

pg_face_exit () {
    killall -q gifview
}
