/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 5*/
/*
Implementar una clase Java llamada ProfundidadDeArbolBinario que tiene, como variable de instancia,
un árbol binario de números enteros y un método de instancia sumaElementosProfundidad(int p): int,
el cuál devuelve la suma de todos los nodos del árbol que se encuentren a la profundidad pasada como argumento.
*/

package tp2.ejercicio5;

import PaqueteLectura.*;
import tp2.ejercicio1.*;

public class TP2_E5 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        BinaryTree<Integer> ab=new BinaryTree<>(1);
        ab.addLeftChild(new BinaryTree<>(2));
        ab.addRightChild(new BinaryTree<>(3));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(4));
        ab.getLeftChild().addRightChild(new BinaryTree<>(5));
        ab.getRightChild().addLeftChild(new BinaryTree<>(6));
        ab.getRightChild().addRightChild(new BinaryTree<>(7));

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);

        ProfundidadDeArbolBinario abProf=new ProfundidadDeArbolBinario(ab);
        int p=GeneradorAleatorio.generarInt(3);
        System.out.println("\nLa suma de todos los nodos del árbol binario ab que se encuentran a la profundidad " + p + " es " + abProf.sumaElementosProfundidad(p));

    }

}