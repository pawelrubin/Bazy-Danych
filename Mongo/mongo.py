import pymongo
import random

myclient = pymongo.MongoClient("mongodb://localhost:27017/")

MFilmoteka = myclient["MFilmoteka"]
aktorzy = MFilmoteka["aktorzy"]
agenci = MFilmoteka["agenci"]
filmy = MFilmoteka["filmy"]

aktorzy.remove()

names = ["Jan", "Paweł", "Szymon", "Karol", "Michał", "Łukasz",
  "Dawid", "Mateusz"]
surnames = ["Wojtyła", "Rubin", "Głąb", "Kobiałka", "Podgórny", "Bratos",
  "Dworzański", "Iwańczak"]
genres = ["komedia", "filmy fantasy", "filmy kryminalne"]
countries = ["Polska", "Niemcy"]

for i in range(0, 200):

  genres_record = []
  for i in range(0, len(genres)):
    if (random.randint(0, 1)):
      genres_record.append(genres[i])

  record = {
    "Name": names[random.randint(0, len(names)-1)],
    "Surname": surnames[random.randint(0, len(surnames)-1)],
    "Age": random.randint(18, 65),
    "Height": random.randint(160, 210),
    "Genres": genres_record
  }
  aktorzy.insert_one(record)

for i in MFilmoteka.aktorzy.find({}):
  print(i)