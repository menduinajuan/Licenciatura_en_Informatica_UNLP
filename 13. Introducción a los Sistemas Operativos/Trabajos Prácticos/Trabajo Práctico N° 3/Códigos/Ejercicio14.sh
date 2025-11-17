#!/bin/bash
# Script: Ejercicio14.sh
# Uso: ./Ejercicio14.sh

# Control de cantidad de parámetros
if [ $# -ne 3 ]; then
    echo "Error: Se deben pasar, exactamente, 3 parámetros"
    echo "Uso: $0 <directorio> -a|-b <CADENA>"
    exit 1
fi

# Asignación de parámetros
directorio=$1
opcion=$2
cadena=$3

# Verificación de que el directorio exista
if [ ! -d "$directorio" ]; then
    echo "Error: '$directorio' no es un directorio válido"
    exit 1
fi

# Algoritmo
case $opcion in
    -a)
        for archivo in "$directorio"/*; do
            if [ -f "$archivo" ]; then
                nombre=$(basename "$archivo")
                mv "$archivo" "$directorio/${nombre}${cadena}"
            fi
        done
        echo "Archivos renombrados agregando '$cadena' al final"
        ;;
    -b)
        for archivo in "$directorio"/*; do
            if [ -f "$archivo" ]; then
                nombre=$(basename "$archivo")
                mv "$archivo" "$directorio/${cadena}${nombre}"
            fi
        done
        echo "Archivos renombrados agregando '$cadena' al comienzo"
        ;;
    *)
        echo "Opción inválida. Se debe usar: -a o -b"
        exit 1
        ;;
esac