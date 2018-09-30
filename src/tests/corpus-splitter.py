#!/usr/bin/python3

import math
import numpy as np

percentages = [0.2, 0.4, 0.6, 0.8]

for perc in percentages:
    with open('../word2vec/input/text8', 'r') as totalCorpus:
        totalCorpusLines = totalCorpus.readline()
        totalCorpusSplitted = totalCorpusLines.split()
        totalCorpusSize = len(totalCorpusSplitted)

        percCorpus = []
        while len(percCorpus) < math.ceil(perc * totalCorpusSize):
            percCorpus.extend(totalCorpusSplitted[:math.ceil(perc * totalCorpusSize)])

        percCorpusJoined = " ".join(percCorpus)

        with open('../word2vec/input/text8-'+str(int(perc * 100)), 'w') as percText:
            percText.write(percCorpusJoined)
            percText.close()

        totalCorpus.close()
