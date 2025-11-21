/*TRABAJO PRÁCTICO N° 5*/
/*EJERCICIO 2*/
/*
(a) Implementar, en JAVA, una clase llamada Recorridos ubicada dentro del paquete ejercicio2 cumpliendo la siguiente especificación:
dfs(Graph<T> grafo): List<T>
// Retorna una lista con los datos de los vértices, con el recorrido en profundidad del grafo recibido como parámetro.
bfs(Graph<T> grafo): List<T>
// Retorna una lista con los datos de vértices, con el recorrido en amplitud del grafo recibido como parámetro.
(b) Estimar el orden de ejecución de los métodos anteriores.
*/

package tp5.ejercicio2;

import tp5.ejercicio1.*;

public class TP5_E2 {

    public static void main(String[] args) {

        Graph<String> bosque=new AdjListGraph<>();
        Vertex<String> v1=bosque.createVertex("Casa Caperucita");
        Vertex<String> v2=bosque.createVertex("Claro 3");
        Vertex<String> v3=bosque.createVertex("Claro 1");
        Vertex<String> v4=bosque.createVertex("Claro 2");
        Vertex<String> v5=bosque.createVertex("Claro 5");
        Vertex<String> v6=bosque.createVertex("Claro 4");
        Vertex<String> v7=bosque.createVertex("Casa Abuelita");
        bosque.connect(v1, v2);
        bosque.connect(v1, v3);
        bosque.connect(v1, v4);
        bosque.connect(v2, v5);
        bosque.connect(v3, v4);
        bosque.connect(v3, v5);
        bosque.connect(v4, v5);
        bosque.connect(v4, v6);
        bosque.connect(v5, v7);
        bosque.connect(v6, v7);

        Recorridos<String> recorridos=new Recorridos<String>();
        System.out.println("Lista Recorrido DFS: " + recorridos.dfs(bosque));
        System.out.println("Lista Recorrido BFS: " + recorridos.bfs(bosque));

    }

}