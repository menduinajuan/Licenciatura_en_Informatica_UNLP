/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 3*/
/*
Implementar, en la clase GeneralTree, los siguientes métodos:
(a) public int altura(): Devuelve la altura del árbol, es decir, la longitud del camino más largo desde el nodo raíz hasta una hoja.
(b) public int nivel(T dato): Devuelve la profundidad o nivel del dato en el árbol. El nivel de un nodo es la longitud del único camino de la raíz al nodo.
(c) public int ancho(): Devuelve la amplitud (ancho) de un árbol, que se define como la cantidad de nodos que se encuentran en el nivel que posee la mayor cantidad de nodos.
*/

package tp3.ejercicio3;

import tp3.ejercicio1.GeneralTree;

public class TP3_E3 {

    public static void main(String[] args) {

        int num=1;
        GeneralTree<Integer> ag=new GeneralTree<>(num++);
        ag.addChild(new GeneralTree<>(num++));
        ag.addChild(new GeneralTree<>(num++));
        ag.addChild(new GeneralTree<>(num++));
        for (GeneralTree<Integer> child: ag.getChildren()) {
            child.addChild(new GeneralTree<>(num++));
            child.addChild(new GeneralTree<>(num++));
            child.addChild(new GeneralTree<>(num++));
        }

        System.out.println("La altura del árbol general ag es " + ag.altura());
        System.out.println();
        for (int i=1; i<num+1; i++)
            System.out.println("La profundidad o nivel del dato " + i + " en el árbol general ag es " + ag.nivel(i));
        System.out.println();
        System.out.println("La amplitud (ancho) del árbol general ag es " + ag.ancho());

    }

}