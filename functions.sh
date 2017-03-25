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

# check face exists
if [ ! -d "$pg_face_dir/faces/$pg_face_theme/" ]; then
    jv_error "ERROR: face theme '$pg_face_theme' not found" # trailing / to test empty dir
    jv_warning "HELP: verify pg_face_theme in jarvis-face plugin config"
    jv_exit 1
fi

# echoes filepath picked randomly in $1 state of face theme folder, false if none
# usage:
#   facefile="$(pg_face_get_random "happy")"
pg_face_get_random () {
    shopt -s nullglob
    local faces=( $pg_face_dir/faces/$pg_face_theme$pg_face_size/$1/* ) # list images for given state
    local count=${#faces[@]}
    if [ $count -gt 0 ]; then
        echo "${faces[RANDOM%${#faces[@]}]}" # take 1 randomly
    else
        echo false
    fi
}

# echoes total duration of gif $1
pg_face_gifduration () {
    gifsicle --info --no-warnings "$1" \
        | grep delay  \
        | sed -ne 's#.*delay[^0-9]*\([0-9]*.[0-9]*\)s.*#\1#p' \
        | LC_NUMERIC=en_US.UTF-8 awk '{ SUM += $1} END { print SUM }'
}

# displays a random face for 1 or 2 successive states in parameter
# usage:
# display neutral state without blocking jarvis
#   pg_face_state "neutral" &
# display happy animation once then neutral state
#   pg_face_state "happy" "neutral"
# display exit animation and force wait until end of animation
#   pg_face_state "exit" true
pg_face_state () {
    face1="$(pg_face_get_random "$1")"
    if [ "$face1" == false ]; then
        jv_warning "WARNING: No face found for $1 state"
        jv_warning "HELP: Add gifs or disable $1 animation in face plugin config"
    else
        pg_face_show "$face1"
    fi
    if [ -n "$2" ]; then
        # if $2 is true or second face to display, wait face1 animation is complete
        [ "$face1" != false ] && sleep "$(pg_face_gifduration "$face1")"
        # use http://ezgif.com/maker to set loop nb to 1
        if [ "$2" != true ]; then # true is just to sleep on first state
            face2="$(pg_face_get_random "$2")"
            if [ "$face2" == false ]; then
                jv_warning "WARNING: No face found for $2 state"
                jv_warning "HELP: Add gifs or disable $2 animation in face plugin config"
            else
                pg_face_show "$face2"
            fi
        fi
    fi
}
