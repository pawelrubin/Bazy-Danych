import pymongo
import datetime
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MBookStore = myclient["MBookStore"]
MFilmoteka = myclient["MFilmoteka"]
books = MBookStore["books"]
filmy = MFilmoteka["filmy"]

for book in books.find():
  for film in filmy.aggregate([
      { '$match': {
        'title': book['title']
      }}
    ]):

    pprint({
      "book title": book['title'],
      "book author": book['author'],
      "film director": film['director'],
      "film title": film['title']
    })
