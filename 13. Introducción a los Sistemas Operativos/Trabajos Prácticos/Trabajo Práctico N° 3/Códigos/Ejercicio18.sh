#!/bin/bash
# Script: Ejercicio18.sh
# Uso: ./Ejercicio18.sh

# Control de cantidad de parámetros
if [ $# -ne 1 ]; then
    echo "Error: Se debe pasar, exactamente, 1 parámetro"
    echo "Uso: $0 <nombre_usuario>"
    exit 1
fi

# Asignación de parámetros
usuario=$1

# Algoritmo
while true; do
    if who | grep -wq "$usuario"; then
        echo "Usuario $usuario logueado en el sistema"
        exit 0
    else
        echo "Esperando que $usuario se loguee..."
        sleep 10
    fi
done