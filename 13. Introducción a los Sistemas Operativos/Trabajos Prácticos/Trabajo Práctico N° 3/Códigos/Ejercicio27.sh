#!/bin/bash
# Script: Ejercicio27.sh
# Uso: ./Ejercicio27.sh

# Control de cantidad de parámetros
if [ $# -ne 1 ]; then
    echo "Error: Se debe ingresar, exactamente, 1 parámetro"
    echo "Uso: $0 <directorio>"
    exit 1
fi

# Asignación de parámetros
directorio="$1"

# Verificación de que el directorio exista
if [ ! -d "$directorio" ]; then
    echo "Error: '$directorio' no es un directorio válido"
    exit 4
fi

# Algoritmo
lectura=0
escritura=0
for archivo in "$directorio"/*; do
    if [ -f "$archivo" ]; then
        if [ -r "$archivo" ]; then
            ((lectura++))
        fi
        if [ -w "$archivo" ]; then
            ((escritura++))
        fi
    fi
done

# Resultados
echo "Archivos con permiso de lectura: $lectura"
echo "Archivos con permiso de escritura: $escritura"