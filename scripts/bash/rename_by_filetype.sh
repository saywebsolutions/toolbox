#!/bin/sh

# Bulk rename files with a given extension.
#
# @param extension | svg
# @param new_name | name
# Usage: rename svg new_name
function rename_by_filetype() {

    echo "———————————————— STARTED ————————————————"

    # Counter.
    COUNTER=1

    # For do loop.
    for file in *."$1"; do
        mv "$file" "$2-$COUNTER.$1"
        COUNTER=$[$COUNTER +1]
    done

    echo "———————————————— ✔✔✔ RENAMED Every $1 file in the PWD! ✔✔✔︎ ————————————————"

}
