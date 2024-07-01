#!/bin/sh

VAR='%bash%';
VAR=$(echo $VAR | sed 's=/=\\/=g'); 

grep -r '{@bash@}' | xargs sed -i "s/@bash@/$VAR/g";
