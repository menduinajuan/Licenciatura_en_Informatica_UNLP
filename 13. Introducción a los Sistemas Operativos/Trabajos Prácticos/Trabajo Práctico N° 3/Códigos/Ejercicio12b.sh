#!/bin/bash
# Script: Ejercicio12b.sh
# Uso: ./Ejercicio12b.sh <num1> <num2>

# Control de cantidad de parámetros
if [ $# -ne 2 ]; then
    echo "Error: Se deben ingresar, exactamente, 2 parámetros"
    echo "Uso: $0 <num1> <num2>"
    exit 1
fi

# Asignación de parámetros
num1=$1
num2=$2

# Operaciones aritméticas
suma=$((num1 + num2))
resta=$((num1 - num2))
multiplicacion=$((num1 * num2))

# ¿Cuál es el mayor de los números leídos?
if [ $num1 -gt $num2 ]; then
    mayor=$num1
elif [ $num1 -lt $num2 ]; then
    mayor=$num2
else
    mayor="Son iguales"
fi

# Resultados
echo "------------------------------"
echo "RESULTADOS:"
echo " - La suma es: $suma"
echo " - La resta es: $resta"
echo " - La multiplicación es: $multiplicacion"
echo " - El mayor es: $mayor"
echo "------------------------------"