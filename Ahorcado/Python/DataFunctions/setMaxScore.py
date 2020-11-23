import json, sys

userPath = sys.argv[1]
newValue = sys.argv[2]
difficulty = sys.argv[3]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r+") as file:
    data = json.load(file)
    
    if difficulty == "easy":
        data["maxScore"]["inEasy"] = int(sys.argv[2])
    elif difficulty == "default":
        data["maxScore"]["inDefault"] = int(sys.argv[2])
    else:
        data["maxScore"]["inHard"] = int(sys.argv[2])
    
    file.seek(0)
    file.write(json.dumps(data, indent=4, separators=(", ", " : ")))
    file.truncate()
    file.close()
