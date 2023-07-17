# Module 11, 7/16/2023
# Group Members in Alphabetical Order:
# Chris Kaiser, Estiven Hernandez, Juan Taylor, Julia Gonzalez, Michelle Choe

# This Module is to conduct three queries for information relative to our case file

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "outland_adventures_user",
    "password": "cheese1",
    "host": "localhost",
    "database": "outland_adventures",
    "raise_on_warning": True
}

try:
    mydb = mysql.connector.connect(
        host="localhost",
        database="outland_adventures",
        user="outland_adventures_user",
        password="cheese1"
    )

    print(
        f"Database user {config['user']} connected to MySQL on host {config['host']} with database {config['database']}")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The username or password is invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The database does not exist")

    else:
        print(err)

# enough customers buy equipment to keep equipment sales?
# SELECT (SUM(amex.Qty) + SUM(mc.Qty)) as total_qty from amex, mc
print("")
print("-- DISPLAYING Equipment Sales RECORDS --")
cursorP = mydb.cursor()
# ANY_VALUE(clients.first_name), ANY_VALUE(clients.last_name), ANY_VALUE(inventory.product_name)
cursorP.execute(
    "SELECT ROUND(SUM(inventory.purchase_cost), 2) FROM equipment JOIN clients ON clients.client_id = equipment.client_id JOIN inventory ON inventory.inventory_id = equipment.inventory_id WHERE equip_status = 'Purchased'")

resultP = cursorP.fetchall()

for purchase_cost in resultP:
    print(f"Total Purchase Sales: {purchase_cost}\n")

cursorR = mydb.cursor()
cursorR.execute(
    "SELECT ROUND(SUM(inventory.rental_cost), 2) FROM equipment JOIN clients ON clients.client_id = equipment.client_id JOIN inventory ON inventory.inventory_id = equipment.inventory_id WHERE equip_status = 'Rented'")

resultR = cursorR.fetchall()

for rental_cost in resultR:
    print(f"Total Rental Sales: {rental_cost}\n")

# they have conducted treks in Africa, Asia, and Southern Europe. Is there anyone of those locations that has a downward trend in bookings?
cursor2 = mydb.cursor()
cursor2.execute(
    "SELECT ANY_VALUE(trips.trip_name), trips.trip_date, ANY_VALUE(country.continent), COUNT(clients.client_id) FROM clients JOIN clients_attending_trip ON clients.client_id = clients_attending_trip.client_id JOIN trips ON clients_attending_trip.trip_id = trips.trip_id JOIN country ON trips.country_id = country.country_id GROUP BY trips.trip_date")

print("-- DISPLAYING TREKS RECORDS --")
result2 = cursor2.fetchall()
for trip_name, trip_date, continent, X in result2:
    print(
        f"Trip Name: {trip_name}\nTrip Date: {trip_date}\nContinent: {continent}\nClients attending trip: {X}\n".format(
            result2))
# for x in result2:
#    print(x)


# Are there inventory items that are over five years old?
cursor3 = mydb.cursor()
cursor3.execute(
    "SELECT inventory.product_name, equipment.restock_date, equipment.equip_expired from inventory JOIN equipment ON inventory.inventory_id = equipment.inventory_id WHERE equipment.restock_date < DATE_SUB('2023-07-15', INTERVAL 5 YEAR)")

print("-- DISPLAYING Expired Equip RECORDS --")
result3 = cursor3.fetchall()

for product_name, restock_date, equip_expired in result3:
    print(f"Product Name: {product_name}\nRestock Date: {restock_date}\nExpired: {equip_expired}\n".format(result2))

