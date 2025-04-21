package tp2.ejercicio7;

import tp2.ejercicio1.*;

public class ParcialArboles {

    private BinaryTree<Integer> ab;

    public ParcialArboles(BinaryTree<Integer> ab) {
        this.ab=ab;
    }

    public BinaryTree<Integer> getAb() {
        return ab;
    }

    private BinaryTree<Integer> buscarNodo(BinaryTree<Integer> ab, BinaryTree<Integer> nodo, int num) {
        if ((ab.getData()!=null) && (ab.getData()==num)) return ab;
        if (ab.hasLeftChild())                        nodo=buscarNodo(ab.getLeftChild(), nodo, num);
        if ((ab.hasRightChild()) && (nodo.isEmpty())) nodo=buscarNodo(ab.getRightChild(), nodo, num);
        return nodo;
    }

    private int contarUnicoHijo(BinaryTree<Integer> ab) {
        int cant=0;
        if ((ab.hasLeftChild() && !ab.hasRightChild()) || (!ab.hasLeftChild() && ab.hasRightChild())) cant++;
        if (ab.hasLeftChild())  cant+=contarUnicoHijo(ab.getLeftChild());
        if (ab.hasRightChild()) cant+=contarUnicoHijo(ab.getRightChild());
        return cant;
    }

    private boolean isLeftTree(BinaryTree<Integer> ab) {
        int ramaIzq=-1, ramaDer=-1;
        if (ab.hasLeftChild())  ramaIzq=contarUnicoHijo(ab.getLeftChild());
        if (ab.hasRightChild()) ramaDer=contarUnicoHijo(ab.getRightChild());
        return ramaIzq>ramaDer;
    }

    public boolean isLeftTree(int num) {
        BinaryTree<Integer> nodo=new BinaryTree();
        nodo=buscarNodo(ab, nodo, num);
        return !nodo.isEmpty() ? isLeftTree(nodo) : false;
    }

}