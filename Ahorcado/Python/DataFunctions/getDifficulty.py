import json, sys

userPath = sys.argv[1]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r") as file:
    data = json.load(file)
    print(data["difficulty"])
    file.close()
