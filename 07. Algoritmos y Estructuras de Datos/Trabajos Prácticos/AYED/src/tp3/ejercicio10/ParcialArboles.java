package tp3.ejercicio10;

import java.util.*;
import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {

    public static List<Integer> resolver(GeneralTree<Integer> arbol) {
        List<Integer> lista=new LinkedList<>();
        if ((arbol!=null) && (!arbol.isEmpty())) {
            Maximo sumaMax=new Maximo(-1);
            resolver(arbol, new LinkedList<>(), lista, 0, sumaMax, 0);
        }
        return lista;
    }

    private static void resolver(GeneralTree<Integer> arbol, List<Integer> caminoActual, List<Integer> caminoMax, int sumaActual, Maximo sumaMax, int nivel) {
        int dato=arbol.getData();
        boolean ok=(dato==1);
        if (ok) {
            sumaActual+=dato*nivel;
            caminoActual.add(dato);
        }
        if (!arbol.isLeaf())
            for (GeneralTree<Integer> child: arbol.getChildren())
                resolver(child, caminoActual, caminoMax, sumaActual, sumaMax, nivel+1);
        else if (sumaActual>sumaMax.getMax()) {
            sumaMax.setMax(sumaActual);
            sumaActual=0;
            caminoMax.clear();
            caminoMax.addAll(caminoActual);
        }
        if (ok) caminoActual.remove(caminoActual.size()-1);
    }

}