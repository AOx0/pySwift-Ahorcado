import json, sys

userPath = sys.argv[1]
newWord = sys.argv[2].lower()

def hasVowels(letters):
    indeedHas = False
    for i in letters:
        if i in newWord:
            indeedHas = True
    
    return indeedHas

with open(f"{userPath}/Library/Application Support/AOX0/save.json", "r+", encoding='utf8') as file:
    data = json.load(file)
    
    wordLen = len(newWord)
    numVowels = newWord.count("a") + newWord.count("e") + newWord.count("i") + newWord.count("o") + newWord.count("u")
    numConsonants = wordLen - numVowels
    
    if numVowels/wordLen > 0.6 or wordLen < 6:
        data["userWords"]["easyWords"].append(newWord)
    else:
        if wordLen > 10 or numConsonants > 0.4 or hasVowels(["z","j","ñ","x","k","w"]):
            if wordLen < 5:
                data["userWords"]["defaultWords"].append(newWord)
            else:
                data["userWords"]["hardWords"].append(newWord)
        else:
            data["userWords"]["defaultWords"].append(newWord)
    
    file.seek(0)
    file.write(json.dumps(data, indent=4, separators=(", ", " : "), ensure_ascii=False))
    file.truncate()
    file.close()
