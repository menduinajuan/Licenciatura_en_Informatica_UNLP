#!/bin/bash
# Script: Ejercicio26.sh
# Uso: ./Ejercicio26.sh

# FUNCIONES

# Inicializar: Crea un arreglo llamado array vacío
inicializar() {
    array=()
    echo "Arreglo llamado 'array' creado vacío"
}

# Agregar_elem: Agrega al final del arreglo el parámetro recibido
agregar_elem() {
    if [ $# -ne 1 ]; then
        echo "Error: Se debe indicar el valor para agregar"
        return 1
    fi
    array+=("$1")
    echo "Elemento '$1' agregado al final del arreglo"
}

# Eliminar_elem: Elimina del arreglo el elemento que se encuentra en la posición recibida como parámetro
eliminar_elem() {
    if [ $# -ne 1 ]; then
        echo "Error: Se debe indicar la posición a eliminar"
        return 1
    fi
    local pos=$1
    if [ "$pos" -lt 0 ] || [ "$pos" -ge "${#array[@]}" ]; then
        echo "Error: Posición fuera de rango (0 a $((${#array[@]} - 1)))"
        return 1
    fi
    unset 'array[pos]'
    array=("${array[@]}")
    echo "Elemento en posición $pos eliminado"
}

# Longitud: Imprime la longitud del arreglo
longitud() {
    echo "Longitud del arreglo: ${#array[@]}"
}

# Imprimir: Imprime todos los elementos del arreglo
imprimir() {
    if [ ${#array[@]} -eq 0 ]; then
        echo "El arreglo está vacío"
    else
        echo "Elementos del arreglo: ${array[@]}"
    fi
}

# Inicializar_con_valores: Crea un arreglo con longitud <parametro1> y, en todas las posiciones, asigna el valor <parametro2>
inicializar_con_valores() {
    if [ $# -ne 2 ]; then
        echo "Error: Se debe indicar longitud y valor"
        return 1
    fi
    local longitud=$1
    local valor=$2
    array=()
    for ((i = 0; i < longitud; i++)); do
        array+=("$valor")
    done
    echo "Arreglo llamado 'array' creado con longitud $longitud y valor '$valor' en todas las posiciones"
}

# PRUEBA

inicializar
agregar_elem "A"
agregar_elem "B"
agregar_elem "C"
imprimir
eliminar_elem 1
imprimir
longitud
inicializar_con_valores 3 X
imprimir