package tp5.ejercicio4;

import java.util.*;
import tp5.ejercicio1.*;

public class VisitaOslo {

    public VisitaOslo() {
        
    }

    public List<String> paseoEnBici(Graph<String> lugares, String destino, int maxTiempo, List<String> lugaresRestringidos) {
        List<String> camino=new LinkedList<>();
        if ((lugares!=null) && (!lugares.isEmpty())) {
            Vertex v1=lugares.search("Ayuntamiento");
            Vertex v2=lugares.search(destino);
            if ((v1!=null) && (v2!=null)) {
                boolean [] marcas=new boolean[lugares.getSize()];
                marcarRestringidos(lugares, lugaresRestringidos, marcas);
                dfs(lugares, v1, v2, maxTiempo, camino, marcas);
            }
        }
        return camino;
    }
    
    private void marcarRestringidos(Graph<String> lugares, List<String> lugaresRestringidos, boolean[] marcas) {
        for (String lugar: lugaresRestringidos) {
            Vertex<String> v=lugares.search(lugar);
            if (v!=null)
                marcas[v.getPosition()]=true;
        }
    }
    
    private boolean dfs(Graph<String> lugares, Vertex<String> origen, Vertex<String> destino, int maxTiempo, List<String> camino, boolean[] marcas) {
        boolean ok=false;
        marcas[origen.getPosition()]=true;
        camino.add(origen.getData());
        if (origen==destino)
            ok=true;
        else {
            Iterator<Edge<String>> it=lugares.getEdges(origen).iterator();
            while ((it.hasNext()) && (!ok)) {
                Edge<String> e=it.next();
                Vertex<String> v=e.getTarget();
                int aux=maxTiempo-e.getWeight();
                if ((!marcas[v.getPosition()]) && (aux>=0))
                    ok=dfs(lugares, v, destino, aux, camino, marcas);
            }
        }
        if (!ok)
            camino.remove(camino.size()-1);
        return ok;
    }

}