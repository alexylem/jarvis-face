#!/bin/bash
# Use only if you need to perform changes on the user system such as installing software
jv_install gifsicle # for gif duration on all platforms (incl. OSX)
if [ "$platform" == "linux" ]; then
    jv_install unclutter # hide mouse pointer
fi
