#!/bin/sh

VAR='%bash%'
VAR= $(echo $VAR | sed "s/\//\\/")
grep -rl '@bash@' | xargs sed -i "s/@bash@/{$VAR}/g"
