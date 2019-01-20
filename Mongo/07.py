import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]

for i in filmy.find( {}, { "_id": 0, "Tytuł": 1, "Reżyser": 1} ):
  print(i)