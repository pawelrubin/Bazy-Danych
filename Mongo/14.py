import pymongo
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
agenci = MFilmoteka["agenci"]

bez_liter = agenci.find(
  {
    'name': {
      '$regex': '^[^vxq].*|Kevin',
      '$options': 'i'
    },
    'surname': {
      '$regex': '^[^vxq].*',
      '$options': 'i'
    }
  },
  {
    '_id': 0,
    'name': 1,
    'surname': 1,
    'corpo': 1
  }
)

bez_liter_korpo = agenci.find(
  {
    'name': {
      '$regex': '^[^vxq].*|Kevin',
      '$options': 'i'
    },
    'surname': {
      '$regex': '^[^vxq].*',
      '$options': 'i'
    },
    'corpo': {
      '$ne': None
    }
  },
  {
    '_id': 0,
    'name': 1,
    'surname': 1,
    'corpo': 1
  }
)
for i in bez_liter:
  pprint(i)

print("")

for i in bez_liter_korpo:
  pprint(i)
