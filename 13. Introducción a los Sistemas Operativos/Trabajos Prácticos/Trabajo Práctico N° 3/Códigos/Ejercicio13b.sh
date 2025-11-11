#!/bin/bash
# Script: Ejercicio13b.sh
# Uso: ./Ejercicio13b.sh

# Selección de opción por parte del usuario
echo "Seleccionar una opción:"
echo "1) Listar"
echo "2) DondeEstoy"
echo "3) QuienEsta"
read -p "Opción: " opcion

# Algoritmo
case $opcion in
    1|Listar|listar)
        echo "Contenido del directorio actual:"
        ls
        ;;
    2|DondeEstoy|dondeestoy)
        echo "Ruta actual:"
        pwd
        ;;
    3|QuienEsta|quienesta)
        echo "Usuarios conectados:"
        who
        ;;
    *)
        echo "Opción inválida"
        ;;
esac