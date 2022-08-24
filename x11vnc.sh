#!/bin/bash

/usr/bin/x11vnc -rfbauth /home/vice/.vnc/passwd -xkb -noxrecord -noxfixes -noxdamage -wait 5 -shared -auth /tmp/.Xauthority -display :99

