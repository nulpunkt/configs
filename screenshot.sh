#!/bin/sh
# Install with sudo ln -s /home/jesper/configs/screenshot.sh /usr/local/bin/screenshot
import png:- | xclip -selection clipboard -t image/png
