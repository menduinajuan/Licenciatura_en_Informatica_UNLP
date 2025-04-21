package tp3.ejercicio11;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {

    public static boolean resolver(GeneralTree<Integer> arbol) {
        if ((arbol==null) || (arbol.isEmpty())) return false;
        return !arbol.isLeaf() ? resolverHelper(arbol) : true;
    }

    private static boolean resolverHelper(GeneralTree<Integer> arbol){
        int nodosActual;
        int nodosAnterior=0;
        GeneralTree<Integer> ag;
        Queue<GeneralTree<Integer>> cola=new Queue<>();
        cola.enqueue(arbol);
        while (!cola.isEmpty()) {
            nodosActual=cola.size();
            if (nodosActual!=nodosAnterior+1)
                return false;
            else
                for (int i=0; i<nodosActual; i++) {
                    ag=cola.dequeue();
                    for (GeneralTree<Integer> child: ag.getChildren())
                        cola.enqueue(child);
                }
            nodosAnterior=nodosActual;
        }
        return true;
    }

}