#!/bin/bash
# Script: Ejercicio17.sh
# Uso: ./Ejercicio17.sh

# Algoritmo
for archivo in *; do
    # Transformación del nombre:
    # - Intercambia minúsculas y mayúsculas: 'tr a-zA-Z A-Za-z'
    # - Elimina todas las 'a' o 'A': 'tr -d'
    if [ -f "$archivo" ]; then
        nuevo_nombre=$(echo "$archivo" | tr 'a-zA-Z' 'A-Za-z' | tr -d 'aA')
        echo "$nuevo_nombre"
    fi
done