#!/bin/bash
# Script: Ejercicio12c.sh
# Uso: ./Ejercicio12c.sh <operación> <num1> <num2>

# Control de cantidad de parámetros
if [ $# -ne 3 ]; then
    echo "Error: Se deben ingresar, exactamente, 3 parámetros"
    echo "Uso: $0 <operación> <num1> <num2>"
    echo "Operaciones válidas: + - * %"
    exit 1
fi

# Asignación de parámetros
operacion=$1
num1=$2
num2=$3

# Validación de números
if ! [[ $num1 =~ ^-?[0-9]+$ && $num2 =~ ^-?[0-9]+$ ]]; then
    echo "Error: Los operandos deben ser números enteros"
    exit 1
fi

# Calculadora
case $operacion in
    "+")
        resultado=$((num1 + num2))
        ;;
    "-")
        resultado=$((num1 - num2))
        ;;
    "*")
        resultado=$((num1 * num2))
        ;;
    "%")
        if [ $num2 -eq 0 ]; then
            echo "Error: No se puede dividir por cero"
            exit 1
        fi
        resultado=$((num1 % num2))
        ;;
    *)
        echo "Operación inválida. Se debe usar: + - * %"
        exit 1
        ;;
esac
echo "Resultado: $resultado"