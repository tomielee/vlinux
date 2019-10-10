#!/usr/bin/env bash
#
# A command line scipts for playing the game maze
# Kmom05 Vlinux
#
# Exit values:
#  0 on success
#  1 on failure
#

# SERVERNAME
PORT=1337
SERVERNAME="localhost:$PORT"

# Name of the script
SCRIPT=$( basename "$0" )

# Variable to store game data
GAMEFILE="data/game.txt"

GAME_ID=""
IDFILE="data/id.txt"

CURRMAP=""
MAPSFILE="data/maps.txt"         #available maps

CURR_ROOM=""
ROOMFILE="data/room.txt"


# Variables to input
re='^[0-9]+$' #not number

IFS_BACKUP=$IFS


# OPTION Message to display for usage and help.
#
function showMenu
{   
    clear
    local txt=(
        "------------------- MENU ----------------------------"
        "Maze commands: $SCRIPT [options] <command> [arguments]"
        ""
        "COMMANDS:"
        " * init	        Init a game. "
        " * maps	        Show available maps."
        " * select <#map>	Select a map for."
        " * enter	        Enter the maze"
        " * info <#roomid>	Show info of room, if empty current room"
        " * go north	    Go direction if supported."
        " * go south	    Go direction if supported."
        " * go east	        Go direction if supported."
        " * go west	        Go direction if supported."
        ""
        "OPTIONS:"
        "  --help, -h     Print help."
        ""
        "Enter exit to exit the game."
        "------------------- END ------------------------------"
        ""

            )

    printf "%s\n" "${txt[@]}"
}


#
# READ ROOM INFO
#
function get-room-info 
{

    # # # get room data.

    room_str=""
    room_str=$( sed -n '2 p' $ROOMFILE )

    room_arr=()
    IFS=',' read -r -a room_arr <<< "$room_str"   

    # # # get direction data.
    dir_str=""
    dir_str=$( sed -n '1 p' $ROOMFILE )

    dir_arr=()
    IFS=',' read -r -a dir_arr <<< "$dir_str" 
}

#
# INIT - init a new game
function app-init
{
    curl -s -o $GAMEFILE $SERVERNAME?type=csv

    sed -n '2 p' $GAMEFILE | cut -d "," -f 2 > $IDFILE
    local id=""
    id=$( cat $IDFILE)

    MSG=$( sed -n '2 p' $GAMEFILE | cut -d "," -f 1)

    local txt=(
    "----------- S T A R T ------------"
    "$MSG"
    "Your gameID:  $id"
    ""
    "Next step, available maps: $SCRIPT maps"
    ""
    )

    clear
    printf "%s\n" "${txt[@]}"

}

#
# SHOW MAPS TO CHOOSE FROM
######## NOT DONE - make a nice way to print out menu...
function app-maps
{
    curl -s -o $MAPSFILE $SERVERNAME/map?type=csv

    local mps_string=""
    mps_string=$( sed -n '2 p' $MAPSFILE )
    IFS=',' read -r -a maps_arr <<< "$mps_string"

    local txt=(
    "----------- M A P S ------------"
    ""
    )

    for index in "${!maps_arr[@]}"
    do
        txt+=("$index ) ${maps_arr[index]}")
    done

    txt+=(
        "Use: $SCRIPT select  # and the number of the map"
        ""
    )

    clear
    printf "%s\n" "${txt[@]}"
}

#
# SELECT - select a map
#
function app-select
{
    app-maps

    local map_id=$1
    local mps_string=""
    mps_string=$( sed -n '2 p' $MAPSFILE )
    IFS=',' read -r -a maps_arr <<< "$mps_string"

    # Catch some errors. Not complete
    if ! [[ $map_id =~ $re ]]
    then
        echo "Error. Enter a number." >&2; exit 1
    fi


    # Get data from file
    GAME_ID=$( cat $IDFILE)
    CURRMAP=${maps_arr[$map_id]}

    cmd="curl -s $SERVERNAME/$GAME_ID/map/$CURRMAP?type=csv"
    MSG=$( $cmd | cut -d "," -f1-2 | tail -n 1)

    local txt=(
        " ----------- YOUR CHOICE ------------ "
        "$MSG: $CURRMAP"
        ""
        ".. to enter $SCRIPT enter"
        ""
    )


    # cmd="curl -s $SERVERNAME/$GAME_ID/map/$CURRMAP?type=csv"
    # RES=$( $cmd | cut -d "," -f1-2)

    # txt+=("$RES")

    clear
    printf "%s\n" "${txt[@]}"

}


#
# ENTER 
# enter the maze https://github.com/dbwebb-se/vlinux/blob/master/example/maze/api.md#get-gameidmaze
function app-enter
{
    # Get data from file
    GAME_ID=$( cat $IDFILE)

    curl -s -o $ROOMFILE $SERVERNAME/"$GAME_ID"/maze?type=csv

    local room_str=""
    room_str=$( sed -n '2 p' $ROOMFILE )

    local room_arr=()
    IFS=',' 
    read -r -a room_arr <<< "$room_str"

    local txt=(
    ""
    "----------- YOU HAVE ENTERED THE MAZE ------------"
        "Room id: ${room_arr[0]}"
        "Description: ${room_arr[1]}"
        ""
        ".. more info $SCRIPT info #room-id"
    ""
    )
    clear
    printf "%s\n" "${txt[@]}"

}


#
# PRINT ROOM INFO
function printRoomInfo
{
    # local room_str=""
    # room_str=$( sed -n '2 p' $ROOMFILE )

    # local room_arr=()
    # IFS=',' read -r -a room_arr <<< "$room_str"    

    get-room-info

    local txt=(
        "----------- ROOM INFO ------------"
        "Room id: ${room_arr[0]}"
        "Description: ${room_arr[1]}"
        "You can go: "
    )

    # local dir_str=""
    # dir_str=$( sed -n '1 p' $ROOMFILE )

    # local dir_arr=()
    # IFS=',' read -r -a dir_arr <<< "$dir_str"

    for (( i=3; i<=5; i++ ))
    do 
        if [[ ${room_arr[i]} != "-" ]]
        then
            txt+=("   ${dir_arr[i]}")
        fi
    done

    txt+=(""
    ".. to go $SCRIPT go #direction"
    )
    clear
    printf "%s\n" "${txt[@]}"
}

#
# PRINT ROOM ERROR INFO
function printRoomErrorInfo
{

    get-room-info

    local txt=(
        "----------- ROOM DIRECTIONS ------------"
        "You entered wrong direction."
        "Available directions are: "
    )

    for (( i=3; i<=5; i++ ))
    do 
        if [[ ${room_arr[i]} != "-" ]]
        then
            txt+=("   ${dir_arr[i]}")
        fi
    done

    txt+=(""
    ".. to go $SCRIPT go #direction"
    )
    clear
    printf "%s\n" "${txt[@]}"
    
    # Reset the value
    IFS=$IFS_BACKUP
}

#
# INFO 
# print room info
function app-info
{
    local room_id=$1
    
    # Get data from file
    GAME_ID=$( cat $IDFILE)

    # Catch some errors. Not complete
    if [[ -z $room_id ]]
    then
        CURR_ROOM=$( sed -n '2 p' $ROOMFILE | cut  -d ',' -f 1)
    elif ! [[ $room_id =~ $re ]]
    then
        echo "Error. Enter a number." >&2; exit 1
    fi

    curl -s -o $ROOMFILE $SERVERNAME/"$GAME_ID"/maze/"$room_id"?type=csv
    # RES=$( $cmd > $ROOMFILE)

    get-room-info
    
    printRoomInfo
       
}


#
# GO
# walk through the maze
# https://github.com/dbwebb-se/vlinux/blob/master/example/maze/api.md#get-gameidmazeroomiddirection
function app-go
{
    local direction=$1

    # Get data from file
    GAME_ID=$( cat $IDFILE)
    CURR_ROOM=$( sed -n '2 p' $ROOMFILE | cut  -d ',' -f 1)
    echo currrom: "$CURR_ROOM"

    get-room-info
                
    #COMMAND TO RUN IF OK
    cmd="curl -s $SERVERNAME/$GAME_ID/maze/$CURR_ROOM/$direction?type=csv"

    if [[ ${room_arr[2]} == "-" ]] && [[ ${room_arr[3]} == "-" ]] && [[ ${room_arr[4]} == "-" ]] && [[ ${room_arr[5]} == "-" ]]
    then
        txt=(
            "----------- YOU'RE OUT ------------"
            ""
            ""
            ""
            ".. to go $SCRIPT --help "

        )
        printf "%s\n" "${txt[@]}"
        exit 1
    fi

    if [[ $direction == "west" ]]
    then 
        if [[ ${room_arr[2]} != "-" ]]
        then
            $cmd > $ROOMFILE
            printRoomInfo        
        else
            printRoomErrorInfo        
        fi
    fi

    if [[ $direction == "east" ]]
    then 
        if [[ ${room_arr[3]} != "-" ]]
        then
            $cmd > $ROOMFILE
            printRoomInfo        
        else
            printRoomErrorInfo        
        fi
    fi
    if [[ $direction == "south" ]]
    then 
        if [[ ${room_arr[4]} != "-" ]]
        then
            $cmd > $ROOMFILE
            printRoomInfo
        else
            printRoomErrorInfo        
        fi
    fi

    if [[ $direction == "north" ]]
    then 
        if [[ ${room_arr[5]} != "-" ]]
        then
            $cmd > $ROOMFILE
            printRoomInfo
        else
            printRoomErrorInfo        
        fi
        
    fi

}

#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
        "--------------------------------"
        "Do you want to enter the maze?"
        "Use:"
        "   $SCRIPT init "
        ""
        "..."
        "Need help? An overview of the command, execute:"
        "$SCRIPT --help"
        ""
    )
    clear
    [[ -n $message ]] && printf "%s\n" "$message"

    printf "%s\n" "${txt[@]}"
}

#
# Create init values
#
function start-game
{
    touch $GAMEFILE
    touch $IDFILE
    touch $MAPSFILE
    touch $ROOMFILE

    chmod +x data/*.txt
}

function menu
{
    start-game

    while (( $# ))
    do
        case "$1" in 
        --help | -h )
            showMenu
            shift
            exit 0
        ;;
        init        \
        | maps      \
        | select    \
        | enter     \
        | info      \
        | go)
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

