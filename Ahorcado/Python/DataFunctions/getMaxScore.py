import json, sys, os

userPath = sys.argv[1]

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r") as file:
    data = json.load(file)
    
    os.system(f"touch {userPath}/Library/Application\ Support/AOX0/tempLoader.json")
    
    print(f"{data['maxScore']['inEasy']}:{data['maxScore']['inDefault']}:{data['maxScore']['inHard']}:")
    file.close()
    
