/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 11*/
/*
Implementar, en la clase ParcialArboles, el método:
public static boolean resolver(GeneralTree<Integer> arbol),
que devuelve true si el árbol es creciente, falso sino lo es.
Un árbol general es creciente si, para cada nivel del árbol, la cantidad de nodos que hay en ese nivel es, exactamente, igual a la cantidad de nodos del nivel anterior + 1.
*/

package tp3.ejercicio11;

import tp3.ejercicio1.GeneralTree;

public class TP3_E11 {

    public static GeneralTree<Integer> copiarArbol(GeneralTree<Integer> ag) {
        GeneralTree<Integer> agCopia=new GeneralTree<>(ag.getData());
        for (GeneralTree<Integer> child: ag.getChildren())
            agCopia.addChild(copiarArbol(child));
        return agCopia;
    }

    public static void main(String[] args) {

        GeneralTree<Integer> ag1=new GeneralTree<>(2);
        ag1.addChild(new GeneralTree<>(1));
        ag1.addChild(new GeneralTree<>(25));
        ag1.getChildren().get(0).addChild(new GeneralTree<>(5));
        ag1.getChildren().get(0).addChild(new GeneralTree<>(4));
        ag1.getChildren().get(1).addChild(new GeneralTree<>(13));
        ag1.getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(18));
        ag1.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(7));
        ag1.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(11));
        ag1.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(3));
        ag1.getChildren().get(0).getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(83));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(33));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(12));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(17));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(9));

        GeneralTree<Integer> ag2=copiarArbol(ag1);
        GeneralTree<Integer> nodo4=ag2.getChildren().get(0).getChildren().get(1);
        GeneralTree<Integer> nodo11=nodo4.getChildren().get(1);
        nodo4.removeChild(nodo11);

        System.out.println("¿El árbol general ag1 es creciente?: " + ParcialArboles.resolver(ag1));
        System.out.println("¿El árbol general ag2 es creciente?: " + ParcialArboles.resolver(ag2));

    }

}