#!/bin/bash
# Script: Ejercicio13c.sh
# Uso: ./Ejercicio13c.sh

# Control de cantidad de parámetros
if [ $# -ne 1 ]; then
    echo "Error: Se debe pasar, exactamente, 1 parámetro"
    echo "Uso: $0 <nombre_archivo>"
    exit 1
fi

# Asignación de parámetros
nombre=$1

# Algoritmo
if [ -e "$nombre" ]; then
    if [ -d "$nombre" ]; then
        echo "‘$nombre’ existe y es un directorio"
    elif [ -f "$nombre" ]; then
        echo "‘$nombre’ existe y es un archivo regular"
    else
        echo "‘$nombre’ existe, pero no es ni archivo ni directorio"
    fi
else
    echo "‘$nombre’ no existe. Se creará un directorio con ese nombre..."
    mkdir "$nombre"
    echo "Directorio ‘$nombre’ creado correctamente"
fi