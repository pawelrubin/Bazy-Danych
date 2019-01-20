import pymongo
import random
from tools import randelem

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
aktorzy = MFilmoteka["aktorzy"]
aktorzy.delete_many({})
names = ["Hugh", "Al", "Jan", "Paweł", "Szymon", "Karol", "Michał", "Łukasz",
  "Dawid", "Mateusz"]
surnames = ["Wojtyła", "Rubin", "Głąb", "Kobiałka", "Podgórny", "Bratos",
  "Dworzański", "Iwańczak", "Harris"]
genres = ["komedia", "fantasy", "kryminał"]
countries = ["Polska", { "country": "Niemcy", "state": "Bawaria"}, "Australia", { "country": "USA", "state": "Kalifornia" }, 
  { "country": "Rosja", "state": "Moskwa" }]

for i in range(0, 200):

  genres_record = []
  for i in range(0, len(genres)):
    if ( random.randint(0, 1)):
      genres_record.append(genres[i])

  record = {
    "name": randelem(names),
    "surname": randelem(surnames),
    "age": random.randint(18, 65),
    "height": random.randint(160, 210),
    "genres": genres_record,
    "country": randelem(countries)
  }

  aktorzy.insert_one(record)