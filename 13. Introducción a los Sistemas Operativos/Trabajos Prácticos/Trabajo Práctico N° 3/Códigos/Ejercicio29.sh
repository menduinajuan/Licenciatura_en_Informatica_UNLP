#!/bin/bash
# Script: Ejercicio29.sh
# Uso: ./Ejercicio29.sh

# Directorio bin del usuario actual
BIN_DIR="/home/jmenduina/bin"

# Creación del directorio bin si no existe
if [ ! -d "$BIN_DIR" ]; then
    mkdir "$BIN_DIR"
fi

# Algoritmo
count=0
for archivo in *; do
    if [ -f "$archivo" ] && [ -x "$archivo" ]; then
        echo "Moviendo: $archivo"
        mv "$archivo" "$BIN_DIR/"
        ((count++))
    fi
done

# Resultado
if [ "$count" -gt 0 ]; then
    echo "Se han movido $count archivo(s)"
else
    echo "No se ha movido ningún archivo ejecutable"
fi