# Module 10, 7/16/2023
# Group Members in Alphabetical Order:
# Chris Kaiser, Estiven Hernandez, Juan Taylor, Julia Gonzalez, Michelle Choe

# This Module is to display the information contained in the tables of our database outland_adventures.

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

# Query 1: select all the fields for the client
cursor = mydb.cursor()
cursor.execute("SELECT * from clients")

print("-- DISPLAYING clients RECORDS --")
clients = cursor.fetchall()

for client_id, first_name, last_name, past_trips in clients:
    print(
        f"Client ID: {client_id}\nFirst Name: {first_name}\nLast Name: {last_name}\nPast Trips: {past_trips}\n".format(
            clients))

# Query 2: select all the fields for the clients_attending_trip
cursor2 = mydb.cursor()
cursor2.execute("SELECT * from clients_attending_trip")

print("-- DISPLAYING clients_attending_trip RECORDS --")
clients_attending_trip = cursor2.fetchall()

for client_id, trip_id in clients_attending_trip:
    print(f"Client ID: {client_id}\nTrip ID: {trip_id}\n".format(clients_attending_trip))

# Query 3: select all the fields for the country
cursor3 = mydb.cursor()
cursor3.execute("SELECT * from country")

print("-- DISPLAYING country RECORDS --")
country = cursor3.fetchall()

for country_id, country_name, continent in country:
    print(f"Country ID: {country_id}\nCountry Name: {country_name}\nContinent: {continent}\n".format(country))

# Query 4: select all the fields for the equipment
cursor4 = mydb.cursor()
cursor4.execute("SELECT * from equipment")

print("-- DISPLAYING equipment RECORDS --")
equipment = cursor4.fetchall()

for equipment_id, client_id, inventory_id, restock_date, equip_expired, equip_status in equipment:
    print(
        f"Equipment ID: {equipment_id}\nClient ID:  {client_id}\nInventory ID: {inventory_id}\nRestock Date: {restock_date}\nExpired: {equip_expired}\nEquipment Status: {equip_status}\n".format(
            equipment))

# Query 5: select all the fields for the guides
cursor5 = mydb.cursor()
cursor5.execute("SELECT * from guides")

print("-- DISPLAYING guides RECORDS --")
guides = cursor5.fetchall()

for guide_id, first_name, last_name in guides:
    print(f"Guide ID: {guide_id}\nFirst Name: {first_name}\nLast Name: {last_name}\n".format(guides))

# Query 6: select all the fields for the inventory
cursor6 = mydb.cursor()
cursor6.execute("SELECT * from inventory")

print("-- DISPLAYING inventory RECORDS --")
inventory = cursor6.fetchall()

for inventory_id, product_name, purchase_cost, rental_cost, equip_type in inventory:
    print(
        f"Inventory ID: {inventory_id}\nProduct Name: {product_name}\nPurchase Cost: {purchase_cost}\nRental Cost: {rental_cost}\nEquipment Type: {equip_type}\n".format(
            inventory))

# Query 7: select all the fields for the trips
cursor7 = mydb.cursor()
cursor7.execute("SELECT * from trips")

print("-- DISPLAYING trips RECORDS --")
trips = cursor7.fetchall()

for trip_id, guide_id, country_id, trip_name, trip_date in trips:
    print(
        f"Trip ID: {trip_id}\nGuide ID: {guide_id}\nCountry ID: {country_id}\nTrip Name: {trip_name}\nTrip Date: {trip_date}\n".format(
            trips))