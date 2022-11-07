#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "$1"
  fi
  SERVICES="$($PSQL "SELECT service_id, name FROM services")"
  echo "$SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  read SERVICE_ID_SELECTED
  if [[ $SERVICE_ID_SELECTED =~ [0-9]+ ]]
  then
    SERVICE_ID_CHECK=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    if [[ -z $SERVICE_ID_CHECK ]]
    then
      MAIN_MENU "\nI could not find that service. What would you like today?"
    else
      BOOK_SERVICE $SERVICE_ID_SELECTED;
    fi
  else
  MAIN_MENU "\nI could not find that service. What would you like today?"
  fi
}

BOOK_SERVICE() {
  if [[ $1 ]]
  then
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$1")
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    if [[ $CUSTOMER_PHONE =~ ^[0-9]+(-[0-9]+)+$ ]]
    then
      # check number in db
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

      # if not found than ask for name
      if [[ -z $CUSTOMER_ID ]]
      then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        IFS=$'\n\t\r' read CUSTOMER_NAME
        ADD_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      else
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      fi

      # ask for time
      echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
      read SERVICE_TIME

      # book appointment
      BOOKING_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $1, '$SERVICE_TIME')")

      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    else
      echo -e "That is not a valid number.\n"
      BOOK_SERVICE $1
    fi
  fi
}

MAIN_MENU
