/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 6*/
/*
Crear una clase Java llamada Transformacion que tenga como variable de instancia un árbol binario de números enteros y un método de instancia suma(): BinaryTree<Integer>,
el cual devuelve el árbol en el que se reemplazó el valor de cada nodo por la suma de todos los elementos presentes en su subárbol izquierdo y derecho.
Asumir que los valores de los subárboles vacíos son ceros. Por ejemplo:
¿La solución recorre una única vez cada subárbol? En el caso que no, ¿se puede mejorar para que sí lo haga?
*/

package tp2.ejercicio6;

import tp2.ejercicio1.*;

public class TP2_E6 {

    public static void main(String[] args) {

        BinaryTree<Integer> ab=new BinaryTree<>(1);
        ab.addLeftChild(new BinaryTree<>(2));
        ab.addRightChild(new BinaryTree<>(3));
        ab.getLeftChild().addRightChild(new BinaryTree<>(4));
        ab.getRightChild().addLeftChild(new BinaryTree<>(5));
        ab.getRightChild().addRightChild(new BinaryTree<>(6));
        ab.getRightChild().getLeftChild().addLeftChild(new BinaryTree<>(7));
        ab.getRightChild().getLeftChild().addRightChild(new BinaryTree<>(8));

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);

        Transformacion abTrans=new Transformacion(ab);
        abTrans.suma();
        System.out.print("\nImpresión Pre-Orden del árbol binario abTrans: ");
        BinaryTreePrinter.imprimirPreOrden(abTrans.getAb());
        System.out.println();

    }

}