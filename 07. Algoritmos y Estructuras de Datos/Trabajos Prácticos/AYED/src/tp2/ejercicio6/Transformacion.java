package tp2.ejercicio6;

import tp2.ejercicio1.*;

public class Transformacion {

    private BinaryTree<Integer> ab;

    public Transformacion(BinaryTree<Integer> ab) {
        this.ab=ab;
    }

    public BinaryTree<Integer> getAb() {
        return ab;
    }

    public BinaryTree<Integer> suma() {
        if ((ab!=null) && (!ab.isEmpty())) suma(ab);
        return ab;
    }

    private int suma(BinaryTree<Integer> ab) {
        int actual=0;
        if (ab.getData()!=null) actual=ab.getData();
        if (ab.isLeaf()) {
            ab.setData(0);
            return actual;
        }
        int suma=0;
        if (ab.hasLeftChild())  suma+=suma(ab.getLeftChild());
        if (ab.hasRightChild()) suma+=suma(ab.getRightChild());
        ab.setData(suma);
        return actual+suma;
    }

}