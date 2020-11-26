import json, sys
from random import randint as random

with open(f"{sys.argv[1]}/Library/Application Support/AOX0/save.json", "r") as file:
    data = json.load(file)

    difficulty = sys.argv[2]

    if difficulty == "hard":
        words = data["wordsList"]["hardWords"] + data["wordsList"]["easyWords"] + data["wordsList"]["defaultWords"]
    elif difficulty == "default":
        words = data["wordsList"]["defaultWords"] + data["wordsList"]["easyWords"]
    else:
        words = data["wordsList"]["easyWords"]
        
    randomWord = words[random(0, len(words)-1)]
    print(randomWord)
    file.close()
