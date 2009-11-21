#!/bin/sh
#
# Shows given animations using Ulf's 'showanim' program
#
# The number of frames for animations having non-square frames
# has to correspond to number of frames used in the Makefile.

echo "*******************************************************"
echo "* SPACE = pause, Arrows = forward/reverse, ESC = next *"
echo "*******************************************************"

# Solarwolf background color
bg=000000

for pic in $*; do
    echo "Viewing '$pic'..."
    # set number of frames for the special cases
    frames=""
    case $(echo $pic|sed 's/\.png$//') in
    	 baddie) frames="16" ;;
	 baddie-teleport) frames="32" ;;
	 ship-warp) frames="12" ;;
    esac
    if [ -z $frames ]; then
       ./showanim --bg $bg $pic
    else
       ./showanim --bg $bg --frames $frames $pic
    fi
done
