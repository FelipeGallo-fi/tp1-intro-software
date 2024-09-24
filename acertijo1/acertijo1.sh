#!/bin/bash

readonly REGEX_LINEA='(([0-9]+\:[1-9]?[13579]?)\ 7\ Pato\ (se resbal. en el barro|se limpi. las pezuñas))';

lineas_coincidientes=$(grep -iE "$REGEX_LINEA" $1);

echo "Hora indicada para capturar a Pato: ${lineas_coincidientes:0:5}" > $2;