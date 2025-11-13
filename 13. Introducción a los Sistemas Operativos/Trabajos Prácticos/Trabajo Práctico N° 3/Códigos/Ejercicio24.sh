#!/bin/bash
# Script: Ejercicio24.sh
# Uso: ./Ejercicio24.sh

# Grupo
group="users"

# Obtención de todos los nombres de los usuarios del sistema pertenecientes al grupo "$group"
usuarios=($(getent group "$group" | cut -d: -f4 | tr ',' ' '))

# Verificación de usuarios encontrados
if [ ${#usuarios[@]} -eq 0 ]; then
    echo "No se encontraron usuarios del sistema pertenecientes al grupo '$group'"
    exit 1
fi

# Algoritmo
case "$1" in
    -b)
        n=$2
        if [ -z "$n" ]; then
            echo "Error: Se debe especificar un número después de '-b'"
            exit 1
        elif [ "$n" -ge 0 ] && [ "$n" -lt "${#usuarios[@]}" ]; then
            echo "Elemento en la posición $n: ${usuarios[$n]}"
        else
            echo "Error: No existe la posición $n en el arreglo"
        fi
        ;;
    -l)
        echo "La longitud del arreglo es: ${#usuarios[@]}"
        ;;
    -i)
        echo "Usuarios en el grupo '$group':"
        for u in "${usuarios[@]}"; do
            echo " - $u"
        done
        ;;
    *)
        echo "Uso: $0 [-b n | -l | -i]"
        echo " -b n : Retorna el elemento de la posición n del arreglo"
        echo " -l   : Retorna la longitud del arreglo"
        echo " -i   : Imprime todos los elementos del arreglo"
        ;;
esac