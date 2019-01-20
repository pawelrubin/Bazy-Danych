import pymongo
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
MBookStore = myclient["MBookStore"]
filmy = MFilmoteka["filmy"]
books = MBookStore["books"]

films_titles = filmy.find({}, {'_id': 0, 'title': 1})

query = books.find(
  {
    'title': {
      '$in': filmy.find({}, {'_id': 0, 'title': 1})
    }
  },
  {
    '_id': 0,
    'title': 1
  }
)

for i in query:
  pprint(i)