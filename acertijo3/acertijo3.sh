#!/bin/bash

readonly REGEX_SEGUNDOS='[0-9]+$';
readonly REGEX_ANIOS='[0-9]{4}'

segundos_ordenados=$(grep -oE "$REGEX_SEGUNDOS" "$1" | sort -n |uniq );
anios_ordenados=$(grep -oE "$REGEX_ANIOS" "$1" | sort -n | uniq)

resultados=""
for anio in $anios_ordenados;do
    for seg in $segundos_ordenados; do
    REGEX_ANIOS_SEGS="$anio,$seg\$"
    anios_por_segundos=$(grep -E "$REGEX_ANIOS_SEGS" "$1" | grep -v '^$' );
    if [[ ! -z "$anios_por_segundos" ]]; then
            resultados+="$anios_por_segundos"$'\n'
    fi
    done
done

echo "$resultados" | uniq;