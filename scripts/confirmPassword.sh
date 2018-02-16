#!/bin/sh


stty -echo
printf "Username: "
read USERNAME
stty echo
printf "\n"
echo $USERNAME

while true; do

    stty -echo
    printf "Password: "
    read PASSWORD
    stty echo
    printf "\n"

    stty -echo
    printf "Confirm password: "
    read PASSWORD2
    stty echo
    printf "\n"

    echo $PASSWORD
    echo $PASSWORD2

    if [ "$PASSWORD" = "$PASSWORD2" ]
    then
        break
    else
        echo "Passwords do not match. Please try again."
    fi

done

exit 0
