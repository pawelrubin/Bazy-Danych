import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]
aktorzy = MFilmoteka["aktorzy"]

for actor in aktorzy.find({ 'surname': 'Harris' }):
    for film in filmy.find():    
        for cast_member in film['cast']:
            if cast_member['actor_id'] == actor['_id']:
                print({
                    "name": actor['name'],
                    "surname": actor['surname'],
                    "country": actor['country'],
                    "film_title": film['title']
                })
                break
