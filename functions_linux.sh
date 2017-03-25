#!/usr/bin/env bash

pg_face_init () {
    # if face directory not created yet for desired dimension
    mkdir -p  "$pg_face_dir/faces/$pg_face_theme$pg_face_size"
    # copy new/updated images that are not resized yet and count
    local nb_updated=$(cp --archive --update --verbose plugins/jarvis-face/faces/fluorescent/* plugins/jarvis-face/faces/fluorescent800x480/ | wc -l)
    if [ "$nb_updated" -gt 0 ]; then
        jv_debug "Resizing $pg_face_theme/ into $pg_face_theme$pg_face_size/..."
    
        shopt -s nullglob
        local images=( $(cd $pg_face_dir/faces/$pg_face_theme; echo */*.gif) )
        local nb_images="${#images[@]}"
        local i=0
        jv_progressbar $i $nb_images
        for image in "${nb_images[@]}"; do
            gifsicle --batch \
                     --resize $pg_face_size \
                     --no-warnings \
                     "$pg_face_dir/faces/$pg_face_theme$pg_face_size/$image" || {
                jv_error "An error has occured while resizing the face images"
                jv_exit 1
            }
            let i+=1
            jv_progressbar $i $nb_images
            echo # newline
        done
    fi
    $pg_face_hide_cursor && unclutter -display $pg_face_display_num -root -idle 0.1 & # hide cursor if not used for 0.1 secs
}

pg_face_show () {
    local previous_face_pid="$(pgrep gifview)"
    gifview --title "$trigger" \
            --display $pg_face_display_num \
            --geometry $pg_face_size$pg_face_x_offset$pg_face_y_offset \
            --animate \
            --no-interactive "$1" & # opens new window on top
    if [ -n "$previous_face_pid" ]; then
        (
            sleep 1 # because above (new) window takes time to open before below (previous) is closed
            kill $previous_face_pid 2>/dev/null # closes previous window behind
            wait $previous_face_pid 2>/dev/null # to suppress Terminated messages
        ) & # sleep not blocking
    fi
}

pg_face_exit () {
    killall -q gifview
    $pg_face_hide_cursor && killall -q unclutter # show back cursor if chosen to hide it
}
