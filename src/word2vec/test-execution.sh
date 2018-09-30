#!/bin/bash

make

mkdir input
mkdir trained-models
mkdir output

if [ ! -e input/text8 ]; then
    wget http://mattmahoney.net/dc/text8.zip -O text8.gz
    gzip -d text8.gz -f > input/
fi

./word2vec -train input/text8 -output trained-models/cbow1.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
./word-analogy trained-models/cbow1.bin < questions-words.txt > output/cbow1.txt

./word2vec -train input/text8 -output trained-models/skip1.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
./word-analogy trained-models/skip1.bin < questions-words.txt > output/skip1.txt
