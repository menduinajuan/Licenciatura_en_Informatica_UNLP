/*TRABAJO PRÁCTICO N° 5*/
/*EJERCICIO 6*/
/*
Un día, Caperucita Roja decide ir desde su casa hasta la de su abuelita, recolectando frutos del bosque del camino y tratando de hacer el paseo de la manera más segura posible.
La casa de Caperucita está en un claro del extremo oeste del bosque, la casa de su abuelita en un claro del extremo este y, dentro del bosque, entre ambas, hay algunos otros claros.
El bosque está representado por un grafo, donde los vértices representan los claros (identificados por un String) y las aristas los senderos que los unen.
Cada arista informa la cantidad de árboles frutales que hay en el sendero.
Caperucita sabe que el lobo es muy goloso y le gustan mucho las frutas, entonces, para no ser capturada por el lobo, desea encontrar todos los caminos que no pasen por los senderos con cantidad de frutales ≥ 5 y lleguen a la casa de la abuelita.
La tarea es definir una clase llamada BuscadorDeCaminos, con una variable de instancia llamada “bosque” de tipo Graph, que representa el bosque descrito e implementar un método de instancia con la siguiente firma:
public List <List <String>> recorridosMasSeguro(),
que devuelva un listado con TODOS los caminos que cumplen con las condiciones mencionadas anteriormente.
NOTA: La casa de Caperucita debe ser buscada antes de comenzar a buscar el recorrido.
*/

package tp5.ejercicio6;

import tp5.ejercicio1.*;

public class TP5_E6 {

    public static void main(String[] args) {

        Graph<String> bosque=new AdjListGraph<>();
        Vertex<String> v1=bosque.createVertex("Casa Caperucita");
        Vertex<String> v2=bosque.createVertex("Claro 3");
        Vertex<String> v3=bosque.createVertex("Claro 1");
        Vertex<String> v4=bosque.createVertex("Claro 2");
        Vertex<String> v5=bosque.createVertex("Claro 5");
        Vertex<String> v6=bosque.createVertex("Claro 4");
        Vertex<String> v7=bosque.createVertex("Casa Abuelita");
        bosque.connect(v1, v2, 4);
        bosque.connect(v1, v3, 3);
        bosque.connect(v1, v4, 4);
        bosque.connect(v2, v1, 4);
        bosque.connect(v2, v5, 15);
        bosque.connect(v3, v1, 3);
        bosque.connect(v3, v4, 4);
        bosque.connect(v3, v5, 3);
        bosque.connect(v4, v1, 4);
        bosque.connect(v4, v3, 4);
        bosque.connect(v4, v5, 11);
        bosque.connect(v4, v6, 10);
        bosque.connect(v5, v2, 15);
        bosque.connect(v5, v3, 3);
        bosque.connect(v5, v4, 11);
        bosque.connect(v5, v7, 4);
        bosque.connect(v6, v4, 10);
        bosque.connect(v6, v7, 9);
        bosque.connect(v7, v5, 4);
        bosque.connect(v7, v6, 9);

        BuscadorDeCaminos buscador=new BuscadorDeCaminos(bosque);
        System.out.println("Lista BuscadorDeCaminos: " + buscador.recorridosMasSeguro());

    }

}