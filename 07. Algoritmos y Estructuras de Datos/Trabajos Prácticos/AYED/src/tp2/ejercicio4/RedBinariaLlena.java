package tp2.ejercicio4;

import tp2.ejercicio1.*;

public class RedBinariaLlena {

    private BinaryTree<Integer> ab;

    public RedBinariaLlena(BinaryTree<Integer> ab) {
        this.ab=ab;
    }

    public int retardoReenvio() {
        return (ab!=null && !ab.isEmpty()) ? retardoReenvio(ab) : -1;
    }

    private int retardoReenvio(BinaryTree<Integer> ab) {
        int retHI=0, retHD=0;
        if (ab.hasLeftChild())  retHI=retardoReenvio(ab.getLeftChild());
        if (ab.hasRightChild()) retHD=retardoReenvio(ab.getRightChild());
        return (retHD>=retHI ? retHD : retHI) + ab.getData();
    }

}