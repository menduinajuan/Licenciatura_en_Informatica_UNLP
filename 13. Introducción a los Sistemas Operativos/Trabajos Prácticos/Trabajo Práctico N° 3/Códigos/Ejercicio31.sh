#!/bin/bash
# Script: Ejercicio31.sh
# Uso: ./Ejercicio31.sh

# Control de cantidad de parámetros
if [ $# -lt 1 ]; then
    echo "Error: Se debe pasar, al menos, 1 parámetro"
    echo "Uso: $0 <nombre_usuario1> <nombre_usuario2> ..."
    exit 1
fi

# Algoritmo
for usuario in "$@"; do

    if ! id "$usuario" &>/dev/null; then
        echo "El usuario $usuario no existe en el sistema"
        continue
    fi

    home_dir=$(getent passwd "$usuario" | cut -d: -f6)

    if [ ! -d "$home_dir" ]; then
        echo "El usuario '$usuario' no tiene home válido"
        continue
    fi

    echo "Creando estructura en $home_dir/directorio_iso..."

    mkdir -p "$home_dir/directorio_iso/"{2025/{01..12},2026/{01..12}}

    for year in {2025..2026}; do
        for month in {01..12}; do
            touch "$home_dir/directorio_iso/$year/$month/archivo.txt"
        done
    done

    echo "Estructura creada en $home_dir/directorio_iso"

done