import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
filmy = MFilmoteka["filmy"]
aktorzy = MFilmoteka["aktorzy"]

for i in aktorzy.find({"Genres": {'$all': ["komedia", "kryminał"]}}):
  print(i)

print(aktorzy.count_documents({}))
aktorzy.delete_many({"Genres": {'$all': ["komedia", "kryminał"]}})

print("usuwam kryminalne śmieszki")
print(aktorzy.count_documents({}))

for i in aktorzy.find({"Genres": {'$all': ["komedia", "kryminał"]}}):
  print(i)