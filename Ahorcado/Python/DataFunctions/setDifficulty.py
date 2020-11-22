import json, sys

userPath = sys.argv[1]
newValue = sys.argv[2]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r+") as file:
    data = json.load(file)
    data["dificultad"] = sys.argv[2]
    file.seek(0)
    file.write(json.dumps(data, indent=4, separators=(", ", " : ")))
    file.truncate()
    file.close()
