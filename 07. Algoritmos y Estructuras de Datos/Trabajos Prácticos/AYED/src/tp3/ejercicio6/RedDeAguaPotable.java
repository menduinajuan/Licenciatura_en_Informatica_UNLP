package tp3.ejercicio6;

import tp3.ejercicio1.GeneralTree;

public class RedDeAguaPotable {

    private GeneralTree<Character> ag;

    public RedDeAguaPotable(GeneralTree<Character> ag) {
        this.ag=ag;
    }

    public double minimoCaudal(double caudal) {
        if ((ag==null) || (ag.isEmpty())) return -1;
        return !ag.isLeaf() ? minimoCaudal(ag, caudal) : caudal;
    }

    private double minimoCaudal(GeneralTree<Character> ag, double caudal) {
        if (ag.isLeaf()) return caudal;
        caudal=caudal/ag.getChildren().size();
        double caudalMin=Double.MAX_VALUE;
        for (GeneralTree<Character> child: ag.getChildren())
            caudalMin=Math.min(caudalMin, minimoCaudal(child, caudal));
        return caudalMin;
    }

}