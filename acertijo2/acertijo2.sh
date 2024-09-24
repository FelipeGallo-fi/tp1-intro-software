#!/bin/bash

readonly REGEX_INICIO='^([A-Z]{1}[a-z]{1})';
readonly REGEX_VOC_NUM='([aeiou]{3}|[0-9]+)';


resultado=$(grep -E "$REGEX_INICIO" $1 | grep -Ev "$REGEX_VOC_NUM")

> $2;

IFS=$'\n'; #No entendia porque el for me iteraba palabra por palabra y chat gpt me ayudo un poco con esta linea
for linea in $resultado; do
    numero_de_palabras=$(echo "$linea" | wc -w)

    if [ "$numero_de_palabras" -lt 5 ]; then
        linea_invertida=$(echo "$linea" | rev);
        echo "$linea_invertida" >> $2;
    else 
        echo "$linea" >> $2;
    fi
done

readonly REEMPLAZO_VOC='s/[aeiou]/X/g';

sed -i "$REEMPLAZO_VOC" $2;

cat $2;