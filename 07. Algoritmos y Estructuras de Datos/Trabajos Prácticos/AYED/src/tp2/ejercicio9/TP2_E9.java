/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 9*/
/*
Escribir, en una clase ParcialArboles, el método público con la siguiente firma:
public BinaryTree<?> sumAndDif(BinaryTree<Integer> arbol).
El método recibe un árbol binario de enteros y devuelve un nuevo árbol que contiene, en cada nodo, dos tipos de información:
    •	La suma de los números a lo largo del camino desde la raíz hasta el nodo actual.
    •	La diferencia entre el número almacenado en el nodo original y el número almacenado en el nodo padre.
NOTA: En el nodo raíz, considerar que el valor del nodo padre es 0.
*/

package tp2.ejercicio9;

import tp2.ejercicio1.*;

public class TP2_E9 {

    public static void main(String[] args) {

        BinaryTree<Integer> ab=new BinaryTree<>(20);
        ab.addLeftChild(new BinaryTree<>(5));
        ab.addRightChild(new BinaryTree<>(30));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(-5));
        ab.getLeftChild().addRightChild(new BinaryTree<>(10));
        ab.getRightChild().addLeftChild(new BinaryTree<>(50));
        ab.getRightChild().addRightChild(new BinaryTree<>(-9));
        ab.getLeftChild().getRightChild().addLeftChild(new BinaryTree<>(1));
        ab.getRightChild().getLeftChild().addRightChild(new BinaryTree<>(4));
        ab.getRightChild().getLeftChild().getRightChild().addRightChild(new BinaryTree<>(6));

        ParcialArboles abParcial=new ParcialArboles();
        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);
        System.out.print("\nImpresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(abParcial.sumAndDif(ab));
        System.out.println();

    }

}