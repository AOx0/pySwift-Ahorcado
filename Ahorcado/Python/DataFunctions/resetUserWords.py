import json, sys

userPath = sys.argv[1]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r+", encoding='utf8') as file:
    data = json.load(file)
    
    data["userWords"]["hardWords"] = []
    data["userWords"]["defaultWords"] = []
    data["userWords"]["easyWords"] = []
    
    file.seek(0)
    file.write(json.dumps(data, indent=4, separators=(", ", " : "), ensure_ascii=False))
    file.truncate()
    file.close()
