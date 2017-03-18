#!/bin/bash
# Use only if you need to perform changes on the user system such as installing software
if [ "$platform" == "linux" ]; then
    jv_install gifsicle unclutter libjpeg-dev # https://github.com/alexylem/jarvis/issues/483
    sudo pip install pillow
fi
