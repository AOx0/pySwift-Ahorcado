import json, sys
from random import randint as random

with open(f"{sys.argv[1]}/Library/Application Support/AOX0/save.json", "r") as file:
    data = json.load(file)

    difficulty = sys.argv[2]

    if difficulty == "default":
        words = data["wordsList"]["hardWords"] + data["wordsList"]["easyWords"]
        randomWord = words[random(0, len(words)-1)]
    elif difficulty == "easy":
        randomWord = data["wordsList"]["easyWords"][random(0, len(data["wordsList"]["easyWords"])-1)]
    else:
        randomWord = data["wordsList"]["hardWords"][random(0, len(data["wordsList"]["hardWords"])-1)]

    print(randomWord)
    
    file.close()
