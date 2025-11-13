#!/bin/bash
# Script: Ejercicio21.sh
# Uso: ./Ejercicio21.sh

# Vector
num=(10 3 5 7 9 3 5 4)

# Algoritmo
productoria() {
    local prod=1
    for n in "${num[@]}"; do
        prod=$((prod * n))
    done
    echo "$prod"
}

# Resultado
echo "La productoria del vector (${num[@]}) es: $(productoria)"