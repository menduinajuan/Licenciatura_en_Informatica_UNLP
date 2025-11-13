#!/bin/bash
# Script: Ejercicio23.sh
# Uso: ./Ejercicio23.sh

# Vectores
vector1=(1 80 65 35 2)
vector2=(5 98 3 41 8)

# Algoritmo
for ((i=0; i<${#vector1[@]}; i++)); do
    suma=$(( ${vector1[i]} + ${vector2[i]} ))
    echo "La suma de los elementos de la posición $i de los vectores es $suma"
done