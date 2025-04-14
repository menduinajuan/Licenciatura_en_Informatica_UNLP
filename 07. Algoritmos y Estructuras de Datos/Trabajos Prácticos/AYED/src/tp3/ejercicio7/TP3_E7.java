/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 7*/
/*
Dada una clase Caminos que contiene una variable de instancia de tipo GeneralTree de números enteros, implementar un método que retorne el camino a la hoja más lejana.
En el caso de haber más de un camino máximo, retornar el primero que se encuentre. El método debe tener la siguiente firma:
public List<Integer> caminoAHojaMasLejana().
Por ejemplo, para el siguiente árbol, la lista a retornar sería: 12, 17, 6, 1 de longitud 3 (los caminos 12, 15, 14, 16 y 12, 15, 14, 7 son también máximos, pero se pide el primero).
*/

package tp3.ejercicio7;

import tp3.ejercicio1.GeneralTree;

public class TP3_E7 {

    public static void main(String[] args) {

        GeneralTree<Integer> ag=new GeneralTree<>(12);
        ag.addChild(new GeneralTree<>(17));
        ag.addChild(new GeneralTree<>(9));
        ag.addChild(new GeneralTree<>(15));
        ag.getChildren().get(0).addChild(new GeneralTree<>(10));
        ag.getChildren().get(0).addChild(new GeneralTree<>(6));
        ag.getChildren().get(1).addChild(new GeneralTree<>(8));
        ag.getChildren().get(2).addChild(new GeneralTree<>(14));
        ag.getChildren().get(2).addChild(new GeneralTree<>(18));
        ag.getChildren().get(0).getChildren().get(1).addChild(new GeneralTree<>(1));
        ag.getChildren().get(2).getChildren().get(0).addChild(new GeneralTree<>(16));
        ag.getChildren().get(2).getChildren().get(0).addChild(new GeneralTree<>(7)); 

        Caminos agCaminos=new Caminos(ag);
        System.out.println("El camino a la hoja más lejana es " + agCaminos.caminoAHojaMasLejana());

    }

}