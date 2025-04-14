/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 8*/
/*
Escribir, en una clase ParcialArboles, el método público con la siguiente firma:
public boolean esPrefijo(BinaryTree<Integer> arbol1, BinaryTree<Integer> arbol2).
El método devuelve true si arbol1 es prefijo de arbol2, false en caso contrario.
Se dice que un árbol binario arbol1 es prefijo de otro árbol binario arbol2 cuando arbol1 coincide con la parte inicial del árbol arbol2 tanto en el contenido de los elementos como en su estructura.
*/

package tp2.ejercicio8;

import tp2.ejercicio1.*;

public class TP2_E8 {

    public static void main(String[] args) {

        BinaryTree<Integer> ab=new BinaryTree<>(1);
        ab.addLeftChild(new BinaryTree<>(2));
        ab.addRightChild(new BinaryTree<>(3));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(4));
        ab.getLeftChild().addRightChild(new BinaryTree<>(5));
        ab.getRightChild().addLeftChild(new BinaryTree<>(6));
        ab.getRightChild().addRightChild(new BinaryTree<>(7));

        BinaryTree<Integer> ab1=new BinaryTree<>(1);
        ab1.addLeftChild(new BinaryTree<>(2));
        ab1.addRightChild(new BinaryTree<>(3));
        ab1.getLeftChild().addLeftChild(new BinaryTree<>(4));
        ab1.getLeftChild().addRightChild(new BinaryTree<>(5));

        BinaryTree<Integer> ab2=new BinaryTree<>(1);
        ab2.addLeftChild(new BinaryTree<>(2));
        ab2.addRightChild(new BinaryTree<>(3));
        ab2.getLeftChild().addLeftChild(new BinaryTree<>(4));
        ab2.getLeftChild().addRightChild(new BinaryTree<>(0));

        BinaryTree<Integer> ab3=new BinaryTree<>();
        BinaryTree<Integer> ab4=new BinaryTree<>(1);
        BinaryTree<Integer> ab5=null;

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);
        System.out.print("\nImpresión Pre-Orden del árbol binario ab1: ");
        BinaryTreePrinter.imprimirPreOrden(ab1);
        System.out.print("\nImpresión Pre-Orden del árbol binario ab2: ");
        BinaryTreePrinter.imprimirPreOrden(ab2);
        System.out.println("\n");

        ParcialArboles abParcial=new ParcialArboles();
        System.out.println("¿El árbol binario ab1 es prefijo del árbol binario ab?: " + abParcial.esPrefijo(ab1, ab));
        System.out.println("¿El árbol binario ab2 es prefijo del árbol binario ab?: " + abParcial.esPrefijo(ab2, ab));
        System.out.println("¿El árbol binario ab3 es prefijo del árbol binario ab3?: " + abParcial.esPrefijo(ab3, ab3));
        System.out.println("¿El árbol binario ab4 es prefijo del árbol binario ab3?: " + abParcial.esPrefijo(ab4, ab3));
        System.out.println("¿El árbol binario ab3 es prefijo del árbol binario ab4?: " + abParcial.esPrefijo(ab3, ab4));
        System.out.println("¿El árbol binario ab4 es prefijo del árbol binario ab5?: " + abParcial.esPrefijo(ab4, ab5));
        System.out.println("¿El árbol binario ab5 es prefijo del árbol binario ab4?: " + abParcial.esPrefijo(ab5, ab4));
        System.out.println("¿El árbol binario ab5 es prefijo del árbol binario ab5?: " + abParcial.esPrefijo(ab5, ab5));

    }

}