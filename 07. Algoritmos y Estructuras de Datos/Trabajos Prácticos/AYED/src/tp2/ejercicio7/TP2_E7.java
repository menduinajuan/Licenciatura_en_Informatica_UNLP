/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 7*/
/*
Escribir una clase ParcialArboles que contenga UNA ÚNICA variable de instancia de tipo BinaryTree de valores enteros NO repetidos y el método público con la siguiente firma:
public boolean isLeftTree(int num).
El método devuelve true si el subárbol cuya raíz es “num” tiene, en su subárbol izquierdo, una cantidad mayor estricta de árboles con un único hijo que en su subárbol derecho. Y false en caso contrario.
Consideraciones:
•	Si “num” no se encuentra en el árbol, devuelve false.
•	Si el árbol con raíz “num” no cuenta con una de sus ramas, considerar que, en esa rama, hay -1 árboles con único hijo.
*/

package tp2.ejercicio7;

import tp2.ejercicio1.*;

public class TP2_E7 {

    public static void main(String[] args) {

        BinaryTree<Integer> ab=new BinaryTree<>(2);
        ab.addLeftChild(new BinaryTree<>(7));
        ab.addRightChild(new BinaryTree<>(-5));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(23));
        ab.getLeftChild().addRightChild(new BinaryTree<>(6));
        ab.getRightChild().addLeftChild(new BinaryTree<>(19));
        ab.getLeftChild().getLeftChild().addLeftChild(new BinaryTree<>(-3));
        ab.getLeftChild().getRightChild().addLeftChild(new BinaryTree<>(55));
        ab.getLeftChild().getRightChild().addRightChild(new BinaryTree<>(11));
        ab.getRightChild().getLeftChild().addRightChild(new BinaryTree<>(4));
        ab.getRightChild().getLeftChild().getRightChild().addLeftChild(new BinaryTree<>(18));

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);
        System.out.println("\n");

        ParcialArboles abParcial=new ParcialArboles(ab);
        int[] vectorNums={7, 2, -5, 19, -3};
        for (int i: vectorNums)
            System.out.println("Resultado para num " + i + ": " + abParcial.isLeftTree(i));

    }

}