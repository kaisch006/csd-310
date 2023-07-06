# Christopher Kaiser, Assignment 8.2, 7/6/2023
#---------- Imports ----------
import mysql.connector
from mysql.connector import errorcode

#---------- Method for Query ----------
def film_query():
    cursor.execute("SELECT film.film_name, film.film_director, genre.genre_name, studio.studio_name \
               FROM film JOIN genre ON film.genre_id = genre.genre_id \
               JOIN studio ON film.studio_id = studio.studio_id")
    films = cursor.fetchall()
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name: {}\nStudio Name: {}\n"\
            .format(film[0], film[1], film[2], film[3]))
    print("")

#---------- Connect to Database ----------
config = {"user": "root",
         "password": "KIllers88!!",
          "host": "127.0.0.1",
          "database": "movies",
          "raise_on_warnings": True
          }
try:
    db = mysql.connector.connect(**config)
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")
    else:
        print(err)

#---------- Initialize Cursor ----------
cursor = db.cursor()

#---------- Initial Query ----------
print("-- DISPLAYING FILMS --")
film_query()

#---------- Modify Table ----------
# Insert Action genre
cursor.execute("INSERT INTO genre(genre_name) VALUES ('Action')")
# Insert Aliens movie
cursor.execute("INSERT INTO film (film_name, film_releaseDate, film_runtime, film_director,\
              studio_id, genre_id) VALUES ('Aliens', 1986, 137, 'James Cameron', 1, 9)")
# Perform Query
print("-- DISPLAYING FILMS AFTER INSERT --")
film_query()

#---------- Modify Alien Genre ----------
# Change Alien genre
cursor.execute("UPDATE film SET film_id = 2, genre_id = 1 WHERE genre_id = 2")
# Perform Query
print("-- DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror --")
film_query()

#---------- Delete Gladiator ----------
cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator'")
# Perform Query
print("-- DISPLAYING FILMS AFTER DELETE --")
film_query()