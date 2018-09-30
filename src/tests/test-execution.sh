#!/bin/bash

cd ../word2vec

make

if [ ! -e text8 ]; then
    wget http://mattmahoney.net/dc/text8.zip -O text8.gz
    gzip -d text8.gz -f
fi

mkdir trained-models/
mkdir output/

echo 'Training models...'
./word2vec -train text8 -output trained-models/cbow1.bin -cbow 1 -size 200 -window 2 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/cbow2.bin -cbow 1 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/cbow3.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/cbow4.bin -cbow 1 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/skip1.bin -cbow 0 -size 200 -window 2 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/skip2.bin -cbow 0 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/skip3.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

./word2vec -train text8 -output trained-models/skip4.bin -cbow 0 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15

echo 'Finished training models'

echo 'Executing word-analogy tests...'

#./word-analogy trained-models/cbow1.bin < questions-words.txt > output/cbow1.txt
#./word-analogy trained-models/skip1.bin < questions-words.txt > output/skip1.txt

echo 'Finished word-analogy tests'

make clean

cd ../tests
