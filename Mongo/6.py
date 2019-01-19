import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]

for i in MFilmoteka.list_collection_names():
  print(i)