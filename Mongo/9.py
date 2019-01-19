import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]

query = filmy.aggregate([
  {'$project': {
    '_id': 0,
    'Tytuł': 1,
    'Liczebność obsady': {'$size': '$Obsada'}
  }},
  {'$match': {'Liczebność obsady': {'$gt': 7}}},
  {'$skip': 1}
])
for i in query:
  print(i)

# to tez zadziala
# query1 = filmy.find({'Obsada.7': {'$exists': True}}, {"_id": 0, "Tytuł": 1})
# query1_1 = iter(query1)
# next(query1_1)
# for i in query1_1:
#   print(i)
