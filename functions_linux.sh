#!/usr/bin/env bash
pg_face_init () {
    : # do nothing
}

pg_face_show () {
    gifview --animate "$1"
}

pg_face_exit () {
    killall gifview
}
