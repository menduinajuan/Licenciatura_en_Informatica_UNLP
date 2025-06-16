package tp5.ejercicio6;

import java.util.*;
import tp5.ejercicio1.*;

public class BuscadorDeCaminos {

    private Graph<String> bosque;
    
    public BuscadorDeCaminos(Graph<String> bosque) {
        this.bosque=bosque;
    }

    public void setBosque(Graph<String> bosque) {
        this.bosque=bosque;
    }

    public Graph<String> getBosque() {
        return bosque;
    }

    public List<List<String>> recorridosMasSeguro() {
        List<List<String>> recorridos=new LinkedList<>();
        if ((bosque!=null) && (!bosque.isEmpty())) {
            Vertex origen=bosque.search("Casa Caperucita");
            Vertex destino=bosque.search("Casa Abuelita");
            if ((origen!=null) && (destino!=null))
                dfs(origen, destino, recorridos, new LinkedList<String>(), new boolean[bosque.getSize()]);
        }
        return recorridos;
    }
    
    private void dfs(Vertex<String> origen, Vertex<String> destino, List<List<String>> recorridos, List<String> caminoActual, boolean[] marcas) {
        marcas[origen.getPosition()]=true;
        caminoActual.add(origen.getData());
        if (origen==destino) 
            recorridos.add(new LinkedList<String>(caminoActual));
        else {
            for (Edge<String> e: bosque.getEdges(origen)) {
                Vertex<String> v=e.getTarget();
                if ((!marcas[v.getPosition()]) && (e.getWeight()<5)) 
                    dfs(v, destino, recorridos, caminoActual, marcas);
            }
        }
        caminoActual.remove(caminoActual.size()-1);
        marcas[origen.getPosition()]=false;
    }

}