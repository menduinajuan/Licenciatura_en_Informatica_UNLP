package tp3.ejercicio8;

import tp3.ejercicio1.GeneralTree;

public class Navidad {

    private GeneralTree<Integer> ag;

    public Navidad(GeneralTree<Integer> ag) {
        this.ag=ag;
    }

    public String esAbetoNavidenio() {
        if ((ag==null) || (ag.isEmpty())) return "Null o Vacío";
        return esAbetoNavidenio(ag) ? "Yes" : "No";
    }

    private boolean esAbetoNavidenio(GeneralTree<Integer> ag) {
        int nodos=0;
        for (GeneralTree<Integer> child: ag.getChildren())
            if (child.isLeaf()) nodos++;
            else if (!esAbetoNavidenio(child)) return false;
        return nodos>=3;
    }

}