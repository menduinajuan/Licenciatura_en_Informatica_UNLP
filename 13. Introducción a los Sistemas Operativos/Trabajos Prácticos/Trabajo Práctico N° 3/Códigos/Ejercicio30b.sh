#!/bin/bash
# Script: Ejercicio30b.sh
# Uso: ./Ejercicio30b.sh

# Importación de 'Ejercicio30a.sh'
source ./ejercicio30a.sh >/dev/null 2>&1

# Configuración del valor máximo
MAX=99
if [ $# -eq 1 ]; then
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: El valor máximo debe ser un número entero"
        exit 1
    fi
    if [ "$1" -eq 0 ] || [ "$1" -gt 32767 ]; then
        echo "Error: El valor máximo debe ser > 0 y <= 32767"
        exit 2
    fi
    MAX="$1"
fi

# Inicialización de set de números ya cantados
initialize
echo "🎲 ¡ Bingo iniciado (0 a $MAX) ! 🎲"
echo
echo "Presionar ENTER para cantar número o escribir BINGO para terminar"
echo

# Algoritmo
while true; do
    read -p "> " input
    if [[ "$input" == "BINGO" || "$input" == "bingo" || "$input" == "Bingo" ]]; then
        echo "🎉 ¡ Se cantó BINGO ! 🎉"
        break
    fi
    while true; do
        num=$(( RANDOM % (MAX + 1) ))
        if ! contains "$num"; then
            add "$num"
            echo "Número cantado: $num"
            break
        fi
    done
done

# Resultados
echo
echo "📋 Números cantados (ordenados alfabéticamente) hasta que se produjo bingo:"
print_sorted