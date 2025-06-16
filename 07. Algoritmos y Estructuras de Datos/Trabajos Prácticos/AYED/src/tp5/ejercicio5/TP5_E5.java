/*TRABAJO PRÁCTICO N° 5*/
/*EJERCICIO 5*/
/*
El Banco Itaú se suma a las campañas “QUEDATE EN CASA” lanzando un programa para acercar el sueldo a los jubilados hasta sus domicilios.
Para ello, el banco cuenta con información que permite definir un grafo de personas donde la persona puede ser un jubilado o un empleado del banco que llevará el dinero.
Se necesita armar la cartera de jubilados para cada empleado repartidor del banco, incluyendo, en cada lista, los jubilados que vivan un radio cercano a su casa y no hayan percibido la jubilación del mes.
Para ello, implementar un algoritmo que, dado un Grafo<Persona>, retorne una lista de jubilados que se encuentren a una distancia menor a un valor dado del empleado Itaú (grado de separación del empleado Itaú).
El método recibirá un Grafo<Persona>, un empleado y un grado de separación/distancia y debe retornar una lista de hasta 40 jubilados que no hayan percibido la jubilación del mes y se encuentren a una distancia menor a lo recibido como parámetro.
*/

package tp5.ejercicio5;

import tp5.ejercicio1.*;

public class TP5_E5 {

    public static void main(String[] args) {

        Graph<Persona> grafo=new AdjListGraph<>();
        Vertex v1=grafo.createVertex(new Persona("Empleado", "Juan", "AAA", true));
        Vertex v2=grafo.createVertex(new Persona("Empleado", "Ignacio", "BBB", true));
        Vertex v3=grafo.createVertex(new Persona("Empleado", "Menduiña", "CCC", true));
        Vertex v4=grafo.createVertex(new Persona("Jubilado", "Demian", "DDD", false));
        Vertex v5=grafo.createVertex(new Persona("Jubilado", "Tupac", "EEE", true));
        Vertex v6=grafo.createVertex(new Persona("Jubilado", "Panigo", "FFF", false));
        Vertex v7=grafo.createVertex(new Persona("Jubilado", "Matías", "GGG", true));
        Vertex v8=grafo.createVertex(new Persona("Jubilado", "Guaymás", "HHH", false));

        grafo.connect(v1, v2);
        grafo.connect(v1, v4);

        grafo.connect(v2, v3);
        grafo.connect(v2, v5);
        grafo.connect(v2, v6);

        grafo.connect(v3, v1);
        grafo.connect(v3, v7);
        grafo.connect(v3, v8);

        BancoItau banco=new BancoItau();
        System.out.println("Lista Grado 1 de Empleado 'Juan':     " + banco.carteraJubilados(grafo, "Juan", 1));
        System.out.println("Lista Grado 2 de Empleado 'Juan':     " + banco.carteraJubilados(grafo, "Juan", 2));
        System.out.println("Lista Grado 3 de Empleado 'Juan':     " + banco.carteraJubilados(grafo, "Juan", 3));
        System.out.println("Lista Grado 1 de Empleado 'Ignacio':  " + banco.carteraJubilados(grafo, "Ignacio", 1));
        System.out.println("Lista Grado 2 de Empleado 'Ignacio':  " + banco.carteraJubilados(grafo, "Ignacio", 2));
        System.out.println("Lista Grado 3 de Empleado 'Ignacio':  " + banco.carteraJubilados(grafo, "Ignacio", 3));
        System.out.println("Lista Grado 1 de Empleado 'Menduiña': " + banco.carteraJubilados(grafo, "Menduiña", 1));
        System.out.println("Lista Grado 2 de Empleado 'Menduiña': " + banco.carteraJubilados(grafo, "Menduiña", 2));
        System.out.println("Lista Grado 3 de Empleado 'Menduiña': " + banco.carteraJubilados(grafo, "Menduiña", 3));

    }

}