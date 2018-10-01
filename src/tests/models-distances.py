#!/usr/bin/python3

import numpy as np

def compareWordsAndDistances(words, wordsAndDistances):
    if len(words) == 3 and len(wordsAndDistances) > 0:
        with open('../word2vec/input/questions-words-lower-answer.txt') as answerFile:
            for line in answerFile:
                answerWords = line.split()

                if answerWords[:3] == words:
                    lineAnswer = answerWords[3]

                    if lineAnswer in wordsAndDistances.keys():
                        wordMaxDist = max(wordsAndDistances, key=lambda x: wordsAndDistances[x])

                        distance = wordsAndDistances[wordMaxDist] - wordsAndDistances[lineAnswer]
                        return round(distance, 6)

    return -1

outputs = ['cbow' + str(i) for i in range(1,9)] + ['skip' + str(i) for i in range(1,9)]
# outputs = ['test']

for output in outputs:
    with open('../word2vec/output/'+ output +'.txt') as rawOutput:
        distances = []
        words = []
        wordsAndDistances = {}
        rawLines = rawOutput.readlines()
        while len(rawLines) > 0:
            line = rawLines.pop(0).strip()

            if 'Enter three words' in line:
                distance = compareWordsAndDistances(words, wordsAndDistances)

                if distance >= 0:
                    distances.append(distance)

                words = []
                wordsAndDistances = {}

            elif 'Word:' in line:
                words.append(line.split()[1])

            elif '-'*10 in line:
                while 1:
                    line = rawLines.pop(0).strip()

                    if 'Enter three words' in line:
                        rawLines.insert(0, line)
                        break

                    else:
                        wordsAndDistances[line.split()[0]] = float(line.split()[1])

        print('***Stats for '+ output +'***')
        print('Number of matches:', len(distances))
        print('Distances Mean:', np.mean(distances))
