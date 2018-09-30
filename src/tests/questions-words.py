#!/usr/bin/python3

with open('../word2vec/questions-words.txt', 'r') as questionWords, open('../word2vec/question-words-lower-answer.txt', 'w') as output, open('../word2vec/question-words-lower-input.txt', 'w') as inputFile:
    for line in questionWords:
        if line[0] != ':':
            line = line.lower()
            output.write(line)

            lineSplitted = line.split()[:3]

            inputFile.write(" ".join(lineSplitted)  + '\n')

    inputFile.write('EXIT')

    inputFile.close()
    output.close()
    questionWords.close()
