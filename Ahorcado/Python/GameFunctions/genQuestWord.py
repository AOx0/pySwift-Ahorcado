import sys
from random import randint as random

def genWord():
    generatedDisplayWord = ""

    for i in sys.argv[1]:
        if [1,1,1,1,2,2][random(0,5)] == 2:
            generatedDisplayWord += i
        else:
            generatedDisplayWord += "ˍ"

    return generatedDisplayWord

generatedDisplayWord = ""

while True:
    if "ˍ" not in generatedDisplayWord:
        generatedDisplayWord = genWord()
    else:
        break;
        
print(generatedDisplayWord)
