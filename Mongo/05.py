import pymongo
import random
from tools import randelem
from tools import randYear
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")

MBookStore = myclient["MBookStore"]
books = MBookStore["books"]

title1 = ["Kapitan", "Władca", "Turysta", "Kapłan", "Andrzej",
  "Mordziu", "Książe", "Mistrz"]
title2 = ["Sztorm", "Pierścieni", "Nocy", "Bezimienny",
  "2000", "Wenecji", "Kutarate"]

names = ["Hugh", "Al", "Jan", "Paweł", "Szymon", "Karol", "Michał", "Łukasz",
  "Dawid", "Mateusz"]
surnames = ["Wojtyła", "Rubin", "Głąb", "Kobiałka", "Podgórny", "Bratos",
  "Dworzański", "Iwańczak"]

characters = ["Shrek", "Gandalf", "Buka", "Filifionka",
  "Mamusia Muminka", "Migotka", "Muminek", "Włóczykij"]

def generate_characters():
  result = []
  for i in range(0, random.randint(2, len(characters)-1)):
    if (random.randint(0,1)):
      result.append(randelem(characters))
      
  return result

books.delete_many({})

for i in range(0, 20):
  main_characters = generate_characters()
  record = {
    "title": randelem(title1) + " " + randelem(title2),
    "author": randelem(names) + " " + randelem(surnames),
    "publish_year": randYear(),
    "main_characters": main_characters
  }
  books.insert_one(record)

for i in books.find({}, {"_id": 0, 'title': 1}):
  pprint(i)
