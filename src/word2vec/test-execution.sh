#!/bin/bash

make

if [ ! -e text8 ]; then
    wget http://mattmahoney.net/dc/text8.zip -O text8.gz
    gzip -d text8.gz -f
fi

./word2vec -train text8 -output cbow1.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
./word-analogy cbow1.bin < questions-words.txt > cbow1.txt

./word2vec -train text8 -output skip1.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
./word-analogy skip1.bin < questions-words.txt > skip1.txt
