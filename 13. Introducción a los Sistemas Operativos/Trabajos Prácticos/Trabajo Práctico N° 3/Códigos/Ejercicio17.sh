#!/bin/bash
# Script: Ejercicio17.sh
# Uso: ./Ejercicio17.sh

# Algoritmo
for archivo in *; do
    if [ -f "$archivo" ]; then
        nuevo_nombre=$(echo "$archivo" | tr 'a-zA-Z' 'A-Za-z' | tr -d 'aA')
        echo "$nuevo_nombre"
    fi
done