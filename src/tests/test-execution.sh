#!/bin/bash

cd ../word2vec

make

if [ ! -e input/text8 ]; then
    wget http://mattmahoney.net/dc/text8.zip -O text8.gz
    gzip -d text8.gz -f
    mkdir -p input/
    mv text8 input/text8
fi

if [ ! -e input/text8-20 ]; then
    echo 'Splitting corpus into different percentages...'
    cd ../tests
    python3 corpus-splitter.py
    cd ../word2vec
    echo 'Finished splitting corpus into different percentages'
fi


mkdir -p trained-models/
mkdir -p output/

echo 'Training models...'
if [ ! -e trained-models/cbow1.bin ]; then
    echo 'Training cbow1...'
    ./word2vec -train input/text8 -output trained-models/cbow1.bin -cbow 1 -size 200 -window 2 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow2.bin ]; then
    echo 'Training cbow2...'
    ./word2vec -train input/text8 -output trained-models/cbow2.bin -cbow 1 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow3.bin ]; then
    echo 'Training cbow3...'
    ./word2vec -train input/text8 -output trained-models/cbow3.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow4.bin ]; then
    echo 'Training cbow4...'
    ./word2vec -train input/text8 -output trained-models/cbow4.bin -cbow 1 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow5.bin ]; then
    echo 'Training cbow5...'
    ./word2vec -train input/text8-20 -output trained-models/cbow5.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow6.bin ]; then
    echo 'Training cbow6...'
    ./word2vec -train input/text8-40 -output trained-models/cbow6.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow7.bin ]; then
    echo 'Training cbow7...'
    ./word2vec -train input/text8-60 -output trained-models/cbow7.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/cbow8.bin ]; then
    echo 'Training cbow8...'
    ./word2vec -train input/text8-80 -output trained-models/cbow8.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip1.bin ]; then
    echo 'Training skip1...'
    ./word2vec -train input/text8 -output trained-models/skip1.bin -cbow 0 -size 200 -window 2 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip2.bin ]; then
    echo 'Training skip2...'
    ./word2vec -train input/text8 -output trained-models/skip2.bin -cbow 0 -size 200 -window 5 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip3.bin ]; then
    echo 'Training skip3...'
    ./word2vec -train input/text8 -output trained-models/skip3.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip4.bin ]; then
    echo 'Training skip4...'
    ./word2vec -train input/text8 -output trained-models/skip4.bin -cbow 0 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip5.bin ]; then
    echo 'Training skip5...'
    ./word2vec -train input/text8-20 -output trained-models/skip5.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip6.bin ]; then
    echo 'Training skip6...'
    ./word2vec -train input/text8-40 -output trained-models/skip6.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip7.bin ]; then
    echo 'Training skip7...'
    ./word2vec -train input/text8-60 -output trained-models/skip7.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

if [ ! -e trained-models/skip8.bin ]; then
    echo 'Training skip8...'
    ./word2vec -train input/text8-80 -output trained-models/skip8.bin -cbow 0 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
fi

echo 'Finished training models'

if [ ! -e input/questions-words-lower-input.txt ]; then
    echo 'Executing question-words pre-processor...'
    cd ../tests
    python3 questions-words-pre-processor.py
    cd ../word2vec
    echo 'Finished question-words pre-processor'
fi


echo 'Executing word-analogy tests...'

if [ ! -e output/cbow1.txt ]; then
    echo 'cbow1 word-analogy test...'
    ./word-analogy trained-models/cbow1.bin < input/questions-words-lower-input.txt > output/cbow1.txt
fi

if [ ! -e output/cbow2.txt ]; then
    echo 'cbow2 word-analogy test...'
    ./word-analogy trained-models/cbow2.bin < input/questions-words-lower-input.txt > output/cbow2.txt
fi

if [ ! -e output/cbow3.txt ]; then
    echo 'cbow3 word-analogy test...'
    ./word-analogy trained-models/cbow3.bin < input/questions-words-lower-input.txt > output/cbow3.txt
fi

if [ ! -e output/cbow4.txt ]; then
    echo 'cbow4 word-analogy test...'
    ./word-analogy trained-models/cbow4.bin < input/questions-words-lower-input.txt > output/cbow4.txt
fi

if [ ! -e output/cbow5.txt ]; then
    echo 'cbow5 word-analogy test...'
    ./word-analogy trained-models/cbow5.bin < input/questions-words-lower-input.txt > output/cbow5.txt
fi

if [ ! -e output/cbow6.txt ]; then
    echo 'cbow6 word-analogy test...'
    ./word-analogy trained-models/cbow6.bin < input/questions-words-lower-input.txt > output/cbow6.txt
fi

if [ ! -e output/cbow7.txt ]; then
    echo 'cbow7 word-analogy test...'
    ./word-analogy trained-models/cbow7.bin < input/questions-words-lower-input.txt > output/cbow7.txt
fi

if [ ! -e output/cbow8.txt ]; then
    echo 'cbow8 word-analogy test...'
    ./word-analogy trained-models/cbow8.bin < input/questions-words-lower-input.txt > output/cbow8.txt
fi

if [ ! -e output/skip1.txt ]; then
    echo 'skip1 word-analogy test...'
    ./word-analogy trained-models/skip1.bin < input/questions-words-lower-input.txt > output/skip1.txt
fi

if [ ! -e output/skip2.txt ]; then
    echo 'skip2 word-analogy test...'
    ./word-analogy trained-models/skip2.bin < input/questions-words-lower-input.txt > output/skip2.txt
fi

if [ ! -e output/skip3.txt ]; then
    echo 'skip3 word-analogy test...'
    ./word-analogy trained-models/skip3.bin < input/questions-words-lower-input.txt > output/skip3.txt
fi

if [ ! -e output/skip4.txt ]; then
    echo 'skip4 word-analogy test...'
    ./word-analogy trained-models/skip4.bin < input/questions-words-lower-input.txt > output/skip4.txt
fi

if [ ! -e output/skip5.txt ]; then
    echo 'skip5 word-analogy test...'
    ./word-analogy trained-models/skip5.bin < input/questions-words-lower-input.txt > output/skip5.txt
fi

if [ ! -e output/skip6.txt ]; then
    echo 'skip6 word-analogy test...'
    ./word-analogy trained-models/skip6.bin < input/questions-words-lower-input.txt > output/skip6.txt
fi

if [ ! -e output/skip7.txt ]; then
    echo 'skip7 word-analogy test...'
    ./word-analogy trained-models/skip7.bin < input/questions-words-lower-input.txt > output/skip7.txt
fi

if [ ! -e output/skip8.txt ]; then
    echo 'skip8 word-analogy test...'
    ./word-analogy trained-models/skip8.bin < input/questions-words-lower-input.txt > output/skip8.txt
fi

echo 'Finished word-analogy tests'

make clean

cd ../tests

if [ ! -e models-distances.txt ]; then
    echo 'Calculating models distances...'
    python3 models-distances.py > models-distances.txt
    echo 'Finished calculating models distances'
fi
