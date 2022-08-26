#!/bin/bash

tcpser -v 25232 -p 6400 -tsS -i 'K0' -l 7 -s 300 -N “/tmp/noanswer.txt” -B “/tmp/busy.txt”

