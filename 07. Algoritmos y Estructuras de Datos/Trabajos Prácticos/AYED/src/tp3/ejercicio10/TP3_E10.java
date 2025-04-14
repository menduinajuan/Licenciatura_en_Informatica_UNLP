/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 10*/
/*
Implementar la clase ParcialArboles y el método:
public static List<Integer> resolver(GeneralTree<Integer> arbol),
que recibe un árbol general de valores enteros, que sólo pueden ser 0 o 1,
y devuelve una lista con los valores que componen el “camino filtrado de valor máximo”.
Se llama “filtrado” porque sólo se agregan al camino los valores iguales a 1 (los 0 no se agregan),
mientras que es “de valor máximo” porque se obtiene de realizar el siguiente cálculo:
es la suma de los valores de los nodos multiplicados por su nivel.
De haber más de uno, devolver el primero que se encuentre.
*/

package tp3.ejercicio10;

import tp3.ejercicio1.GeneralTree;

public class TP3_E10 {

    public static void main(String[] args) {

        GeneralTree<Integer> ag=new GeneralTree<>(1);
        ag.addChild(new GeneralTree<>(0));
        ag.addChild(new GeneralTree<>(1));
        ag.addChild(new GeneralTree<>(1));
        ag.getChildren().get(0).addChild(new GeneralTree<>(1));
        ag.getChildren().get(0).addChild(new GeneralTree<>(1));
        ag.getChildren().get(1).addChild(new GeneralTree<>(1));
        ag.getChildren().get(1).addChild(new GeneralTree<>(0));
        ag.getChildren().get(2).addChild(new GeneralTree<>(0));
        ag.getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(1));
        ag.getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(1));
        ag.getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(1));
        ag.getChildren().get(1).getChildren().get(1).addChild(new GeneralTree<>(0));
        ag.getChildren().get(2).getChildren().get(0).addChild(new GeneralTree<>(0));
        ag.getChildren().get(1).getChildren().get(1).getChildren().get(0).addChild(new GeneralTree<>(1));
        ag.getChildren().get(2).getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(0));
        ag.getChildren().get(2).getChildren().get(0).getChildren().get(0).addChild(new GeneralTree<>(0));

        System.out.println("El camino filtrado de valor máximo es " + ParcialArboles.resolver(ag));

    }

}