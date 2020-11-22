import sys

palabra = sys.argv[1]
letra = sys.argv[2]
palabraDeUsuario = sys.argv[3]

indexes = []

for i in range(0, len(palabra)):
    if palabra[i] == letra:
        indexes.append(i)

for i in indexes:
    temp = list(palabraDeUsuario)
    temp[i] = list(palabra)[i]
    palabraDeUsuario = "".join(temp)

print(palabraDeUsuario)
