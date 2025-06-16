/*TRABAJO PRÁCTICO N° 5*/
/*EJERCICIO 4*/
/*
Se quiere realizar un paseo en bicicleta por lugares emblemáticos de Oslo. Para esto, se cuenta con un grafo de bicisendas.
Partiendo desde el “Ayuntamiento” hasta un lugar destino en menos de X minutos, sin pasar por un conjunto de lugares que están restringidos.
Escribir una clase llamada VisitaOslo e implementar su método:
paseoEnBici(Graph<String> lugares, String destino, int maxTiempo, List<String> lugaresRestringidos): List<String>.
NOTAS:
•	El “Ayuntamiento” debe ser buscado antes de comenzar el recorrido para encontrar un camino.
•	De no existir camino posible, se debe retornar una lista vacía.
•	Se debe retornar el primer camino que se encuentre que cumpla las restricciones.
•	Ejemplos de posibles caminos a retornar sin pasar por “Akker Brigge” y “Palacio Real” en no más de 120 min (maxTiempo):
    o	Ayuntamiento, El Tigre, Museo Munch, Parque Botánico, Galería Nacional, Parque Vigeland, FolkMuseum, Museo Fram, Museo del Barco Polar, Museo Vikingo. El recorrido se hace en 91 minutos.
    o	Ayuntamiento, Parque Botánico, Galería Nacional, Parque Vigeland, FolkMuseum, Museo Fram, Museo del Barco Polar, Museo Vikingo. El recorrido se hace en 70 minutos.
*/

package tp5.ejercicio4;

import java.util.*;
import tp5.ejercicio1.*;

public class TP5_E4 {

    public static void main(String[] args) {

        Graph<String> lugares=new AdjListGraph<>();
        Vertex<String> v1=lugares.createVertex("Holmenkollen");
        Vertex<String> v2=lugares.createVertex("Parque Vigeland");
        Vertex<String> v3=lugares.createVertex("Galería Nacional");
        Vertex<String> v4=lugares.createVertex("Parque Botánico");
        Vertex<String> v5=lugares.createVertex("Museo Munch");
        Vertex<String> v6=lugares.createVertex("FolkMuseum");
        Vertex<String> v7=lugares.createVertex("Palacio Real");
        Vertex<String> v8=lugares.createVertex("Ayuntamiento");
        Vertex<String> v9=lugares.createVertex("El Tigre");
        Vertex<String> v10=lugares.createVertex("Akker Brigge");
        Vertex<String> v11=lugares.createVertex("La Opera");
        Vertex<String> v12=lugares.createVertex("Museo Fram");
        Vertex<String> v13=lugares.createVertex("Museo Vikingo");
        Vertex<String> v14=lugares.createVertex("Fortaleza Akershus");
        Vertex<String> v15=lugares.createVertex("Museo del Barco Polar");

        lugares.connect(v1, v2, 30);

        lugares.connect(v2, v1, 30);
        lugares.connect(v2, v3, 10);
        lugares.connect(v2, v6, 20);

        lugares.connect(v3, v2, 10);
        lugares.connect(v3, v4, 15);

        lugares.connect(v4, v3, 15);
        lugares.connect(v4, v5, 1);
        lugares.connect(v4, v8, 10);

        lugares.connect(v5, v4, 1);
        lugares.connect(v5, v9, 15);

        lugares.connect(v6, v2, 20);
        lugares.connect(v6, v7, 5);
        lugares.connect(v6, v10, 30);
        lugares.connect(v6, v12, 5);

        lugares.connect(v7, v6, 5);
        lugares.connect(v7, v8, 5);

        // Recorrido que se hace en 70 minutos
        lugares.connect(v8, v4, 10);
        lugares.connect(v8, v7, 5);
        lugares.connect(v8, v9, 15);
        lugares.connect(v8, v10, 20);

        // Recorrido que se hace en 91 minutos
        /*
        lugares.connect(v8, v9, 15);
        lugares.connect(v8, v4, 10);
        lugares.connect(v8, v7, 5);
        lugares.connect(v8, v10, 20);
        */

        lugares.connect(v9, v5, 15);
        lugares.connect(v9, v8, 15);
        lugares.connect(v9, v11, 5);

        lugares.connect(v10, v6, 30);
        lugares.connect(v10, v8, 20);
        lugares.connect(v10, v13, 30);

        lugares.connect(v11, v9, 5);
        lugares.connect(v11, v14, 10);

        lugares.connect(v12, v6, 5);
        lugares.connect(v12, v15, 5);

        lugares.connect(v13, v10, 30);
        lugares.connect(v13, v15, 5);

        lugares.connect(v14, v11, 10);

        lugares.connect(v15, v12, 5);
        lugares.connect(v15, v13, 5);

        VisitaOslo visita=new VisitaOslo();
        System.out.println("Lista VisitaOslo: " + visita.paseoEnBici(lugares, "Museo Vikingo", 120, new LinkedList<String>(Arrays.asList("Akker Brigge", "Palacio Real"))));

    }

}