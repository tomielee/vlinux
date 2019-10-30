#!/usr/bin/env bash
#
# A Script to create a json-file
#
# input     data/access-50k.log
# output    data/log.json


LOG="access-50k.log"

JFILE="data/log.json"

function createJson
{
    createFiles

    local regex_ip="([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})"
    local regex_url="((https?)+(\:\/\/)+([A-Za-z0-9_~]+\.)+([A-Za-z0-9_~]+(\.|\/){1,4}))"

    #not a good soloution! Check the complete json solution containing \[ and \: etc.
    local regex_day="([0-9]{1,2})" 
    local regex_month="([A-Za-z]{3})"
    local regex_year="([0-9]{4})"
    local regex_time="([0-9]{2}:[0-9]{2}:[0-9]{2})"

    #Complete get all data to a json variable.
    json=$( cat "$LOG" | sed -nE  \
        -e 's/'"$regex_ip"'.*\['"$regex_day"'\/'"$regex_month"'\/'"$regex_year"'\:'"$regex_time"'.*'"$regex_url"'.*/{| "ip": "\1",| "day": "\2",| "month": "\3",| "year": "\4",| "time": "\5",| "url": "\6"|},/p' \
        | tr '|' '\n' \
        )
    
    printf '[\n%s\n]\n' "${json::-1}" > "$JFILE" 
    
    # Use on mac
    # json=$( cat "$LOG" | sed -nE  \
    # -e 's/'"$regex_ip"'.*\['"$regex_day"'\/'"$regex_month"'\/'"$regex_year"'\:'"$regex_time"'.*'"$regex_url"'.*/{| "ip": "\1",| "day": "\2",| "month": "\3",| "year": "\4",| "time": "\5",| "url": "\6"|},/p' \
    # -e '$ s/\,$//p' \
    # | tr '|' '\n' \
    # )
    # printf '[\n%s\n]\n' "${json}" > "$JFILE" 

}   


function createFiles
{
    # touch data/test.txt
    touch data/log.json
    
    # chmod +x data/*.txt
    chmod +x data/log.json
}

createJson






#TEST STUFF
#
# LOG="access-50k-mini.log"

# TESTFILE="data/test.txt"

    # sed -nE 's/.*'"$regex_url"'.*/\1/p' "$LOG" > "$TESTFILE"
    # sed -nE 's/'"$regex_ip"'.*/\1/p' "$LOG" > "$TESTFILE"
    # sed -nE 's/.*\['"$regex_day"'.*/\1/p' "$LOG" > "$TESTFILE"
    # sed -nE 's/.*'"$regex_month"'.*/\1/p' "$LOG" > "$TESTFILE"