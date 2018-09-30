#!/bin/bash

cd ../word2vec

make

if [ ! -e input/text8 ]; then
    wget http://mattmahoney.net/dc/text8.zip -O text8.gz
    gzip -d text8.gz -f
    mkdir -p input/
    mv text8 input/text8
fi

echo 'Splitting corpus into different percentages...'

cd ../tests
python3 corpus-splitter.py
cd ../word2vec

mkdir -p trained-models/
mkdir -p output/

echo 'Finished splitting corpus into different percentages'

echo 'Training models...'
if [ ! -e trained-models/cbow1.bin ]; then
    ./word2vec -train input/text8 -output trained-models/cbow1.bin -cbow 1 -size 200 -window 2 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow2.bin ]; then
    ./word2vec -train input/text8 -output trained-models/cbow2.bin -cbow 1 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow3.bin ]; then
    ./word2vec -train input/text8 -output trained-models/cbow3.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow4.bin ]; then
    ./word2vec -train input/text8 -output trained-models/cbow4.bin -cbow 1 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow5.bin ]; then
    ./word2vec -train input/text8-20 -output trained-models/cbow5.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow6.bin ]; then
    ./word2vec -train input/text8-40 -output trained-models/cbow6.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow7.bin ]; then
    ./word2vec -train input/text8-60 -output trained-models/cbow7.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow8.bin ]; then
    ./word2vec -train input/text8-80 -output trained-models/cbow8.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip1.bin ]; then
    ./word2vec -train input/text8 -output trained-models/skip1.bin -cbow 0 -size 200 -window 2 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip2.bin ]; then
    ./word2vec -train input/text8 -output trained-models/skip2.bin -cbow 0 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip3.bin ]; then
    ./word2vec -train input/text8 -output trained-models/skip3.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip4.bin ]; then
    ./word2vec -train input/text8 -output trained-models/skip4.bin -cbow 0 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip5.bin ]; then
    ./word2vec -train input/text8-20 -output trained-models/skip5.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip6.bin ]; then
    ./word2vec -train input/text8-40 -output trained-models/skip6.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip7.bin ]; then
    ./word2vec -train input/text8-60 -output trained-models/skip7.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip8.bin ]; then
    ./word2vec -train input/text8-80 -output trained-models/skip8.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

echo 'Finished training models'

echo 'Executing question-words pre-processor...'

cd ../tests
python3 questions-words-pre-processor.py
cd ../word2vec

echo 'Finished question-words pre-processor'

echo 'Executing word-analogy tests...'

./word-analogy trained-models/cbow1.bin < input/questions-words-lower-input.txt > output/cbow1.txt

./word-analogy trained-models/cbow2.bin < input/questions-words-lower-input.txt > output/cbow2.txt

./word-analogy trained-models/cbow3.bin < input/questions-words-lower-input.txt > output/cbow3.txt

./word-analogy trained-models/cbow4.bin < input/questions-words-lower-input.txt > output/cbow4.txt

./word-analogy trained-models/cbow5.bin < input/questions-words-lower-input.txt > output/cbow5.txt

./word-analogy trained-models/cbow6.bin < input/questions-words-lower-input.txt > output/cbow6.txt

./word-analogy trained-models/cbow7.bin < input/questions-words-lower-input.txt > output/cbow7.txt

./word-analogy trained-models/cbow8.bin < input/questions-words-lower-input.txt > output/cbow8.txt

./word-analogy trained-models/skip1.bin < input/questions-words-lower-input.txt > output/skip1.txt

./word-analogy trained-models/skip2.bin < input/questions-words-lower-input.txt > output/skip2.txt

./word-analogy trained-models/skip3.bin < input/questions-words-lower-input.txt > output/skip3.txt

./word-analogy trained-models/skip4.bin < input/questions-words-lower-input.txt > output/skip4.txt

./word-analogy trained-models/skip5.bin < input/questions-words-lower-input.txt > output/skip5.txt

./word-analogy trained-models/skip6.bin < input/questions-words-lower-input.txt > output/skip6.txt

./word-analogy trained-models/skip7.bin < input/questions-words-lower-input.txt > output/skip7.txt

./word-analogy trained-models/skip8.bin < input/questions-words-lower-input.txt > output/skip8.txt

echo 'Finished word-analogy tests'

make clean

cd ../tests
