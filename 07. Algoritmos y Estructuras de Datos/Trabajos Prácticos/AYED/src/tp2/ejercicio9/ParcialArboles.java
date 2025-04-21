package tp2.ejercicio9;

import tp2.ejercicio1.*;

public class ParcialArboles {

    public BinaryTree<SumDif> sumAndDif(BinaryTree<Integer> arbol) {
        BinaryTree<SumDif> abSaD=new BinaryTree<>();
        if ((arbol!=null) && (!arbol.isEmpty())) sumAndDif(arbol, abSaD, 0, 0);
        return abSaD;
    }

    private void sumAndDif(BinaryTree<Integer> arbol, BinaryTree<SumDif> abSaD, int suma, int padre) {
        int num=0;
        if (arbol.getData()!=null) num=arbol.getData();
        abSaD.setData(new SumDif(num+suma, num-padre));
        if (arbol.hasLeftChild()) {
            abSaD.addLeftChild(new BinaryTree<>());
            sumAndDif(arbol.getLeftChild(), abSaD.getLeftChild(), num+suma, num);
        }
        if (arbol.hasRightChild()) {
            abSaD.addRightChild(new BinaryTree<>());
            sumAndDif(arbol.getRightChild(), abSaD.getRightChild(), num+suma, num);
        }
    }

}