package tp3.ejercicio4;

import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class AnalizadorArbol {

    public double devolverMaximoPromedio(GeneralTree<AreaEmpresa> arbol) {
        if ((arbol==null) || (arbol.isEmpty())) return -1;
        return !arbol.isLeaf() ? devolverMaximoPromedioHelper(arbol) : arbol.getData().getTardanza();
    }

    private double devolverMaximoPromedioHelper(GeneralTree<AreaEmpresa> arbol) {
        double promActual=0, promMax=-1;
        int nodosActual=0;
        GeneralTree<AreaEmpresa> ag;
        Queue<GeneralTree<AreaEmpresa>> cola=new Queue<>();
        cola.enqueue(arbol);
        cola.enqueue(null);
        while (!cola.isEmpty()) {
            ag=cola.dequeue();
            if (ag!=null) {
                promActual+=ag.getData().getTardanza();
                nodosActual++;
                for (GeneralTree<AreaEmpresa> child: ag.getChildren())
                    cola.enqueue(child);
            }
            else if (!cola.isEmpty()) {
                promActual=promActual/nodosActual;
                promMax=Math.max(promMax, promActual);
                promActual=0; nodosActual=0;
                cola.enqueue(null);
            }
        }
        return promMax;
    }

}