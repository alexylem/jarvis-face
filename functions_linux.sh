#!/usr/bin/env bash

pv_face_pid_previous=false
pv_face_pid_current=false

pg_face_init () {
    : # do nothing / function definition needed for osx
}

pg_face_show () {
    gifview --display :0 --title "Jarvis" --animate --no-interactive "$1" & # opens new window on top
    pv_face_pid_current=$! # gets new window pid
    [ "$pv_face_pid_previous" != "false" ] && kill $pv_face_pid_previous 2>/dev/null # closes previous window behind
    pv_face_pid_previous=$pv_face_pid_current # save new window pid to close later
}

pg_face_exit () {
    killall -q gifview # killall instead of pv_face_pid_previous just in case...
}
