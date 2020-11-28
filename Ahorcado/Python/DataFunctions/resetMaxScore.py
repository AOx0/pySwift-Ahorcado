import json, sys

userPath = sys.argv[1]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r+", encoding='utf8') as file:
    data = json.load(file)
    
    data["maxScore"]["inEasy"] = 0
    data["maxScore"]["inDefault"] = 0
    data["maxScore"]["inHard"] = 0
    
    file.seek(0)
    file.write(json.dumps(data, indent=4, separators=(", ", " : "), ensure_ascii=False))
    file.truncate()
    file.close()

