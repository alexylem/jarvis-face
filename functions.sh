#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
# To avoid conflicts, name your function like this
# pg_XX_myfunction () { }
# pg for PluGin
# XX is a short code for your plugin, ex: ww for Weather Wunderground
# You can use translations provided in the language folders functions.sh

pg_face_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get absolute path

source $pg_face_dir/functions_$platform.sh

pg_face_get_random () {
    faces=( $pg_face_dir/faces/$pg_face_theme/$1/* ) # list images for given state
    echo "${faces[RANDOM%${#faces[@]}]}" # take 1 randomly
}

pg_face_state () {
    if [ -n "$1" ]; then
        face="$(pg_face_get_random "$1")"
        if [ -n "$2" ]; then # why not merged with if below??
            local face_duration="$(python "$pg_face_dir/gifduration.py" "$face")"
        fi
        pg_face_show "$face"
        if [ -n "$2" ]; then
            sleep $face_duration
            # use http://ezgif.com/maker to set loop nb to 1
            if [ "$2" != true ]; then # true is just to sleep on first state
                face="$(pg_face_get_random "$2")"
                pg_face_show "$face"
            fi
        fi
    fi
}
