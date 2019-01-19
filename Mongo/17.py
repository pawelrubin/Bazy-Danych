import pymongo
from bson.json_util import dumps 

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
MBookStore = myclient["MBookStore"]

filmy = MFilmoteka["filmy"]
books = MBookStore["books"]

qeury = filmy.find({
  "Tytuł": {
    "$in": {
      books.find({}, {
        '_id': 0,
        'title': 1
      })
    }
  }}, {
    '_id': 0,
    'Tytuł': 1
  })

# parsed = json.loads(filmy.find_one({}, {'_id': 0, }).toStr())
query = filmy.find_one({}, {'_id': 0, })
# printdumps( filmy.find_one({}, {'_id': 0, }))
# for i in qeury:
#   print(i)