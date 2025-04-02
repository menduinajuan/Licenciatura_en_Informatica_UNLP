package tp2.ejercicio3;

import java.util.*;
import tp2.ejercicio1.*;

public class ContadorArbol {

    BinaryTree<Integer> ab;

    public ContadorArbol(BinaryTree<Integer> ab) {
        this.ab=ab;
    }

    public List<Integer> numerosParesPre() {
        List<Integer> lista=new LinkedList();
        if (!ab.isEmpty()) numerosParesPre(lista, ab);
        return lista;
    }

    private void numerosParesPre(List<Integer> lista, BinaryTree<Integer> ab) {
        if (ab.getData()%2==0)  lista.add(ab.getData());
        if (ab.hasLeftChild())  numerosParesPre(lista, ab.getLeftChild());
        if (ab.hasRightChild()) numerosParesPre(lista, ab.getRightChild());
    }

    public List<Integer> numerosParesIn() {
        List<Integer> lista=new LinkedList();
        if (!ab.isEmpty()) numerosParesIn(lista, ab);
        return lista;
    }

    private void numerosParesIn(List<Integer> lista, BinaryTree<Integer> ab) {
        if (ab.hasLeftChild())  numerosParesIn(lista, ab.getLeftChild());
        if (ab.getData()%2==0)  lista.add(ab.getData());
        if (ab.hasRightChild()) numerosParesIn(lista, ab.getRightChild());
    }

    public List<Integer> numerosParesPost() {
        List<Integer> lista=new LinkedList();
        if (!ab.isEmpty()) numerosParesPost(lista, ab);
        return lista;
    }

    private void numerosParesPost(List<Integer> lista, BinaryTree<Integer> ab) {
        if (ab.hasLeftChild())  numerosParesPost(lista, ab.getLeftChild());
        if (ab.hasRightChild()) numerosParesPost(lista, ab.getRightChild());
        if (ab.getData()%2==0)  lista.add(ab.getData());
    }

}