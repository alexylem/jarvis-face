#!/bin/bash
# Use only if you need to undo changes on the user system such as removing software
if [ "$platform" == "linux" ]; then
    jv_remove gifsicle
    jv_yesno "Uninstall Pillow?" && sudo pip remove pillow
fi
