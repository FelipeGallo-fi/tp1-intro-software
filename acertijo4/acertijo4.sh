#!/bin/bash

readonly REGEX="[a-z]";

palabras=$(grep -ioE "$REGEX" "$1" | tr -d '\n');

echo "$palabras" | sed 's/[A-Z]/\L&/g' > "$2";

readonly REEMPLAZO="s/cueva/dobla/g;s/secreta/izquierda/g;s/pocos/despues/g;s/metros/derecha/g;s/arriba/adelante/g;s/atras/reversa/g;";

sed -i "$REEMPLAZO" "$2";
