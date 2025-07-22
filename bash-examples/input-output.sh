#!/bin/bash

empty="false"

# Asking for user name

while [ "$empty" == "false" ];
do
  echo -n "What's your name? "
  read name
  if [ -z "${name}" ]; then
    echo -e "Please, write something. \nPress enter to continue..."
    read
    clear
  else
    empty="true"
  fi
done
# Asking for user age
empty="false"
re='^[0-9]+$'

while [ "$empty" == "false" ];
do
  echo -n "How old are you? "
  read age
  if [ -z "${age}" ]; then
    echo -e "Please, write something. \nPress enter to continue..."
    read
    clear
  elif ! [[ $age =~ $re ]]; 
  then
    echo -e "Please, introduce a number. \nPress enter to continue..."
    read
    clear
  else
    empty="true"
  fi
done

# Displaying when user name and when it was displayed
echo "Your name is: $name"
echo "Your age is: $age"
