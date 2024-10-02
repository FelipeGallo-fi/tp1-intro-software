#!/bin/bash

readonly REGEX_MINUTOS='[0-9]+$';
readonly REGEX_ANIOS='[0-9]{4}'
readonly archivo="$1"
readonly minutos_ordenados=$(grep -oE "$REGEX_MINUTOS" "$1" | sort -n |uniq );
readonly anios_ordenados=$(grep -oE "$REGEX_ANIOS" "$1" | sort -n | uniq)

ordenar_anios(){
    local lineas_ordenadas="";
    local anio;
    local mins;
    for anio in $1;do

        for mins in $2; do

            REGEX_ANIOS_MINS="$anio,$mins\$"

            anios_por_minutos=$(grep -E "$REGEX_ANIOS_MINS" "$archivo" );

            if [[ ! -z "$anios_por_minutos" ]]; then
            lineas_ordenadas+="$anios_por_minutos"$'\n'
            fi
        done

    done

    echo "$lineas_ordenadas";
}

tres_mejores_tiempos_generales(){
    mejores_tiempos=$(echo "$1" | grep -oE "$REGEX_MINUTOS" | sort -n | head -n 3);

    local tres_mejores="";

    for mins in $mejores_tiempos;do

        lineas_mejores_tiempos=$(echo "$1" | grep -E "\,$mins\$");
        tres_mejores+="$lineas_mejores_tiempos"$'\n'
    done

    echo "$tres_mejores" | head -n 3 > acertijo3.txt;
}

infractores(){
    local anio;
    local auxiliar="";
    for anio in $2; do
        lineas_anio=$(echo "$1" | grep "/$anio,");
        mejores_tiempos=$(echo "$lineas_anio" | grep -oE "$REGEX_MINUTOS" | sort -n | head -n 3);
        for mins in $mejores_tiempos;do
            mejores_tiempos_por_anio=$(echo "$lineas_anio" | grep -E ",$mins\$");
            auxiliar+="$mejores_tiempos_por_anio"$'\n'
        done
    done
    echo "$auxiliar" | grep -v '^$' > $3;
}

lineas_ordenadas=$(ordenar_anios "$anios_ordenados" "$minutos_ordenados");
tres_mejores_tiempos_generales "$lineas_ordenadas";
infractores "$lineas_ordenadas" "$anios_ordenados" infractores.txt;