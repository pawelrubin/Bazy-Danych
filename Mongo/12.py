import pymongo
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
aktorzy = MFilmoteka["aktorzy"]

print(aktorzy.count_documents({'country': 'Rosja'}))

MFilmoteka.aktorzy.update_many(
  { 'country.country': 'Rosja' },
  { '$set':
    {
      'country': 'Rosja'
    }
  }
)

for i in aktorzy.find(
  {'country.country': 'Rosja'}, 
  {
    '_id': 0,
    'name': 1,
    'surname': 1,
    'country': 1
  }):
  pprint(i)

print(aktorzy.count_documents({'country': 'Rosja'}))