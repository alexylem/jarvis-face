#!/bin/bash
# Use only if you need to undo changes on the user system such as removing software
jv_remove gifsicle
if [ "$platform" == "linux" ]; then
    jv_remove unclutter
    jv_remove imagemagick # retrocompatibility
fi
