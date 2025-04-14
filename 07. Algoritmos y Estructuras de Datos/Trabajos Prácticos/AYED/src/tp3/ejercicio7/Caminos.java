package tp3.ejercicio7;

import java.util.*;
import tp3.ejercicio1.GeneralTree;

public class Caminos {

    private GeneralTree<Integer> ag;

    public Caminos(GeneralTree<Integer> ag) {
        this.ag=ag;
    }

    public List<Integer> caminoAHojaMasLejana() {
        List<Integer> lista=new LinkedList<>();
        if ((ag!=null) && (!ag.isEmpty())) caminoAHojaMasLejana(ag, new LinkedList<>(), lista);
        return lista;
    }

    private void caminoAHojaMasLejana(GeneralTree<Integer> nodo, List<Integer> caminoActual, List<Integer> caminoMasLargo) {
        caminoActual.add(nodo.getData());
        if (!nodo.isLeaf())
            for (GeneralTree<Integer> child: nodo.getChildren())
                caminoAHojaMasLejana(child, caminoActual, caminoMasLargo);
        else if (caminoActual.size()>caminoMasLargo.size()) {
                caminoMasLargo.clear();
                caminoMasLargo.addAll(caminoActual);
        }
        caminoActual.remove(caminoActual.size()-1);
    }

}