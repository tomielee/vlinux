#!/usr/bin/env bash
#
# A command line scipts
# Kmom03 Vlinux
#
# Exit values:
#  0 on success
#  1 on failure
#


# Name of the script
SCRIPT=$( basename "$0" )

# Current version
VERSION="1.0.0"



# Message to display for usage and help.
#
function usage
{
    local txt=(
"Utility $SCRIPT $VERSION for doing stuff."
"Usage: $SCRIPT [options] <command> [arguments]"
""
"COMMANDS:"
"  cal                  Render a calendar"
"  greet                Print a greeting"
"  loop [min] [max]     Will print all number betwwen min and max."
"  lower [n n n n ...]  Print all numbers lower than 42"
"  reverse [string]     Print your sentence reversed"
"  all                  Print all commands with default values"

""
"OPTIONS:"
"  --help, -h     Print help."
"  --version, -h  Print version."
""
"EXTRA: "
"  starwars             Watch starwars. press CTRL+] followed by q to quit"

    )

    printf "%s\n" "${txt[@]}"
}

#
# Calendar
#
function app-cal 
{   
    echo "showing 3 months calendar"
    cal -3
}
   

#
# Greet function  - return a greeting
#
function app-greet
{
    echo "Hello! This is a bashscript thing."
}


#
# Loop function  - print a countdown from user input $1 and $2
#
function app-loop
{   
    local min
    min=$( echo "$*" | cut -d ' ' -f 1)
    local max
    max=$( echo "$*" | cut -d ' ' -f 2)

    local msg="Done!"
  

        if [[ $min -gt $max ]]; then
    
        local temp=$min
        local min=$max
        local max=$temp
        msg="Done! (with your numbers reversed)"
        fi

    for (( count="$min"; count<="$max"; count++ ))
    do
        printf "%s" "$count "
    done

    printf "\n%s\n" "$msg"
}

#
# Lower function - print all numbers lower than 42 from user input.
#
function app-lower
{
    read -r -a values <<< "$*"
    echo "The numbers lower than 42: "

    for value in "${values[@]}"
    do
        if [[ $value -le 42 ]]; then
            printf "%s" "$value "
        fi
    done

    printf "\n"

}

#
# Reverse function - print user input reversed
#
function app-reverse
{
    local sentence
    sentence=$(echo "$*" | rev)
    echo "$sentence"

}

#
# All function - print all functions with default values
#
function app-all
{   
    local calx
    calx="$(app-cal "$@")"
    local greetx
    greetx="$(app-greet)"
    local loopx
    loopx="$(app-loop 8 16)"
    local lowerx
    lowerx="$(app-lower 400 25 3 5 25 34 3)"


    local txt=(
        ". . . . . * * * * *  ~ ~ * * * * * . . . . ."
        ". . . . . .  ALL options in ONE . . . . . . "
        ""
        "> > > > CALENDAR > > > >"
        "$calx"
        ""
        "> > > >  GREETING > > > >"
        "$greetx"
        ""
        "> > > >  LOOP 8 - 16 > > > >"
        "$loopx"
        ""
        "> > > >  LOWER 400 25 3 5 25 34 3 > > > >"
        "$lowerx"
        ""
    )

    printf "%s\n" "${txt[@]}"
}

#
# STARWARS
#

function app-starwars
{
    telnet towel.blinkenlights.nl
}


#
# Bad usage
#
function badUsage
{
    local txt=(
        "For usage, execute:"
        "$SCRIPT -h"
    )

    printf "%s\n" "${txt[@]}"
}

#
# Process user input
#

while (( $# ))
do
    case "$1" in 
    --help | -h | help )
            usage
            exit 0
        ;;
        cal         \
        | greet     \
        | loop      \
        | lower     \
        | reverse   \
        | all       \
        | starwars)
            command=$1
            #shift $1 = $2, example greet name 1 name 2
            # echo $* #output: greet name 1 name 2
            shift 
            # echo $* #output:name 1 name 2
            app-"$command" "$*"
            exit 0
        ;;
    *)
        badUsage "Command not known. Try help."
        exit 1
    ;;

    esac
done

badUsage
exit 1