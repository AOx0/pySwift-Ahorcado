import sys

word = sys.argv[1]
letter = sys.argv[2].lower()
displayedWord = sys.argv[3]

indexes = []

for i in range(0, len(word)):
    if word[i] == letter:
        indexes.append(i)

for i in indexes:
    temp = list(displayedWord)
    temp[i] = list(word)[i]
    displayedWord = "".join(temp)

print(displayedWord)
