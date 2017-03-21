#!/bin/bash
# Use only if you need to undo changes on the user system such as removing software
if [ "$platform" == "linux" ]; then
    jv_remove imagemagick unclutter
    jv_remove gifsicle # retrocompatibility
    jv_yesno "Uninstall Pillow?" && sudo pip uninstall pillow
fi
