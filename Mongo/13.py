import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
aktorzy = MFilmoteka["aktorzy"]

query = aktorzy.aggregate([
  {'$project': {
    "_id": 0,
    "Name": 1,
    "Surname": 1,
    "Country": 1
  }},
  {'$sort': {"Age": 1}}
])

for i in query:
  print(i)