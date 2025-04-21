package tp2.ejercicio5;

import tp2.ejercicio1.*;

public class ProfundidadDeArbolBinario {

    private BinaryTree<Integer> ab;

    public ProfundidadDeArbolBinario(BinaryTree<Integer> ab) {
        this.ab=ab;
    }

    public int sumaElementosProfundidad(int p) {
        return (ab!=null && !ab.isEmpty()) ? sumaElementosProfundidad(p, ab, 0) : -1;
    }

    private int sumaElementosProfundidad(int p, BinaryTree<Integer> ab, int nivelActual) {
        if (p==nivelActual) {
            if (ab.getData()!=null) return ab.getData();
            return 0;
        }
        int suma=0;
        if (ab.hasLeftChild())  suma+=sumaElementosProfundidad(p, ab.getLeftChild(), nivelActual+1);
        if (ab.hasRightChild()) suma+=sumaElementosProfundidad(p, ab.getRightChild(), nivelActual+1);
        return suma;
    }

}