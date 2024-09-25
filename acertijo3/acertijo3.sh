#!/bin/bash

readonly REGEX_SEGUNDOS='[0-9]+$';
readonly REGEX_ANIOS='[0-9]{4}'

segundos_ordenados=$(grep -oE "$REGEX_SEGUNDOS" "$1" | sort -n |uniq );
anios_ordenados=$(grep -oE "$REGEX_ANIOS" "$1" | sort -n | uniq)

resultados="";

for anio in $anios_ordenados;do

    for seg in $segundos_ordenados; do

    REGEX_ANIOS_SEGS="$anio,$seg\$"

    anios_por_segundos=$(grep -E "$REGEX_ANIOS_SEGS" "$1" );

    if [[ ! -z "$anios_por_segundos" ]]; then
            resultados+="$anios_por_segundos"$'\n'
    fi
    done

done

# echo "$resultados" ;

tres_mejores_tiempos=$(grep -E "$REGEX_ANIOS" "$resultados" | sort -n | head -n 3);

echo "$tres_mejores_tiempos" > acertijo3.txt

cat acertijo3.txt;