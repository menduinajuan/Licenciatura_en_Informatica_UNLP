#!/bin/bash
# Script: Ejercicio28.sh
# Uso: ./Ejercicio28.sh

# Vector
touch "/home/existe.doc"
archivos=($(find /home -maxdepth 1 -type f -name "*.doc" 2>/dev/null))

# FUNCIONES

# verArchivo: Imprime el archivo en pantalla si el mismo se encuentra en el arreglo
verArchivo() {
    local archivo="$1"
    for elem in "${archivos[@]}"; do
        if [[ "$(basename "$elem")" == "$archivo" ]]; then
            echo "Mostrando archivo: $elem"
            cat "$elem"
            return 0
        fi
    done
    echo "Archivo no encontrado"
    return 5
}

# cantidadArchivos: Imprime la cantidad de archivos del /home con terminación .doc
cantidadArchivos() {
    echo "Cantidad de archivos en el arreglo: ${#archivos[@]}"
    echo "Cantidad de archivos .doc en /home: $(find /home -maxdepth 1 -type f -name "*.doc" | wc -l)"
}

# borrarArchivo: Elimina un archivo del arreglo y, opcionalmente, del FileSystem
borrarArchivo() {

    local archivo="$1"
    local index=-1

    for i in "${!archivos[@]}"; do
        if [[ "$(basename "${archivos[$i]}")" == "$archivo" ]]; then
            index=$i
            break
        fi
    done

    if [[ $index -eq -1 ]]; then
        echo "Archivo no encontrado"
        return 10
    fi

    local ruta="${archivos[$index]}"

    echo -n "¿Desea eliminar el archivo lógicamente (sólo arreglo) o físicamente (arreglo y FileSystem)? (Sí/No): "
    read respuesta

    if [[ "$respuesta" == "Sí" || "$respuesta" == "Si" || "$respuesta" == "sí" || "$respuesta" == "si" ]]; then
        unset 'archivos[index]'
        archivos=("${archivos[@]}")
        echo "Archivo eliminado del arreglo"
    elif [[ "$respuesta" == "No" || "$respuesta" == "no" ]]; then
        unset 'archivos[index]'
        archivos=("${archivos[@]}")
        rm -f "$ruta"
        echo "Archivo eliminado del arreglo y del FileSystem"
    else
        echo "Respuesta inválida. Se debe responder: 'Sí' o 'No'"
    fi

}

# PRUEBAS

echo "Archivos encontrados: ${archivos[@]}"

verArchivo "noexiste.doc"
verArchivo "existe.doc"
cantidadArchivos
borrarArchivo "noexiste.doc"
borrarArchivo "existe.doc"
cantidadArchivos