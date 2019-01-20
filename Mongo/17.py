import pymongo
import datetime
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MBookStore = myclient["MBookStore"]
MFilmoteka = myclient["MFilmoteka"]
books = MBookStore["books"]
filmy = MFilmoteka["filmy"]

for film in filmy.find():
    if isinstance(film['publish_date'], str):
        film['publish_date'] = datetime.datetime.strptime(film['publish_date'], '%Y-%m-%d').year

    for book in books.find({
        'title': film['title'],
        'publish_year': { '$lt': film['publish_date'] },
        'main_characters': {
            '$in': [cast['role'] for cast in film['cast']]
        }
    }):
        print({
        "film title": film['title'],
        "from book": book['title'],
        "film date": film['publish_date'],
        "book date": book['publish_year']
        })
