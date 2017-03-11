#!/usr/bin/env bash

pv_face_previous_pid=false

pg_face_init () {
    : # do nothing / function definition needed for osx
}

pg_face_show () {
    gifview --display :0 --title "Jarvis" --animate --no-interactive "$1" & # opens new window on top
    local pid=$! # gets new window pid
    [ "$pv_face_previous_pid" != "false" ] && kill $pv_face_previous_pid # closes previous window behind
    pv_face_previous_pid=$pid # save new window pid to close later
}

pg_face_exit () {
    killall -q gifview # killall instead of pv_face_pid_previous just in case...
}
