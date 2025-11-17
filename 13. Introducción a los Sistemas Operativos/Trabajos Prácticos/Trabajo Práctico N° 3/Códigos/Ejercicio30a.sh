#!/bin/bash
# Script: Ejercicio30a.sh
# Uso: ./Ejercicio30a.sh

# FUNCIONES

# initialize: Inicializa el set vacío
initialize() {
    set=()
}

# initialize_with: Inicializa el set con un conjunto de valores que recibe como argumento
initialize_with() {
    if [ $# -lt 1 ]; then
        echo "Error: Se debe proporcionar, al menos, un valor"
        return 1
    fi
    set=()
    for val in "$@"; do
        add "$val" > /dev/null
    done
}

# add: Agrega un valor al conjunto, el cual recibe como argumento (no debe agregar elementos repetidos)
add() {
    local value="$1"
    for elem in "${set[@]}"; do
        if [[ "$elem" == "$value" ]]; then
            return 1
        fi
    done
    set+=("$value")
    return 0
}

# remove: Elimina uno o más valores del conjunto, los cuales recibe como argumentos
remove() {
    local removed=1
    for val in "$@"; do
        local new_set=()
        local found=1
        for elem in "${set[@]}"; do
            if [[ "$elem" == "$val" ]]; then
                found=0
            else
                new_set+=("$elem")
            fi
        done
        set=("${new_set[@]}")
        if [[ $found -eq 0 && $removed -eq 1 ]]; then
            removed=0
        fi
    done
    return $removed
}

# contains: Chequea si el conjunto contiene un valor recibido como argumento
contains() {
    local val="$1"
    for elem in "${set[@]}"; do
        if [[ "$elem" == "$val" ]]; then
            return 0
        fi
    done
    return 1
}

# print: Imprime los elementos del conjunto, de a uno por línea
print() {
    for elem in "${set[@]}"; do
        echo "$elem"
    done
}

# print_sorted: Imprime los elementos del conjunto, de a uno por línea y ordenados alfabéticamente
print_sorted() {
    print | sort
}

# PRUEBAS

echo "Inicializando set sin valores..."
initialize

echo "Inicializando set con valores A B C..."
initialize_with A B C
echo "Imprimiendo set:"
print

echo "Inicializando set con valores C B A..."
initialize_with C B A
echo "Imprimiendo set (con elementos ordenados alfabéticamente):"
print_sorted

echo "Intentando agregar valor A..."
add A && echo "Se pudo agregar" || echo "No se pudo agregar (repetido)"
echo "Intentando agregar valor D..."
add D && echo "Se pudo agregar" || echo "No se pudo agregar (repetido)"
echo "Imprimiendo set:"
print

contains A && echo "Contiene A" || echo "No contiene A"
contains Z && echo "Contiene Z" || echo "No contiene Z"

echo "Intentando eliminar valores A y Z..."
remove A Z && echo "Se eliminó algo" || echo "No se eliminó nada"
echo "Imprimiendo set:"
print