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
        int sum=0;
        if (ab.isLeaf()) {
            sum=ab.getData();
            ab.setData(0);
            return sum;
        }
        if (ab.hasLeftChild())  sum+=suma(ab.getLeftChild());
        if (ab.hasRightChild()) sum+=suma(ab.getRightChild());
        int actual=ab.getData();
        ab.setData(sum);
        return actual+sum;
    }

}