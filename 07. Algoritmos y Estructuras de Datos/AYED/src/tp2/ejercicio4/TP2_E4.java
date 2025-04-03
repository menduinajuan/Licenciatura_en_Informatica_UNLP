/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 4*/
/*
Una red binaria es una red que posee una topología de árbol binario lleno. Por ejemplo:
Los nodos que conforman una red binaria llena tienen la particularidad de que todos ellos conocen cuál es su retardo de reenvío.
El retardo de reenvío se define como el período comprendido entre que un nodo recibe un mensaje y lo reenvía a sus dos hijos.
La tarea es calcular el mayor retardo posible, en el camino que realiza un mensaje desde la raíz hasta llegar a las hojas en una red binaria llena.
En el ejemplo, se debería retornar 10 + 3 + 9 + 12= 34 (si hay más de un máximo, retornar el último valor hallado).
Nota: Asumir que cada nodo tiene el dato de retardo de reenvío expresado en cantidad de segundos.
(a) Indicar qué estrategia (recorrido en profundidad o por niveles) se utilizará para resolver el problema.
(b) Crear una clase Java llamada RedBinariaLlena donde se implementará lo solicitado en el método retardoReenvio(): int.
*/

package tp2.ejercicio4;

import tp2.ejercicio1.*;

public class TP2_E4 {

    public static void main(String[] args) {

        BinaryTree<Integer> ab=new BinaryTree(1);
        ab.addLeftChild(new BinaryTree(2));
        ab.addRightChild(new BinaryTree(3));
        ab.getLeftChild().addLeftChild(new BinaryTree(4));
        ab.getLeftChild().addRightChild(new BinaryTree(5));
        ab.getRightChild().addLeftChild(new BinaryTree(4));
        ab.getRightChild().addRightChild(new BinaryTree(5));

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);

        RedBinariaLlena red=new RedBinariaLlena(ab);
        System.out.println("\nEl mayor retardo posible del árbol binario ab es " + red.retardoReenvio() + " segundos");

    }

}
