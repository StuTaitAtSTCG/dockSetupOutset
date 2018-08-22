#!/bin/bash

if id -Gn | grep -q -w "UP Student All";
then
    echo "-- $USER is a student --";
    /usr/local/bin/dockutil --remove all -v
    sleep 1
    while sD='' read -r line || [[ -n "$line" ]]
    do
        echo "-- Adding" "$line" "--"
        /usr/local/bin/dockutil --add "$line" --no-restart -v
        sleep 1
    done < /Library/STCG/Dock/studentDock.txt

    /usr/local/bin/dockutil --add '/Applications/Network Files' --view list --display folder -v
    /usr/local/bin/dockutil --add "$HOME/Downloads" --view list --display folder --sort dateadded -v
elif id -Gn | grep -q -w "UP Staff All";
then
    echo "-- $USER is a member of staff --"
    /usr/local/bin/dockutil --remove all
    sleep 1
    while sD='' read -r line || [[ -n "$line" ]]
    do
        echo "-- Adding" "$line" "--"
        /usr/local/bin/dockutil --add "$line" --no-restart -v
        sleep 1
    done < /Library/STCG/Dock/staffDock.txt

    /usr/local/bin/dockutil --add '/Applications/Network Files' --view list --display folder -v
    /usr/local/bin/dockutil --add "$HOME/Downloads" --view list --display folder --sort dateadded -v
else
    echo "-- Not a student or staff memeber --";
fi

exit 0
