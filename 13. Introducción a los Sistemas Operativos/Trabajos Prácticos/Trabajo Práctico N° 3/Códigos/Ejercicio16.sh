#!/bin/bash
# Script: Ejercicio16.sh
# Uso: ./Ejercicio16.sh

# Control de cantidad de parámetros
if [ $# -ne 1 ]; then
    echo "Error: Se debe ingresar, exactamente, 1 parámetro"
    echo "Uso: $0 <extension>"
    exit 1
fi

# Asignación de parámetros
extension=$1
salida="reporte.txt"

# Limpieza del archivo de salida
> "$salida"

# Algoritmo
echo "Nombre de usuario | Cantidad de archivos con extensión .$extension" >> "$salida"
echo "------------------------------------------------------------" >> "$salida"
for dir in /home/*; do
    if [ -d "$dir" ]; then
        usuario=$(basename "$dir")
        cantidad=$(find "$dir" -type f -name "*.$extension" 2>/dev/null | wc -l)
        echo "$usuario | $cantidad" >> "$salida"
    fi
done
echo "Resultado guardado en $salida"