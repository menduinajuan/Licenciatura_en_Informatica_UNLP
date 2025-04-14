/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 2*/
/*
(a) Implementar, en la clase RecorridosAG, los siguientes métodos:
•	public List<Integer> numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n) Método que retorna una lista con los elementos impares del árbol “a” que sean mayores al valor “n” pasados como parámetros, recorrido en preorden.
•	public List<Integer> numerosImparesMayoresQueInOrden(GeneralTree<Integer> a, Integer n) Método que retorna una lista con los elementos impares del árbol “a” que sean mayores al valor “n” pasados como parámetros, recorrido en inorden.
•	public List<Integer> numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n) Método que retorna una lista con los elementos impares del árbol “a” que sean mayores al valor “n” pasados como parámetros, recorrido en postorden.
•	public List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree<Integer> a, Integer n) Método que retorna una lista con los elementos impares del árbol “a” que sean mayores al valor “n” pasados como parámetros, recorrido por niveles.
(b) Si, ahora, se tuviera que implementar estos métodos en la clase GeneralTree<T>, ¿qué modificaciones se harían tanto en la firma como en la implementación de los mismos?
*/

package tp3.ejercicio2;

import tp3.ejercicio1.GeneralTree;

public class TP3_E2 {

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

        RecorridosAG agRec=new RecorridosAG();
        int n=0;
        System.out.println("Lista Pre-Orden de números impares del árbol general ag: " + agRec.numerosImparesMayoresQuePreOrden(ag, n));
        System.out.println("Lista In-Orden de números impares del árbol general ag: " + agRec.numerosImparesMayoresQueInOrden(ag, n));
        System.out.println("Lista Post-Orden de números impares del árbol general ag: " + agRec.numerosImparesMayoresQuePostOrden(ag, n));
        System.out.println("Lista Por Niveles de números impares del árbol general ag: " + agRec.numerosImparesMayoresQuePorNiveles(ag, n));

        System.out.println();
        System.out.println("Lista Pre-Orden de números impares del árbol general ag: " + ag.numerosImparesMayoresQuePreOrden(n));
        System.out.println("Lista In-Orden de números impares del árbol general ag: " + ag.numerosImparesMayoresQueInOrden(n));
        System.out.println("Lista Post-Orden de números impares del árbol general ag: " + ag.numerosImparesMayoresQuePostOrden(n));
        System.out.println("Lista Por Niveles de números impares del árbol general ag: " + ag.numerosImparesMayoresQuePorNiveles(n));

    }

}