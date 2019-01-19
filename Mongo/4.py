import pymongo
from random import randint
from tools import randelem
import time
import datetime
from pprint import pprint

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
MFilmoteka = myclient["MFilmoteka"]
agenci = MFilmoteka["agenci"]
aktorzy = MFilmoteka["aktorzy"]

names = ["Hugh", "Al", "Jan", "Paweł", "Szymon", "Karol", "Michał", "Łukasz",
  "Dawid", "Mateusz"]

surnames = ["Tarantino", "Bratos", "Cichoń", "Krupski", "Zawada", "Syga", "Żeberski",
  "Sulkowski", "Macyna", "Kapelko"]

countries = ["Polska", { "country": "Niemcy", "state": "Bawaria"}, "Australia", { "country": "USA", "state": "Kalifornia" }, 
  { "country": "Rosja", "state": "Moskwa" }]

def addClients():
  result = []
  
  return result

for i in range(0, 15):
  clients = addClients()
  record = { 
    "name": randelem(names), 
    "surname": randelem(surnames),
    "country": randelem(countries),
    "clients": clients
  }
  
  