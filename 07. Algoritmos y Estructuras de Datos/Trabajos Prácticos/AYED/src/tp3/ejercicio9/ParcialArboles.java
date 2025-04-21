package tp3.ejercicio9;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {

    public static boolean esDeSeleccion(GeneralTree<Integer> arbol) {
        boolean ok=true;
        GeneralTree<Integer> ag;
        Queue<GeneralTree<Integer>> cola=new Queue<>();
        if (!arbol.isEmpty()) {
            cola.enqueue(arbol);
            while ((!cola.isEmpty()) && (ok)) {
                ag=cola.dequeue();
                int min=Integer.MAX_VALUE;
                for (GeneralTree<Integer> child: ag.getChildren()) {
                    cola.enqueue(child);
                    if (child.getData()!=null) min=Math.min(min, child.getData());
                }
                if ((!ag.isLeaf()) && ((ag.getData()==null) || (ag.getData()!=min))) ok=false;
            }
        }
        return ok;
    }

}