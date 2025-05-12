/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 5*/
/*
Se dice que un nodo n es ancestro de un nodo m si existe un camino desde n a m.
Implementar un método en la clase GeneralTree con la siguiente firma:
public boolean esAncestro(T a, T b): Devuelve true si el valor “a” es ancestro del valor “b”.
*/

package tp3.ejercicio5;

import PaqueteLectura.*;
import tp3.ejercicio1.GeneralTree;

public class TP3_E5 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        int k=3;
        int num=1;
        GeneralTree<Integer> ag=new GeneralTree<>(num++);
        for (int i=0; i<k; i++)
            ag.addChild(new GeneralTree<>(num++));
        for (GeneralTree<Integer> child: ag.getChildren()) {
            for (int i=0; i<k; i++)
                child.addChild(new GeneralTree<>(num++));
        }

        int a=1+GeneradorAleatorio.generarInt(num-1);
        int b=1+GeneradorAleatorio.generarInt(num-1);
        System.out.println("¿El nodo " + a + " es ancestro del nodo " + b + "?: " + ag.esAncestro(a, b));

    }

}