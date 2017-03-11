#!/usr/bin/env bash
pg_face_init () {
    osascript -e "tell application \"Safari\" to open location \"about:blank\""
    osascript -e "tell application \"Safari\" to activate"
}

pg_face_show () {
    osascript -e "tell application \"Safari\" to set URL of the front document to \"file://$1\""
}

pg_face_exit () {
    osascript -e 'tell window 1 of application "Safari" to close current tab'
}
