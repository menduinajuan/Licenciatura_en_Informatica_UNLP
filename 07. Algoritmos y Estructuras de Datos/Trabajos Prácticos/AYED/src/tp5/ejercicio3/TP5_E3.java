/*TRABAJO PRÁCTICO N° 5*/
/*EJERCICIO 3*/
/*
1. devolverCamino(String ciudad1, String ciudad2): List<String>
   Retorna la lista de ciudades que se deben atravesar para ir de ciudad1 a ciudad2 en caso de que se pueda llegar, sino retorna la lista vacía. (Sin tener en cuenta el combustible).
2. devolverCaminoExceptuando(String ciudad1, String ciudad2, List<String> ciudades): List<String>
   Retorna la lista de ciudades que forman un camino desde ciudad1 a ciudad2, sin pasar por las ciudades que están contenidas en la lista ciudades pasada por parámetro. Si no existe camino, retorna la lista vacía. (Sin tener en cuenta el combustible).
3. caminoMasCorto(String ciudad1, String ciudad2): List<String>
   Retorna la lista de ciudades que forman el camino más corto para llegar de ciudad1 a ciudad2. Si no existe camino, retorna la lista vacía. (Las rutas poseen la distancia).
4. caminoSinCargarCombustible(String ciudad1, String ciudad2, int tanqueAuto): List<String>
   Retorna la lista de ciudades que forman un camino para llegar de ciudad1 a ciudad2. El auto no debe quedarse sin combustible y no puede cargar. Si no existe camino, retorna la lista vacía.
5. caminoConMenorCargaDeCombustible(String ciudad1, String ciudad2, int tanqueAuto): List<String>
   Retorna la lista de ciudades que forman un camino para llegar de ciudad1 a ciudad2 teniendo en cuenta que el auto debe cargar la menor cantidad de veces. El auto no se debe quedar sin combustible en medio de una ruta, además puede completar su tanque al llegar a cualquier ciudad. Si no existe camino, retorna la lista vacía.
*/

package tp5.ejercicio3;

import java.util.*;
import tp5.ejercicio1.*;

public class TP5_E3 {

    public static void main(String[] args) {

        Graph<String> ciudades=new AdjMatrixGraph<>(7);
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
        System.out.println("Lista devolverCamino:                   " + mapa.devolverCamino("La Plata", "Hudson"));
        System.out.println("Lista devolverCaminoExceptuando:        " + mapa.devolverCaminoExceptuando("La Plata", "Hudson", new LinkedList<String>(Arrays.asList("Tolosa", "Ringuelet"))));
        System.out.println("Lista caminoMasCorto:                   " + mapa.caminoMasCortoV1("La Plata", "Hudson"));
        System.out.println("Lista caminoSinCargarCombustible:       " + mapa.caminoSinCargarCombustible("La Plata", "Hudson", 11));
        System.out.println("Lista caminoConMenorCargaDeCombustible: " + mapa.caminoConMenorCargaDeCombustible("La Plata", "Hudson", 11));

    }

}