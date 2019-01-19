from random import randint

def randelem(array):
  return array[randint(0, len(array)-1)]

def randYear():
  return randint(1900, 2018)