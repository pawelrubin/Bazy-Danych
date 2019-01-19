import pymongo
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]
aktorzy = MFilmoteka["aktorzy"]

query = aktorzy.aggregate([{
  '$lookup': {
    'from': 'filmy',
    'localField': '_id',
    'foreignField': 'cast.actor_id',
    'as': 'filmy'
  }}, {
  '$match': {
    'surname': 'Harris'
  }}
])

# query = aktorzy.find(
#   {
#     'surname': 'Harris'
#   },
#   {
#     '_id': 0,
#     'name': 1,
#     'surname': 1
#   }
# )

for i in query:
  pprint(i)
