/*TRABAJO PRÁCTICO N° 2*/
/*EJERCICIO 1*/
/*
Considerar la siguiente especificación de la clase Java BinaryTree (con la representación hijo izquierdo e hijo derecho).
•	El constructor BinaryTree(T data) inicializa un árbol con el dato pasado como parámetro y ambos hijos nulos.
•	Los métodos getLeftChild():BinaryTree<T> y getRightChild():BinaryTree<T> retornan los hijos izquierdo y derecho, respectivamente, del árbol. Si no tiene el hijo, tira error.
•	El método addLeftChild(BinaryTree<T> child) y addRightChild(BinaryTree<T> child) agrega un hijo como hijo izquierdo o derecho del árbol.
•	El método removeLeftChild() y removeRightChild() eliminan el hijo correspondiente.
•	El método isEmpty() indica si el árbol está vacío y el método isLeaf() indica si no tiene hijos.
•	El método hasLeftChild() y hasRightChild() devuelve un booleano indicando si tiene dicho hijo el árbol receptor del mensaje.
Analizar la implementación en JAVA de la clase BinaryTree brindada por la cátedra.
*/

package tp2.ejercicio1;

public class TP2_E1 {

    public static void main(String[] args) {
    
        BinaryTree<Integer> ab=new BinaryTree<>(40);
        ab.addLeftChild(new BinaryTree<>(25));
        ab.addRightChild(new BinaryTree<>(78));
        ab.getLeftChild().addLeftChild(new BinaryTree<>(10));
        ab.getLeftChild().addRightChild(new BinaryTree<>(32));

        System.out.print("Impresión Pre-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPreOrden(ab);
        System.out.print("\nImpresión In-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirInOrden(ab);
        System.out.print("\nImpresión Post-Orden del árbol binario ab: ");
        BinaryTreePrinter.imprimirPostOrden(ab);
        System.out.println("\nImpresión Por Niveles del árbol binario ab: ");
        BinaryTreePrinter.imprimirPorNiveles(ab);

    }

}