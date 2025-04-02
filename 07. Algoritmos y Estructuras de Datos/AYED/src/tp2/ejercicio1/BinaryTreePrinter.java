package tp2.ejercicio1;

import tp1.ejercicio8.Queue;

public class BinaryTreePrinter {

    public static<T> void imprimirPreOrden(BinaryTree<T> ab) {
        System.out.print(ab.getData() + " ");
        if (ab.hasLeftChild())  imprimirPreOrden(ab.getLeftChild());
        if (ab.hasRightChild()) imprimirPreOrden(ab.getRightChild());
    }

    public static<T> void imprimirInOrden(BinaryTree<T> ab) {
        if (ab.hasLeftChild())  imprimirInOrden(ab.getLeftChild());
        System.out.print(ab.getData() + " ");
        if (ab.hasRightChild()) imprimirInOrden(ab.getRightChild());
    }

    public static<T> void imprimirPostOrden(BinaryTree<T> ab) {
        if (ab.hasLeftChild())  imprimirPostOrden(ab.getLeftChild());
        if (ab.hasRightChild()) imprimirPostOrden(ab.getRightChild());
        System.out.print(ab.getData() + " ");
    }

    public static<T> void imprimirPorNiveles(BinaryTree<T> arbol) {

        if (arbol.isEmpty()) {
            System.out.println("Árbol vacío");
            return;
        }
        
        Queue<BinaryTree<T>> cola=new Queue();
        cola.enqueue(arbol);
        cola.enqueue(null);
        int nivelActual=0;

        while (!cola.isEmpty()) {
            BinaryTree<T> ab=cola.dequeue();
            if (ab!=null) {
                System.out.print(ab.getData() + " ");
                if (ab.hasLeftChild())
                    cola.enqueue(ab.getLeftChild());
                if (ab.hasRightChild())
                    cola.enqueue(ab.getRightChild());
            }
            else {
                System.out.print("- Nivel " + (nivelActual++));
                if (!cola.isEmpty()) {
                    System.out.println();
                    cola.enqueue(null);
                }
            }
        }

        System.out.println();

    }

}