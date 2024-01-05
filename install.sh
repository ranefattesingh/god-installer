#!/bin/bash

files=$(ls ./lib | grep '.sh')
for file in $files
do
    sh $file
done