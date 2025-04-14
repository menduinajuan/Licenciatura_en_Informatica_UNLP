/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 4*/
/*
El esquema de comunicación de una empresa está organizado en una estructura jerárquica, en donde cada nodo envía el mensaje a sus descendientes.
Cada nodo posee el tiempo que tarda en transmitir el mensaje.
Se debe devolver el mayor promedio entre todos los valores promedios de los niveles.
Para el ejemplo presentado, el promedio del nivel 0 es 14, el del nivel 1 es 16 y el del nivel 2 es 10.
Por lo tanto, debe devolver 16.
(a) Indicar y justificar qué tipo de recorrido se utilizará para resolver el problema.
(b) Implementar en una clase AnalizadorArbol, el método con la siguiente firma:
public double devolverMaximoPromedio(GeneralTree<AreaEmpresa> arbol),
donde AreaEmpresa es una clase que representa a un área de la empresa mencionada y que contiene la identificación de la misma representada con un String y una tardanza de transmisión de mensajes interna representada con int.
*/

package tp3.ejercicio4;

import tp3.ejercicio1.GeneralTree;

public class TP3_E4 {

    public static void main(String[] args) {

        GeneralTree<AreaEmpresa> ag=new GeneralTree<>(new AreaEmpresa("M", 14));
        ag.addChild(new GeneralTree<>(new AreaEmpresa("J", 13)));
        ag.addChild(new GeneralTree<>(new AreaEmpresa("K", 25)));
        ag.addChild(new GeneralTree<>(new AreaEmpresa("L", 10)));
        ag.getChildren().get(0).addChild(new GeneralTree<>(new AreaEmpresa("A", 4)));
        ag.getChildren().get(0).addChild(new GeneralTree<>(new AreaEmpresa("B", 7)));
        ag.getChildren().get(0).addChild(new GeneralTree<>(new AreaEmpresa("C", 5)));
        ag.getChildren().get(1).addChild(new GeneralTree<>(new AreaEmpresa("D", 6)));
        ag.getChildren().get(1).addChild(new GeneralTree<>(new AreaEmpresa("E", 10)));
        ag.getChildren().get(1).addChild(new GeneralTree<>(new AreaEmpresa("F", 18)));
        ag.getChildren().get(2).addChild(new GeneralTree<>(new AreaEmpresa("G", 9)));
        ag.getChildren().get(2).addChild(new GeneralTree<>(new AreaEmpresa("H", 12)));
        ag.getChildren().get(2).addChild(new GeneralTree<>(new AreaEmpresa("I", 19)));

        AnalizadorArbol agAnalizador=new AnalizadorArbol();
        System.out.println("El mayor promedio entre todos los valores promedio de los niveles es " + String.format("%.2f", agAnalizador.devolverMaximoPromedio(ag)));

    }

}