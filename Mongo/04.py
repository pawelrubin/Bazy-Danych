import pymongo
import random
from random import randint
from tools import randelem
import time
import datetime
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
agenci = MFilmoteka["agenci"]
aktorzy = MFilmoteka["aktorzy"]

agenci.delete_many({})

names = ["Hugh", "Al", "Jan", "Paweł", "Szymon", "Karol", "Michał", "Łukasz",
  "Dawid", "Mateusz", "Kevin", "Xawery", "Qurczak", "Vampir", "Ovbcq", "ER3vqxX"]

surnames = ["Tarantino", "Bratos", "Cichoń", "Krupski", "Zawada", "Syga", "Żeberski",
  "Sulkowski", "Macyna", "Kapelko", "Xanax", "Vąż", "Qrde"]

countries = ["Polska", { "country": "Niemcy", "state": "Bawaria"}, "Australia", { "country": "USA", "state": "Kalifornia" }, 
  { "country": "Rosja", "state": "Moskwa" }]

corpo = ["Avengers", "Hajsownicy", "W4", "Wixapol"]

aktorzy_ids = aktorzy.find().distinct("_id")

def addClients():
  result = []
  ids = random.sample(aktorzy_ids, randint(1, 5))
  for i in ids:
    result.append(
      {
        "actor_id": i,
        "status": randint(0, 1)
      }
    )
  return result

for i in range(0, 15):
  record = { 
    "name": randelem(names), 
    "surname": randelem(surnames),
    "country": randelem(countries),
    "corpo": randelem(corpo) if randint(0, 1) else None,
    "clients": addClients()
  }
  agenci.insert_one(record)
  
for i in agenci.find({}, {'_id': 0}):
  pprint(i)