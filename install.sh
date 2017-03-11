#!/bin/bash
# Use only if you need to perform changes on the user system such as installing software
if [ "$platform" == "linux" ]; then
    hash 'pico2wave' 2>/dev/null || jv_install gifsicle
fi
