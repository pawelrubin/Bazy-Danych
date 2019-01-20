import pymongo
import datetime
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MBookStore = myclient["MBookStore"]
MFilmoteka = myclient["MFilmoteka"]
books = MBookStore["books"]
filmy = MFilmoteka["filmy"]

for film in filmy.find():
  for book in books.aggregate([
      { '$match': {
        'title': film['title'],
        # 'main_characters': {
        #   '$in': film['cast']
        # }
      }}
    ]):

    pprint({
      "film director": film['director'],
      "film characters from book": book['main_characters']
    })
