#!/bin/bash

flutter pub get > /dev/null 2>&1 || true

flutter $1 $2 $3 $4 $5 $6 $7 $8 $9

# chown $UID:$GID -R $(pwd)

exit
