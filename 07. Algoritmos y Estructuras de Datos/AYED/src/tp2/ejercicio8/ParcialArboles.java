package tp2.ejercicio8;

import tp2.ejercicio1.*;

public class ParcialArboles {

    public boolean esPrefijo(BinaryTree<Integer> arbol1, BinaryTree<Integer> arbol2){
        if (arbol1.isEmpty() || arbol2.isEmpty()) return arbol1.isEmpty() && arbol2.isEmpty();
        return esPrefijoRec(arbol1, arbol2);
    }
    
    private boolean esPrefijoRec(BinaryTree<Integer> arbol1, BinaryTree<Integer> arbol2) {
        if (arbol1.getData()!=arbol2.getData()) return false;
        boolean ok=true;
        if (arbol1.hasLeftChild())
            if (arbol2.hasLeftChild())
                ok=ok && esPrefijoRec(arbol1.getLeftChild(), arbol2.getLeftChild());
            else
                return false;
        if (arbol1.hasRightChild())
            if(arbol2.hasRightChild())
                ok=ok && esPrefijoRec(arbol1.getRightChild(), arbol2.getRightChild()); 
            else
                return false;
        return ok;
    }

}