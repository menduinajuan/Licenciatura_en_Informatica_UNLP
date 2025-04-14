/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 2*/
/*
Agregar, a la clase BinaryTree, los siguientes métodos:
(a) contarHojas(): int Devuelve la cantidad de árbol/subárbol hojas del árbol receptor.
(b) espejo(): BinaryTree<T> Devuelve el árbol binario espejo del árbol receptor.
(c) entreNiveles(int n, m) Imprime el recorrido por niveles de los elementos del árbol receptor entre los niveles n y m (ambos inclusive). (0 ≤ n < m ≤ altura del árbol).
*/

package tp2.ejercicio2;

import PaqueteLectura.*;
import tp2.ejercicio1.*;

public class TP2_E2 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        BinaryTree<Integer> ab=new BinaryTree<>(40);
        ab.addLeftChild(new BinaryTree<>(25));
        ab.addRightChild(new BinaryTree<>(78));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(10));
        ab.getLeftChild().addRightChild(new BinaryTree<>(32));

        System.out.println("Cantidad de hojas de árbol binario ab: " + ab.contarHojas());

        System.out.print("\nImpresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);
        BinaryTree<Integer> abEspejo=ab.espejo();
        System.out.print("\nImpresión Pre-Orden del árbol binario abEspejo: ");        
        BinaryTreePrinter.imprimirPreOrden(abEspejo);

        int n=GeneradorAleatorio.generarInt(3);
        int m=n+GeneradorAleatorio.generarInt(3-n);
        System.out.println("\n\nImpresión Entre Niveles [" + n + ", " + m + "]" + " del árbol binario ab:");
        ab.entreNiveles(n, m);

    }

}