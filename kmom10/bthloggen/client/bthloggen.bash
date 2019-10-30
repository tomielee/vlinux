#!/usr/bin/env bash
#
# A command line scipts for testing the server
# Kmom10 Vlinux
#
# Exit values:
#  0 on success
#  1 on failure
#


# SERVERNAME
PORT=1337
SERVERNAME=$( head -n1 server.txt)


# Name of the script
SCRIPT=$( basename "$0" )
VERSION="1.0.0"

# Global variables
PRINT=0

# OPTION Message to display for usage and help.
#
function showMenu
{   
    # clear
    local txt=(
        "* * * T E S T bthloggen $VERSION * * *"
        "Enter $SCRIPT [options] <command> [arguments]"
        ""
        "Options available:"
        "   -h, --help      Display the menu"
        "   -v, --version   Display the current version"
        "   -c, --count     Display the number of rows returned"
        ""
        "Commands available:"
        "   url                Get url to view the server in browser."
        "   view               List all entries."
        "   view url <url>     View all entries containing <url>."
        "   view ip <ip>       View all entries containing <ip>."
        "   use <server>       Set the servername (localhost or service name)."
        ""
        "Commands not entirly done, filter function does not work but search function does: "
        "   view day <day>         View all enteries containg <day>."
        "   view month <month>     View all enteries containg <month>."
        "   view time <time>        View all enteries containg <time>."
        ""
        "   Enter quit to exit"
        "- - - - - - - - - - - - - - - - - - - - - -"
        ""
            )

    clear
    printf "%s\n" "${txt[@]}"
}


#
# OPTION Message to display version
#
function showVersion
{
    txt=(
        ""
        "Scriptname: $SCRIPT"
        "Version: $VERSION"
        ""
        "Script to test server functions"
        ""
    );
    clear
    printf "%s\n" "${txt[@]}"
}

#
# App url
# Get url to view the server in browser
function app-url
{

    local text=(
        "* * * U R L * * *"
        "To view content enter the url in the browser"
        "   http://$SERVERNAME:$PORT"
        ""
    ) 

    clear
    printf "%s\n" "${text[@]}"
}


#
# App view 
# App view url or ip
function app-view
{

    local query
    query=$( echo "$*" | cut -d ' ' -f 1)
    local search
    search=$( echo "$*" | cut -d ' ' -f 2)

    if [[ -z $query || -z $search ]]
    then
        echo "Getting all data... It might take a while... Grab a coffe!"

        if [[ $PRINT == 0 ]] 
        then 
            result=$( curl -s "$SERVERNAME":"$PORT"/data | jq -r '.result')
            local headline="Showing all data."
            printResult
        else 
            result=$( curl -s "$SERVERNAME":"$PORT"/data | jq -r '.result' | jq length)
            local headline="Number of entries in log."
            local continue="You want to see result, remove the option -c | --count."
            printResult
        fi

        
    elif [[  $query == "ip" || "$query" == "day" || "$query" == "month" || "$query" == "year" || "$query" == "time" || "$query" == "url" ]]
    then 
        if [[ $PRINT == 0 ]] 
        then 
            echo "Getting data " "$query" " = " "$search" "... It might take a while... Grab a cookie!"
            result=$( curl -s "$SERVERNAME":"$PORT"/data?"$query"="$search" | jq -r '.result')
            local headline="All result of $query: $search. "

            printResult
        else
            echo "Getting data " "$query" " = " "$search" "... It might take a while... Grab a coffe!"

            result=$( curl -s "$SERVERNAME":"$PORT"/data?"$query"="$search" | jq -r '.allresult' | jq length)
            local headline="Number of hits for $query: $search."
            local continue="You want to see result, remove the option -c | --count."

            printResult
        fi

    fi

}

#
# App use
# Set the servername (localhost or service name).
function app-use
{
    echo "$1" > server.txt
    local newserver
    newserver=$( cat server.txt)

    local text=(
        "* * * You changed server * * *"
        "Server is now: $newserver"
        ""
    )

    clear
    printf "%s\n" "${text[@]}"
    
}

#
# OPTION -c
# Show rows files
function showRows
{
    PRINT=1
    app-view "$@"
        
}

#
# Function to print result after fetched.
function printResult
{
    local text=(
        "* * *  R E S U L T  * * *"
        "$headline"
        "   $result"
        ""
        "$continue"
        ""
    )

    clear
    printf "%s\n" "${text[@]}"
}


#
# Setup files
#
function defaultFiles
{
    touch server.txt
    
    chmod -x server.txt
}

#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
        "--------------------------------"
        "Need help? An overview of the command, execute:"
        "$SCRIPT --help"
        ""
    )
    clear
    [[ -n $message ]] && printf "%s\n" "$message"

    printf "%s\n" "${txt[@]}"
}

function menu
{
    defaultFiles

    while (( $# ))
    do
        case "$1" in 
        --help | -h )
            showMenu
            shift
            exit 0
        ;;
        --version | -v )
            showVersion
            shift
            exit 0
        ;;
        --count | -c )
        shift #
        showRows "$*"
        ;;
        url     \
        |view    \
        |use)
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
