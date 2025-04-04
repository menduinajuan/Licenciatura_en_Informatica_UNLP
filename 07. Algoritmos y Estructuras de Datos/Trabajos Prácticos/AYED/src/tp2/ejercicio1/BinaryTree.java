package tp2.ejercicio1;

import java.util.*;
//import tp1.ejercicio8.Queue;

public class BinaryTree<T> {

    private T data;
    private BinaryTree<T> leftChild;   
    private BinaryTree<T> rightChild; 

    public BinaryTree() {
        super();
    }

    public BinaryTree(T data) {
        this.data=data;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data=data;
    }

    // Preguntar antes de invocar si hasLeftChild()
    public BinaryTree<T> getLeftChild() {
        return leftChild;
    }

    // Preguntar antes de invocar si hasRightChild()
    public BinaryTree<T> getRightChild() {
        return this.rightChild;
    }

    public void addLeftChild(BinaryTree<T> child) {
        this.leftChild=child;
    }

    public void addRightChild(BinaryTree<T> child) {
        this.rightChild=child;
    }

    public void removeLeftChild() {
        this.leftChild=null;
    }

    public void removeRightChild() {
        this.rightChild=null;
    }

    public boolean isEmpty(){
        return this.isLeaf() && this.getData()==null;
    }

    public boolean isLeaf() {
        return !this.hasLeftChild() && !this.hasRightChild();
    }

    public boolean hasLeftChild() {
        return this.leftChild!=null;
    }

    public boolean hasRightChild() {
        return this.rightChild!=null;
    }

    @Override
    public String toString() {
        return this.getData().toString();
    }

    public int contarHojas() {
        int leftC=0, rightC=0;
        if (this.isEmpty())     return 0;
        else if (this.isLeaf()) return 1;
        else {
            if (this.hasLeftChild())  leftC=this.getLeftChild().contarHojas();
            if (this.hasRightChild()) rightC=this.getRightChild().contarHojas();
            return leftC+rightC;
        }
    }

    public BinaryTree<T> espejo(){
        BinaryTree<T> abEspejo=new BinaryTree<>(this.getData());
        if (this.hasLeftChild())  abEspejo.addRightChild(this.getLeftChild().espejo());
        if (this.hasRightChild()) abEspejo.addLeftChild(this.getRightChild().espejo());
        return abEspejo;
    }

    public void entreNiveles(int n, int m) {

        if ((this.isEmpty()) || (n<0) || (m<n)) {
            System.out.println("Niveles inválidos");
            return;
        }

        BinaryTree<T> ab=null;
        Queue<BinaryTree<T>> cola=new LinkedList<>();
        cola.offer(this);
        cola.offer(null);
        int nivelActual=0;

        while ((!cola.isEmpty()) && (nivelActual<=m)) {
            ab=cola.poll();
            if (ab!=null) {
                if ((nivelActual>=n) && (nivelActual<=m))
                    System.out.print(ab.getData() + " ");
                if (ab.hasLeftChild())
                    cola.offer(ab.getLeftChild());
                if (ab.hasRightChild())
                    cola.offer(ab.getRightChild());
            }
            else {
                System.out.print("- Nivel " + (nivelActual++));
                if ((!cola.isEmpty()) && (nivelActual<=m)) {
                    System.out.println();
                    cola.offer(null);
                }
            }
        }

        System.out.println();

    }

    /*
    public void entreNiveles(int n, int m) {

        if ((this.isEmpty()) || (n<0) || (m<n)) {
            System.out.println("Niveles inválidos");
            return;
        }

        BinaryTree<T> ab=null;
        Queue<BinaryTree<T>> cola=new Queue<>();
        cola.enqueue(this);
        cola.enqueue(null);
        int nivelActual=0;

        while ((!cola.isEmpty()) && (nivelActual<=m)) {
            ab=cola.dequeue();
            if (ab!=null) {
                if ((nivelActual>=n) && (nivelActual<=m))
                    System.out.print(ab.getData() + " ");
                if (ab.hasLeftChild())
                    cola.enqueue(ab.getLeftChild());
                if (ab.hasRightChild())
                    cola.enqueue(ab.getRightChild());
            }
            else {
                System.out.print("- Nivel " + (nivelActual++));
                if ((!cola.isEmpty()) && (nivelActual<=m)) {
                    System.out.println();
                    cola.enqueue(null);
                }
            }
        }

        System.out.println();

    }
    */

}