#!/bin/bash

readonly REGEX_SEGUNDOS='[0-9]+$';
readonly REGEX_ANIOS='[0-9]{4}'
readonly archivo="$1"
readonly segundos_ordenados=$(grep -oE "$REGEX_SEGUNDOS" "$1" | sort -n |uniq );
readonly anios_ordenados=$(grep -oE "$REGEX_ANIOS" "$1" | sort -n | uniq)

ordenar_anios(){
    local lineas_ordenadas="";
    local anio;
    local seg;
    for anio in $1;do

        for seg in $2; do

            REGEX_ANIOS_SEGS="$anio,$seg\$"

            anios_por_segundos=$(grep -E "$REGEX_ANIOS_SEGS" "$archivo" );

            if [[ ! -z "$anios_por_segundos" ]]; then
            lineas_ordenadas+="$anios_por_segundos"$'\n'
            fi
        done

    done

    echo "$lineas_ordenadas";
}

tres_mejores_tiempos_generales(){
    mejores_tiempos=$(echo "$1" | grep -oE "$REGEX_SEGUNDOS" | sort -n | head -n 3);

    local tres_mejores="";

    for seg in $mejores_tiempos;do

        lineas_mejores_tiempos=$(echo "$1" | grep -E "\,$seg\$");
        tres_mejores+="$lineas_mejores_tiempos"$'\n'
    done

    echo "$tres_mejores" | head -n 3 > acertijo3.txt;
}

infractores(){
    local anio;
    local auxiliar="";
    for anio in $2; do
        lineas_anio=$(echo "$1" | grep "/$anio,");
        mejores_tiempos=$(echo "$lineas_anio" | grep -oE "$REGEX_SEGUNDOS" | sort -n | head -n 3);
        for seg in $mejores_tiempos;do
            mejores_anios_por_segundo=$(echo "$lineas_anio" | grep -E ",$seg\$");
            auxiliar+="$mejores_anios_por_segundo"$'\n'
        done
    done
    echo "$auxiliar" | grep -v '^$' > $3;
}

lineas_ordenadas=$(ordenar_anios "$anios_ordenados" "$segundos_ordenados");
tres_mejores_tiempos_generales "$lineas_ordenadas";
infractores "$lineas_ordenadas" "$anios_ordenados" infractores.txt;