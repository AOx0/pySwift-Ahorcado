import sys
from random import randint as random

def genWord():
    generatedDisplayWord = ""

    for i in sys.argv[1]:
        if i == " ":
            generatedDisplayWord += " "
        elif [1,1,1,1,2,2][random(0,5)] == 2:
            generatedDisplayWord += i
        else:
            generatedDisplayWord += "ˍ"

    return generatedDisplayWord

generatedDisplayWord = ""
difficulty = sys.argv[2]

if difficulty == "easy":
    while True:
        if "ˍ" not in generatedDisplayWord:
            generatedDisplayWord = genWord()
        else:
            break;
elif difficulty == "default":
    while True:
        if "ˍ" not in generatedDisplayWord or generatedDisplayWord.count("ˍ") < int(len(generatedDisplayWord) * 0.7):
            generatedDisplayWord = genWord()
        else:
            break;
else:
    for i in sys.argv[1]:
        if i == " ":
            generatedDisplayWord += " "
        else:
            generatedDisplayWord += "ˍ"


print(generatedDisplayWord)
