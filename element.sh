#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ $1 ]]
then
 if [[ $1 =~ ^[0-9]+$ ]]
 then
  RES=$($PSQL "SELECT elements.atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE elements.atomic_number=$1")
  else
   RES=$($PSQL "SELECT elements.atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$1' OR name='$1'")
 fi

 if [[ -z $RES ]]
 then
  echo "I could not find that element in the database."
 else
 echo $RES | while IFS='|' read NUM SYM NAME TYPE MASS MELT BOIL
 do 
 echo "The element with atomic number $NUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
 done
 fi


else
 echo "Please provide an element as an argument."
fi