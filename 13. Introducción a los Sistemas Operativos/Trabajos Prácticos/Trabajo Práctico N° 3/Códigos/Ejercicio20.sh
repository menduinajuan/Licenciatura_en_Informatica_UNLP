#!/bin/bash
# Script: Ejercicio20.sh
# Uso: ./Ejercicio20.sh

# ESTRUCTURA
pila=()

# FUNCIONES

# push: Recibe un parámetro y lo agrega a la pila
push() {
    pila+=("$1")
}

# pop: Saca un elemento de la pila
pop() {
    if [ ${#pila[@]} -eq 0 ]; then
        echo "Error: Pila vacía. No se puede hacer pop"
        return 1
    fi
    unset 'pila[-1]'
}

# length: Devuelve la longitud de la pila
length() {
    echo "${#pila[@]}"
}

# print: Imprime todos los elementos de la pila
print() {
    echo "${pila[@]}"
}

# PRUEBAS

echo "Agregando 10 elementos a la pila..."
for i in {1..10}; do
    push $i
done

echo "Sacando 3 elementos de la pila..."
for i in {1..3}; do
    pop
done

echo "Longitud de la pila: $(length)"
echo "Impresión de la totalidad de los elementos en la pila: $(print)"