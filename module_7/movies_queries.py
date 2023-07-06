import mysql.connector
from mysql.connector import errorcode

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

#---------- First Query ----------
print("-- DISPLAYING Studio RECORDS --")
cursor = db.cursor()
cursor.execute("SELECT studio_id, studio_name FROM studio")
studios = cursor.fetchall()
for studio in studios:
    print("Studio ID: {}\nStudio Name: {}\n".format(studio[0], studio[1]))
print("")

#---------- Second Query ----------
print("-- DISPLAYING Genre RECORDS --")
cursor = db.cursor()
cursor.execute("SELECT genre_id, genre_name FROM genre")
genres = cursor.fetchall()
for genre in genres:
    print("Genre ID: {}\nGenre Name: {}\n".format(genre[0], genre[1]))
print("")

#---------- Third Query ----------
print("-- DISPLAYING Short Film RECORDS --")
cursor = db.cursor()
cursor.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 118")
films = cursor.fetchall()
for film in films:
    print("Film Name: {}\nRuntime: {}\n".format(film[0], film[1]))
print("")

#---------- Fourth Query ----------
print("-- DISPLAYING Director RECORDS in Order --")
cursor = db.cursor()
cursor.execute("SELECT film_name, film_director FROM film ORDER BY film_director ASC")
films = cursor.fetchall()
for film in films:
    print("Film Name: {}\nDirector Name: {}\n".format(film[0], film[1]))
print("")

#---------- Exit database ----------fg
db.close()