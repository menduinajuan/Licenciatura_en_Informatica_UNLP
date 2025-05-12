package tp3.ejercicio10;

import java.util.*;
import tp3.ejercicio1.GeneralTree;

public class ParcialArboles {

    public static List<Integer> resolver(GeneralTree<Integer> arbol) {
        List<Integer> lista=new LinkedList<>();
        if ((arbol!=null) && (!arbol.isEmpty())) resolver(arbol, new LinkedList<>(), lista, 0, new Maximo(Integer.MIN_VALUE), 0);
        return lista;
    }

    private static void resolver(GeneralTree<Integer> arbol, List<Integer> caminoActual, List<Integer> caminoMax, int sumaActual, Maximo sumaMax, int nivel) {
        int num=0;
        if (arbol.getData()!=null) num=arbol.getData();
        boolean ok=(num==1);
        if (ok) {
            sumaActual+=num*nivel;
            caminoActual.add(num);
        }
        if (arbol.isLeaf()) {
            if (sumaActual>sumaMax.getMax()) {
                sumaMax.setMax(sumaActual);
                sumaActual=0;
                caminoMax.clear();
                caminoMax.addAll(caminoActual);
            }
        }
        else
            for (GeneralTree<Integer> child: arbol.getChildren())
                resolver(child, caminoActual, caminoMax, sumaActual, sumaMax, nivel+1);
        if (ok) caminoActual.remove(caminoActual.size()-1);
    }

}