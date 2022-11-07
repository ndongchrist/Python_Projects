#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
if [[ $# -ge 1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENTQUERY=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE atomic_number=$1")
    IFS="|" read ATOMIC_NUMBER SYMBOL NAME <<< $ELEMENTQUERY
  elif [[ ${#1} -le 2 ]]
  then
    ELEMENTQUERY=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE symbol='$1'")
    IFS="|" read ATOMIC_NUMBER SYMBOL NAME <<< $ELEMENTQUERY
  else
    ELEMENTQUERY=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE name='$1'")
    IFS="|" read ATOMIC_NUMBER SYMBOL NAME <<< $ELEMENTQUERY
  fi
  if [[ ${#ELEMENTQUERY} -le 0 ]]
  then
    echo -e  "I could not find that element in the database."
  else
    PROPERTIESQUERY=$($PSQL "SELECT atomic_mass::REAL, melting_point_celsius, boiling_point_celsius, type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    IFS="|" read ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID <<< $PROPERTIESQUERY
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
else
  echo "Please provide an element as an argument."
fi
