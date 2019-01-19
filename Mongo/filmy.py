import pymongo
import random
import time

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]
aktorzy = MFilmoteka["aktorzy"]
filmy.delete_many({})
tytuly1 = ["Kapitan", "Władca", "Turysta", "Kapłan", "Andrzej",
  "Mordziu", "Książe", "Mistrz"]
tytuly2 = ["Sztorm", "Pierścieni", "Nocy", "Bezimienny",
  "2000", "Wenecji", "Kutarate"]
rezyserzy = ["Quentin Tarantino", "Roman Polański"]

postaci = ["Miś", "Frodo", "John Wick", "Prezydent", "Glass",
  "Jacek", "John", "Gandalf", "Ariadna", "Eames", "Cobb",
  "Robert Fischer", "Saito", "Yusuf", "Profesor", "Arthur",
  "Andrew", "Fletcher", "Nicole", "Carl", "Jim"
  ]

for i in range(0, 200):
  licznosc =  random.randint(2, 20)
  obsada_aktorzy = aktorzy.find().limit(licznosc).distinct("_id")
  obsada_postaci = postaci[0:licznosc]
  obsada = []
  for i in range(0, licznosc):
    obsada.append({"actor_id": obsada_aktorzy[i], "role": obsada_postaci[i]})

  record = {
    "Tytuł": tytuly1[random.randint(0, len(tytuly1)-1)] + " " +
      tytuly2[random.randint(0, len(tytuly2)-1)],
    "Reżyser": rezyserzy[random.randint(0, len(rezyserzy)-1)],
    "Obsada": obsada
  }
  filmy.insert_one(record)

print(filmy.find_one({}, {"Obsada": 1}))