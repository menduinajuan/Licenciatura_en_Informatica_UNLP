/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 3*/
/*
Definir una clase Java denominada ContadorArbol cuya función principal es proveer métodos de validación sobre árboles binarios de enteros.
Para ello, la clase tiene como variable de instancia un BinaryTree<Integer>.
Implementar, en dicha clase, un método denominado numerosPares() que devuelve, en una estructura adecuada (sin ningún criterio de orden), todos los elementos pares del árbol (divisibles por 2).
(a) Implementar el método realizando un recorrido InOrden.
(b) Implementar el método realizando un recorrido PostOrden.
*/

package tp2.ejercicio3;

import tp2.ejercicio1.*;

public class TP2_E3 {

    public static void main(String[] args) {
    
        BinaryTree<Integer> ab=new BinaryTree<>(40);
        ab.addLeftChild(new BinaryTree<>(25));
        ab.addRightChild(new BinaryTree<>(78));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(10));
        ab.getLeftChild().addRightChild(new BinaryTree<>(32));

        ContadorArbol abContador=new ContadorArbol(ab);

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);
        System.out.println("\nImpresión Pre-Orden de los nodos pares del árbol ab: " + abContador.numerosParesPre());

        System.out.print("\nImpresión In-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirInOrden(ab);
        System.out.println("\nImpresión In-Orden de los nodos pares del árbol ab: " + abContador.numerosParesIn());

        System.out.print("\nImpresión Post-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPostOrden(ab);
        System.out.println("\nImpresión Post-Orden de los nodos pares del árbol ab: " + abContador.numerosParesPost());

    }

}
