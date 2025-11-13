#!/bin/bash
# Script: Ejercicio22.sh
# Uso: ./Ejercicio22.sh

# Vector
num=(10 3 5 7 9 3 5 4)

# Algoritmo
impares=0
for n in "${num[@]}"; do
    if (( n % 2 == 0 )); then
        echo "Número par: $n"
    else
        ((impares++))
    fi
done

# Resultado
echo "Cantidad de números impares: $impares"