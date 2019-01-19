import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
aktorzy = MFilmoteka["aktorzy"]

for i in aktorzy.find({ "$or": [
    { "Name": "Hugh", "Country": "Australia"},
    { "Name": "Al" }]},{ "_id": 0 }):
  print(i)
