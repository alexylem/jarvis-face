#!/bin/bash
# Use only if you need to undo changes on the user system such as removing software
if [ "$platform" == "linux" ]; then
    jv_remove gifsicle unclutter
    jv_remove imagemagick # retrocompatibility
    jv_yesno "Uninstall Pillow?" && sudo pip uninstall pillow
fi
