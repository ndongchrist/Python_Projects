#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"
RANDOM_NUMBER=$(($RANDOM % 1000 + 1))
echo "Enter your username:"
read USERNAME

USER_QUERY=$($PSQL "SELECT username, total_games_played, best_score FROM users WHERE username='$USERNAME'")

if [[ -z $USER_QUERY ]]
then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  TOTAL=0
  BEST=9999999
  ADD_USER=$($PSQL "INSERT INTO users(username, total_games_played) VALUES('$USERNAME', $TOTAL)")
else
  IFS="|" read USERNAME TOTAL BEST <<< $USER_QUERY
  echo -e "Welcome back, $USERNAME! You have played $TOTAL games, and your best game took $BEST guesses."
fi

echo "Guess the secret number between 1 and 1000:"
NO_OF_GUESSES=0
while [[ true ]]
do
  read GUESS
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    if [[ $GUESS > $RANDOM_NUMBER ]]
    then
      ((NO_OF_GUESSES++))
      echo -e "It's lower than that, guess again:"
    elif [[ $GUESS < $RANDOM_NUMBER ]]
    then
      ((NO_OF_GUESSES++))
      echo -e "It's higher than that, guess again:"
    else
      ((NO_OF_GUESSES++))
      echo -e "You guessed it in $NO_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
      break
    fi
  else
    echo -e "That is not an integer, guess again:"
  fi
done

UPDATE_USER_STATS=$($PSQL "UPDATE users SET total_games_played=$(($TOTAL + 1)), best_score=$(($BEST < $NO_OF_GUESSES ? $BEST: $NO_OF_GUESSES)) WHERE username='$USERNAME'")
