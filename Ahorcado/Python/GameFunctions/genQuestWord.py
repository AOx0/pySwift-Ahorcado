import sys
from random import randint as random

def genWord():
    palabraRandomParaUsuario = ""

    for i in sys.argv[1]:
        if [1,1,1,1,2,2][random(0,5)] == 2:
            palabraRandomParaUsuario += i
        else:
            palabraRandomParaUsuario += "ˍ"

    return palabraRandomParaUsuario

palabraRandomParaUsuario = ""

while True:
    if "ˍ" not in palabraRandomParaUsuario:
        palabraRandomParaUsuario = genWord()
    else:
        break;
        
print(palabraRandomParaUsuario)
