#!/usr/bin/env bash

ARRAY=( Caenorhabditis%20elegans Drosophila%20melanogaster Danio%20rerio Mus%20musculus Saccharomyces%20cerevisiae Rattus%20norvegicus Homo%20sapiens )


for i in "${ARRAY[@]}"
do
    echo groovy ./add_organism.groovy -name $i -url http://localhost:8080/apollo/ -directory /data/$i -username $USERNAME -password $PASSWORD -public
#    groovy ./add_organism.groovy -name $i -url http://localhost:8080/apollo/ -directory /data/$i -username $USERNAME -password $PASSWORD -public
done

