import pymongo
import random
import time
import datetime
from pprint import pprint
from tools import randelem

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]
aktorzy = MFilmoteka["aktorzy"]
filmy.delete_many({})
tytuly1 = ["Kapitan", "Władca", "Turysta", "Kapłan", "Andrzej",
  "Mordziu", "Książe", "Mistrz"]
tytuly2 = ["Sztorm", "Pierścieni", "Nocy", "Bezimienny",
  "2000", "Wenecji", "Kutarate"]
directors = ["Quentin Tarantino", "Roman Polański", "Wojciech Macyna"]

characters = [
  "Miś", "Frodo", "John Wick", "Prezydent", "Glass",
  "Jacek", "John", "Gandalf", "Ariadna", "Eames", "Cobb",
  "Robert Fischer", "Saito", "Yusuf", "Profesor", "Arthur",
  "Andrew", "Fletcher", "Nicole", "Carl", "Jim", "Shrek", "Gandalf", "Buka", "Filifionka",
  "Mamusia Muminka", "Migotka", "Muminek", "Włóczykij"
]

aktorzy_ids = aktorzy.find().distinct("_id")

for i in range(0, 200):
  licznosc =  random.randint(2, 20)
  obsada_aktorzy = random.sample(aktorzy_ids, licznosc)
  obsada_postaci = random.sample(characters, licznosc)
  obsada = []
  for i in range(0, licznosc):
    obsada.append({"actor_id": obsada_aktorzy[i], "role": obsada_postaci[i]})

  date = [
    random.randint(1900, 2018), 
    datetime.datetime(
      random.randint(1900, 2018), 
      random.randint(1, 12), 
      random.randint(1, 28)
    ).strftime("%Y-%m-%d")
  ]

  record = {
    "title": randelem(tytuly1) + " " + randelem(tytuly2),
    "director": randelem(directors),
    "publish_date": randelem(date),
    "cast": obsada
  }
  filmy.insert_one(record)

for i in filmy.find({}, { "_id": 0, "publish_date": 1 }):
  pprint(i)