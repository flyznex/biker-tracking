#!/bin/sh

TARGET_FILE="$1"
if [ -z "$TARGET_FILE" ]
then
   TARGET_FILE="dummy"
fi
CURRENT_TIME=`date +'%s'`
FILE_DIR_UP="../store/db/migrations/${CURRENT_TIME}_${TARGET_FILE}.up.sql"
FILE_DIR_DOWN="../store/db/migrations/${CURRENT_TIME}_${TARGET_FILE}.down.sql"

if [ ! -f "$FILE_DIR_UP" ]; then
    touch $FILE_DIR_UP
fi

if [ ! -f "$FILE_DIR_DOWN" ]; then
    touch $FILE_DIR_DOWN
fi
