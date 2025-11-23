/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 1*/
/*
Escribir tres métodos de clase (static) que reciban por parámetro dos números enteros (tipo int) a y b e impriman todos los números enteros comprendidos entre a; b (inclusive), uno por cada línea en la salida estándar.
Para ello, dentro de una nueva clase, escribir un método por cada uno de los siguientes incisos:
    •	Que realice lo pedido con un for.
    •	Que realice lo pedido con un while.
    •	Que realice lo pedido sin utilizar estructuras de control iterativas (for, while, do while).
Por último, escribir, en el método de clase main, el llamado a cada uno de los métodos creados, con valores de ejemplo.
En la computadora, ejecutar el programa y verificar que se cumple con lo pedido.
*/

package tp1.ejercicio1;

import PaqueteLectura.*;

public class TP1_E1 {

    public static void main(String[] args) {

        int aMax=10;
        int a=1+GeneradorAleatorio.generarInt(aMax);
        int b=a+GeneradorAleatorio.generarInt(a);

        System.out.println("Impresión con for:");
        Imprimir.imprimirConFor(a, b);
        System.out.println("\nImpresión con while:");
        Imprimir.imprimirConWhile(a, b);
        System.out.println("\nImpresión con recursividad:");
        Imprimir.imprimirConRecursion(a, b);

    }

}