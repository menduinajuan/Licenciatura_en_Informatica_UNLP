#!/bin/bash
# Script: Ejercicio12a.sh
# Uso: ./Ejercicio12a.sh <num1> <num2>

# Solicitud de números al usuario
echo -n "Introducir primer número: "
read num1
echo -n "Introducir segundo número: "
read num2

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