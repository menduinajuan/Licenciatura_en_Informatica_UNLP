#!/bin/bash
# Script: Ejercicio19.sh
# Uso: ./Ejercicio19.sh

# Ruta donde están los scripts creados en esta práctica
SCRIPTS_DIR="/home/jmenduina/practica-shell-script"

# Función "mostrar_menu"
mostrar_menu() {
    clear
    echo "=============================="
    echo        "MENÚ DE COMANDOS"
    echo "=============================="
    echo "3. Ejercicio 3"
    echo "12a. Ejercicio 12a"
    echo "12b. Ejercicio 12b"
    echo "12c. Ejercicio 12c"
    echo "13a. Ejercicio 13a"
    echo "13b. Ejercicio 13b"
    echo "13c. Ejercicio 13c"
    echo "17. Ejercicio 17"
    echo "19. Ejercicio 19"
    echo "20. Ejercicio 20"
    echo "21. Ejercicio 21"
    echo "22. Ejercicio 22"
    echo "23. Ejercicio 23"
    echo "24. Ejercicio 24"
    echo "25. Ejercicio 25"
    echo "26. Ejercicio 26"
    echo "27. Ejercicio 27"
    echo "28. Ejercicio 28"
    echo "29. Ejercicio 29"
    echo "30a. Ejercicio 30a"
    echo "30b. Ejercicio 30b"
    echo "31. Ejercicio 31"
    echo "99. Salir"
    echo "------------------------------"
    echo
    echo -n "Introducir número de script a ejecutar: "
}

# Algoritmo
while true; do
    mostrar_menu
    read opcion
    echo
    case "$opcion" in
        3)
            echo "Ejecutando Ejercicio 3..."
            echo
            bash "$SCRIPTS_DIR/ejercicio3.sh"
            ;;
        12a)
            echo "Ejecutando Ejercicio 12a..."
            echo
            bash "$SCRIPTS_DIR/ejercicio12a.sh"
            ;;
        12b)
            echo "Ejecutando Ejercicio 12b..."
            echo
            bash "$SCRIPTS_DIR/ejercicio12b.sh"
            ;;
        12c)
            echo "Ejecutando Ejercicio 12c..."
            echo
            bash "$SCRIPTS_DIR/ejercicio12c.sh"
            ;;
        13a)
            echo "Ejecutando Ejercicio 13a..."
            echo
            bash "$SCRIPTS_DIR/ejercicio13a.sh"
            ;;
        13b)
            echo "Ejecutando Ejercicio 13b..."
            echo
            bash "$SCRIPTS_DIR/ejercicio13b.sh"
            ;;
        13c)
            echo "Ejecutando Ejercicio 13c..."
            echo
            bash "$SCRIPTS_DIR/ejercicio13c.sh"
            ;;
        17)
            echo "Ejecutando Ejercicio 17..."
            echo
            bash "$SCRIPTS_DIR/ejercicio17.sh"
            ;;
        19)
            echo "Ejecutando Ejercicio 19..."
            echo
            bash "$SCRIPTS_DIR/ejercicio19.sh"
            ;;
        20)
            echo "Ejecutando Ejercicio 20..."
            echo
            bash "$SCRIPTS_DIR/ejercicio20.sh"
            ;;
        21)
            echo "Ejecutando Ejercicio 21..."
            echo
            bash "$SCRIPTS_DIR/ejercicio21.sh"
            ;;
        22)
            echo "Ejecutando Ejercicio 22..."
            echo
            bash "$SCRIPTS_DIR/ejercicio22.sh"
            ;;
        23)
            echo "Ejecutando Ejercicio 23..."
            echo
            bash "$SCRIPTS_DIR/ejercicio23.sh"
            ;;
        24)
            echo "Ejecutando Ejercicio 24..."
            echo
            bash "$SCRIPTS_DIR/ejercicio24.sh"
            ;;
        25)
            echo "Ejecutando Ejercicio 25..."
            echo
            bash "$SCRIPTS_DIR/ejercicio25.sh"
            ;;
        26)
            echo "Ejecutando Ejercicio 26..."
            echo
            bash "$SCRIPTS_DIR/ejercicio26.sh"
            ;;
        27)
            echo "Ejecutando Ejercicio 27..."
            echo
            bash "$SCRIPTS_DIR/ejercicio27.sh"
            ;;
        28)
            echo "Ejecutando Ejercicio 28..."
            echo
            bash "$SCRIPTS_DIR/ejercicio28.sh"
            ;;
        29)
            echo "Ejecutando Ejercicio 29..."
            echo
            bash "$SCRIPTS_DIR/ejercicio29.sh"
            ;;
        30a)
            echo "Ejecutando Ejercicio 30a..."
            echo
            bash "$SCRIPTS_DIR/ejercicio30a.sh"
            ;;
        30b)
            echo "Ejecutando Ejercicio 30b..."
            echo
            bash "$SCRIPTS_DIR/ejercicio30b.sh"
            ;;
        31)
            echo "Ejecutando Ejercicio 31..."
            echo
            bash "$SCRIPTS_DIR/ejercicio31.sh"
            ;;
        99)
            echo "Saliendo del menú. ¡Hasta luego!"
            echo
            break
            ;;
        *)
            echo "Opción inválida. Intentar nuevamente"
            ;;
    esac
    echo
    echo -n "Presionar ENTER para continuar..."
    read
done