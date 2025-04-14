package tp2.ejercicio3;

import java.util.*;
import tp2.ejercicio1.*;

public class ContadorArbol {

    BinaryTree<Integer> ab;

    public ContadorArbol(BinaryTree<Integer> ab) {
        this.ab=ab;
    }

    public List<Integer> numerosParesPre() {
        List<Integer> lista=new LinkedList<>();
        if ((ab!=null) && (!ab.isEmpty())) numerosParesPre(ab, lista);
        return lista;
    }

    private void numerosParesPre(BinaryTree<Integer> ab, List<Integer> lista) {
        if (ab.getData()%2==0)  lista.add(ab.getData());
        if (ab.hasLeftChild())  numerosParesPre(ab.getLeftChild(), lista);
        if (ab.hasRightChild()) numerosParesPre(ab.getRightChild(), lista);
    }

    public List<Integer> numerosParesIn() {
        List<Integer> lista=new LinkedList();
        if ((ab!=null) && (!ab.isEmpty())) numerosParesIn(ab, lista);
        return lista;
    }

    private void numerosParesIn(BinaryTree<Integer> ab, List<Integer> lista) {
        if (ab.hasLeftChild())  numerosParesIn(ab.getLeftChild(), lista);
        if (ab.getData()%2==0)  lista.add(ab.getData());
        if (ab.hasRightChild()) numerosParesIn(ab.getRightChild(), lista);
    }

    public List<Integer> numerosParesPost() {
        List<Integer> lista=new LinkedList();
        if ((ab!=null) && (!ab.isEmpty())) numerosParesPost(ab, lista);
        return lista;
    }

    private void numerosParesPost(BinaryTree<Integer> ab, List<Integer> lista) {
        if (ab.hasLeftChild())  numerosParesPost(ab.getLeftChild(), lista);
        if (ab.hasRightChild()) numerosParesPost(ab.getRightChild(), lista);
        if (ab.getData()%2==0)  lista.add(ab.getData());
    }

}