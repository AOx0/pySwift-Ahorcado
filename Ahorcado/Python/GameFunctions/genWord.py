import json, sys
from random import randint as random

with open(f"{sys.argv[1]}/Library/Application Support/AOX0/save.json", "r") as file:
    data = json.load(file)

    difficulty = sys.argv[2]

    if difficulty == "hard":
        words = data["wordsList"]["hardWords"] + data["wordsList"]["easyWords"] + data["wordsList"]["defaultWords"]
        words = words + data["userWords"]["hardWords"] + data["userWords"]["easyWords"] + data["userWords"]["defaultWords"]
    elif difficulty == "default":
        words = data["wordsList"]["defaultWords"] + data["wordsList"]["easyWords"]
        words = words + data["userWords"]["defaultWords"] + data["userWords"]["easyWords"]
    else:
        words = data["wordsList"]["easyWords"] + data["userWords"]["easyWords"]
        
    randomWord = words[random(0, len(words)-1)]
    print(randomWord)
    file.close()
