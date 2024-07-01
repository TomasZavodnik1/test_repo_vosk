#!/bin/sh

VAR='%bash%';
VAR=$(echo $VAR | sed 's=/=\\/=g'); 

grep -rl '{@bash@}' | xargs sed -i "s/@bash@/$VAR/g";
