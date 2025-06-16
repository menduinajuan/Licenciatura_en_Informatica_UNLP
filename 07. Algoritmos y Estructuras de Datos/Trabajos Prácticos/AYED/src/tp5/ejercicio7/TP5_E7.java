/*TRABAJO PRÁCTICO N° 5*/
/*EJERCICIO 7*/
/*
(a) Implementar, nuevamente, el Ejercicio 3.3 haciendo uso del algoritmo de Dijkstra.
(b) Implementar, nuevamente, el Ejercicio 3.3 haciendo uso del algoritmo de Floyd.
(c) Comparar el tiempo de ejecución de las tres implementaciones.
*/

package tp5.ejercicio7;

import tp5.ejercicio1.*;
import tp5.ejercicio3.Mapa;

public class TP5_E7 {

    public static void main(String[] args) {

        Graph<String> ciudades=new AdjListGraph<>();
        Vertex<String> v1=ciudades.createVertex("La Plata");
        Vertex<String> v2=ciudades.createVertex("Tolosa");
        Vertex<String> v3=ciudades.createVertex("Ringuelet");
        Vertex<String> v4=ciudades.createVertex("Gonnet");
        Vertex<String> v5=ciudades.createVertex("City Bell");
        Vertex<String> v6=ciudades.createVertex("Villa Elisa");
        Vertex<String> v7=ciudades.createVertex("Hudson");
        ciudades.connect(v1, v2, 4);
        ciudades.connect(v1, v3, 3);
        ciudades.connect(v1, v4, 4);
        ciudades.connect(v2, v5, 15);
        ciudades.connect(v3, v4, 4);
        ciudades.connect(v3, v5, 3);
        ciudades.connect(v4, v5, 11);
        ciudades.connect(v4, v6, 10);
        ciudades.connect(v5, v7, 4);
        ciudades.connect(v6, v7, 9);

        Mapa mapa=new Mapa(ciudades);
        System.out.println("Lista caminoMasCortoV1: " + mapa.caminoMasCortoV1("La Plata", "Hudson"));
        System.out.println("Lista caminoMasCortoV2: " + mapa.caminoMasCortoV2("La Plata", "Hudson"));
        System.out.println("Lista caminoMasCortoV3: " + mapa.caminoMasCortoV3("La Plata", "Hudson"));

    }

}