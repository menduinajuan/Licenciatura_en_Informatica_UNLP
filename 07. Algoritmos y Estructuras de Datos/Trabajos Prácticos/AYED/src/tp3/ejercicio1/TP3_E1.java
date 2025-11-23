/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 1*/
/*
Considerar la siguiente especificación de la clase GeneralTree (con la representación de Lista de Hijos).
    •	El constructor GeneralTree(T data) inicializa un árbol que tiene como raíz un nodo y este nodo tiene el dato pasado como parámetro y una lista vacía.
    •	El constructor GeneralTree(T data, List<GeneralTree <T>> children) inicializa un árbol que tiene como raíz a un nodo y este nodo tiene el dato pasado como parámetro y como hijos children.
    •	El método getData(): T retorna el dato almacenado en la raíz del árbol.
    •	El método getChildren(): List<GeneralTree <T>> retorna la lista de hijos de la raíz del árbol.
    •	El método addChild(GeneralTree <T> child) agrega un hijo al final de la lista de hijos del árbol.
    •	El método hasChildren() devuelve verdadero si la lista de hijos del árbol no es null y tampoco es vacía.
    •	El método isEmpty() devuelve verdadero si el dato del árbol es null y, además, no tiene hijos.
    •	El método removeChild(GeneralTree <T> child) elimina del árbol el hijo pasado como parámetro.
    •	Los métodos altura(), nivel(T) y ancho() se resolverán en el Ejercicio 3.
Analizar la implementación en JAVA de la clase GeneralTree brindada por la cátedra.
*/
package tp3.ejercicio1;

public class TP3_E1 {

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

    }

}