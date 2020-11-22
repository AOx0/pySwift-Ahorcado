import json, sys
from random import randint as random

with open(f"{sys.argv[1]}/Library/Application Support/AOX0/save.json", "r") as file:
    data = json.load(file)

    difficulty = sys.argv[2]

    if difficulty == "deafult":
        words = data["palabras"]["dificiles"] + data["palabras"]["faciles"]
        palabraRandom = words[random(0, len(words)-1)]
    elif difficulty == "easy":
        palabraRandom = data["palabras"]["faciles"][random(0, len(data["palabras"]["faciles"])-1)]
    else:
        palabraRandom = data["palabras"]["dificiles"][random(0, len(data["palabras"]["dificiles"])-1)]

    print(palabraRandom)
    
    file.close()
