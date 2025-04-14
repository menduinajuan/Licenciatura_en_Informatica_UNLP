/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 9*/
/*
Implementar, en la clase ParcialArboles, el método:
public static boolean esDeSeleccion(GeneralTree<Integer> arbol),
que devuelve true si el árbol recibido por parámetro es de selección, falso sino lo es.
Un árbol general es de selección si cada nodo tiene, en su raíz, el valor del menor de sus hijos.
*/

package tp3.ejercicio9;

import tp3.ejercicio1.GeneralTree;

public class TP3_E9 {

    public static GeneralTree<Integer> copiarArbol(GeneralTree<Integer> ag) {
        GeneralTree<Integer> agCopia=new GeneralTree<>(ag.getData());
        for (GeneralTree<Integer> child: ag.getChildren())
            agCopia.addChild(copiarArbol(child));
        return agCopia;
    }

    public static void main(String[] args) {

        GeneralTree<Integer> ag1=new GeneralTree<>(12);
        ag1.addChild(new GeneralTree<>(12));
        ag1.addChild(new GeneralTree<>(25));
        ag1.getChildren().get(0).addChild(new GeneralTree<>(35));
        ag1.getChildren().get(0).addChild(new GeneralTree<>(12));
        ag1.getChildren().get(1).addChild(new GeneralTree<>(25));
        ag1.getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(35));
        ag1.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(14));
        ag1.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(12));
        ag1.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(33));
        ag1.getChildren().get(0).getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(35));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(35));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(83));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(90));
        ag1.getChildren().get(0).getChildren().get(1).getChildren().get(2).addChild(new GeneralTree<>(33));

        GeneralTree<Integer> ag2=copiarArbol(ag1);
        ag2.getChildren().get(0).getChildren().get(1).setData(18);
        ag2.getChildren().get(0).getChildren().get(1).getChildren().get(1).setData(18);

        System.out.println("¿El árbol general ag1 es de selección?: " + ParcialArboles.esDeSeleccion(ag1));
        System.out.println("¿El árbol general ag1 es de selección?: " + ParcialArboles.esDeSeleccion(ag2));

    }

}