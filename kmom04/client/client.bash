#!/usr/bin/env bash
#
# A command line scipts
# Kmom04 Vlinux
#
# Exit values:
#  0 on success
#  1 on failure
#


# Name of the script
SCRIPT=$( basename "$0" )

# Current version
VERSION="1.0.0"

# Variable to store returned data
RESULT="";

# Variable to save data or not
SAVE="";




# OPTION Message to display for usage and help.
#
function showMenu
{   
    local txt=(
        "------------------- MENU ----------------------------"
        "Usage: $SCRIPT [options] <command> [arguments]"
        ""
        "COMMANDS:"
        "  1) all                     Return all data from item.script, route /all  "
        "  2) names                     Call route /names                           "
        "  3) color <color>             Call route /color/:color                    "
        "  3) test <url>                Return server info                          "


        ""
        "OPTIONS:"
        "  --help, -h     Print help."
        "  --version, -v  Print version."
        "  --save, -s     Save the returned data"
        "------------------- END ------------------------------"

            )

    printf "%s\n" "${txt[@]}"
}



#
# OPTION Message to display version
#
function showVersion
{
    echo "$SCRIPT $VERSION - script to fetch data from server."
}

#
# OPTION TO save
# Spara den returnerade datan till client/saved.data. Det ska fungera för alla argument.
#
function saveData
{
    SAVE=" -o client/saved.data"
    echo "saved in client/saved.data."
}


#
# ALL 
# all for route all
function app-all
{
    cmd="curl -s localhost:1337/all"$SAVE
    RESULT=$( $cmd )
    
    echo result from app-all /all "$RESULT"
}

#
# NAMES 
# return names from item.script
function app-names
{
    cmd="curl -s localhost:1337/names"$SAVE
    RESULT=$( $cmd )

    echo result from app-names /names "$RESULT"
}

#
# COLOR 
# return names from item.script
function app-color
{
    local color=$1
    cmd="curl -s localhost:1337/color/"$color$SAVE
    RESULT=$( $cmd )

    echo plants with the color "$color" : "$RESULT"
}

#
# TRY
#	Använd curl för att skriva ut ett meddelande om servern är igång eller ej. 
# Om <url> är satt ska den anropas, annars localhost:port.
function app-try
{
    local url=$1
    
    curl -i "$url""$SAVE"
    res=$?
    echo $res
    if [[ $res != 0 ]] || [[ $res -ne 0 ]] 
    then
        local msg="Server on [$url] is NOT running. Exit code: $res."
        echo "$msg"

        if [[ -n $SAVE ]]
        then
            echo "$msg" > client/saved.data
        fi
    else 
        echo server on "$url" is running
    fi

}

#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
        "For an overview of the command, execute:"
        "$SCRIPT --help"
    )

    [[ -n $message ]] && printf "%s\n" "$message"

    printf "%s\n" "${txt[@]}"
}

function menu
{
    while (( $# ))
    do
        case "$1" in 
        --help | -h )
            showMenu
            shift
            exit 0
        ;;
        --version | -v)
            showVersion
            shift
            exit 0
        ;;
        --save | -s)
            shift #
            saveData
        ;;
        all         \
        | names     \
        | color     \
        | try)
            command=$1
            shift 
            app-"$command" "$*"
            exit 1
        ;;
        q | quit)
            echo "Exit"
            exit 1
        ;;
        *) #invalid
            badUsage "Command not known. Try help."
            exit 1
        ;;

        esac
    done
}
menu "$@"

badUsage
exit 1


