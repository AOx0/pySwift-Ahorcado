import json, sys

userPath = sys.argv[1]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r+") as file:
    data = json.load(file)
    
    data["userWords"]["hardWords"] = []
    data["userWords"]["defaultWords"] = []
    data["userWords"]["easyWords"] = []
    
    file.seek(0)
    file.write(json.dumps(data, indent=4, separators=(", ", " : ")))
    file.truncate()
    file.close()
