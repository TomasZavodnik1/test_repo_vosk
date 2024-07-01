#!/bin/sh

grep -rl '@bash@' | xargs sed -i 's/@bash@/"%bash%"/g'
