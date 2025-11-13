#!/bin/bash
# Script: Ejercicio25.sh
# Uso: ./Ejercicio25.sh

# Control de cantidad de parámetros
if [ $# -lt 1 ]; then
    echo "Error: Se debe ingresar, al menos, 1 parámetro"
    echo "Uso: $0 <ruta1> <ruta2> ..."
    exit 1
fi

# Algoritmo
inexistentes=0
posicion=1
for ruta in "$@"; do
    if (( posicion % 2 != 0 )); then
        if [ -e "$ruta" ]; then
            if [ -f "$ruta" ]; then
                echo "Posición $posicion: '$ruta' existe y es un archivo"
            elif [ -d "$ruta" ]; then
                echo "Posición $posicion: '$ruta' existe y es un directorio"
            else
                echo "Posición $posicion: '$ruta' existe, pero no es ni archivo ni directorio"
            fi
        else
            echo "Posición $posicion: '$ruta' no existe"
            ((inexistentes++))
        fi
    fi
    ((posicion++))
done

# Resultado
echo "Cantidad de archivos o directorios inexistentes: $inexistentes"