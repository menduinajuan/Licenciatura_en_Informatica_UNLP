package tp5.ejercicio3;

import java.util.*;
import tp5.ejercicio1.*;

public class Mapa {

    private Graph<String> mapaCiudades;

    public Mapa(Graph<String> mapa) {
        mapaCiudades=mapa;
    }

    public void setMapaCiudades(Graph<String> mapaCiudades) {
        this.mapaCiudades=mapaCiudades;
    }

    public Graph<String> getMapaCiudades() {
        return mapaCiudades;
    }

    // 1. devolverCamino

    public List<String> devolverCamino(String ciudad1, String ciudad2) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null))
                devolverCamino(origen, destino, camino, new boolean[this.getMapaCiudades().getSize()]);
        }
        return camino;
    }

    private boolean devolverCamino(Vertex<String> origen, Vertex<String> destino, List<String> camino, boolean[] marcas) {
        boolean ok=false;
        marcas[origen.getPosition()]=true;
        camino.add(origen.getData());
        if (origen==destino)
            ok=true;
        else {
            Iterator<Edge<String>> it=mapaCiudades.getEdges(origen).iterator();
            while ((it.hasNext()) && (!ok)) {
                Vertex<String> v=it.next().getTarget();
                if (!marcas[v.getPosition()])
                    ok=devolverCamino(v, destino, camino, marcas);
            }
        }
        if (!ok)
            camino.remove(camino.size()-1);
        return ok;
    }

    // 2. devolverCaminoExceptuando

    public List<String> devolverCaminoExceptuando(String ciudad1, String ciudad2, List<String> ciudades) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null)) {
                boolean [] marcas=new boolean[this.getMapaCiudades().getSize()];
                marcarRestringidos(ciudades, marcas);
                devolverCamino(origen, destino, camino, marcas);
            }
        }
        return camino;
    }

    private void marcarRestringidos(List<String> ciudadesRestringidas, boolean[] marcas) {
        for (String ciudad: ciudadesRestringidas) {
            Vertex<String> v=mapaCiudades.search(ciudad);
            if (v!=null)
                marcas[v.getPosition()]=true;
        }
    }

    // 3. caminoMasCortoV1

    public List<String> caminoMasCortoV1(String ciudad1, String ciudad2) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null))
                caminoMasCortoV1(origen, destino, new LinkedList<String>(), camino, 0, Integer.MAX_VALUE, new boolean[this.getMapaCiudades().getSize()]);
        }
        return camino;
    }
    
    private int caminoMasCortoV1(Vertex<String> origen, Vertex<String> destino, List<String> caminoActual, List<String> caminoMin, int sumaActual, int sumaMin, boolean[] marcas) {
        marcas[origen.getPosition()]=true;
        caminoActual.add(origen.getData());
        if (origen==destino) {
            caminoMin.clear();
            caminoMin.addAll(caminoActual);
            sumaMin=sumaActual;
        }
        else {
            for (Edge<String> e: mapaCiudades.getEdges(origen)) {
                Vertex<String> v=e.getTarget();
                int aux=sumaActual+e.getWeight();
                if ((!marcas[v.getPosition()]) && (aux<sumaMin))
                    sumaMin=caminoMasCortoV1(v, destino, caminoActual, caminoMin, aux, sumaMin, marcas);
            }
        }
        caminoActual.remove(caminoActual.size()-1);
        marcas[origen.getPosition()]=false;
        return sumaMin;
    }

    // 3. caminoMasCortoV2

    public List<String> caminoMasCortoV2(String ciudad1, String ciudad2) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null))
                caminoMasCortoV2(origen, destino, new LinkedList<String>(), camino, 0, Integer.MAX_VALUE, new boolean[this.getMapaCiudades().getSize()]);
        }
        return camino;
    }
    
    private int caminoMasCortoV2(Vertex<String> origen, Vertex<String> destino, List<String> caminoActual, List<String> caminoMin, int sumaActual, int sumaMin, boolean[] marcas) {
        marcas[origen.getPosition()]=true;
        caminoActual.add(origen.getData());
        if (origen==destino) {
            caminoMin.clear();
            caminoMin.addAll(caminoActual);
            sumaMin=sumaActual;
        }
        else {
            for (Edge<String> e: mapaCiudades.getEdges(origen)) {
                Vertex<String> v=e.getTarget();
                int aux=sumaActual+e.getWeight();
                if ((!marcas[v.getPosition()]) && (aux<sumaMin))
                    sumaMin=caminoMasCortoV2(v, destino, caminoActual, caminoMin, aux, sumaMin, marcas);
            }
        }
        caminoActual.remove(caminoActual.size()-1);
        marcas[origen.getPosition()]=false;
        return sumaMin;
    }

    // 3. caminoMasCortoV3

    public List<String> caminoMasCortoV3(String ciudad1, String ciudad2) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null))
                caminoMasCortoV3(origen, destino, new LinkedList<String>(), camino, 0, Integer.MAX_VALUE, new boolean[this.getMapaCiudades().getSize()]);
        }
        return camino;
    }
    
    private int caminoMasCortoV3(Vertex<String> origen, Vertex<String> destino, List<String> caminoActual, List<String> caminoMin, int sumaActual, int sumaMin, boolean[] marcas) {
        marcas[origen.getPosition()]=true;
        caminoActual.add(origen.getData());
        if (origen==destino) {
            caminoMin.clear();
            caminoMin.addAll(caminoActual);
            sumaMin=sumaActual;
        }
        else {
            for (Edge<String> e: mapaCiudades.getEdges(origen)) {
                Vertex<String> v=e.getTarget();
                int aux=sumaActual+e.getWeight();
                if ((!marcas[v.getPosition()]) && (aux<sumaMin))
                    sumaMin=caminoMasCortoV1(v, destino, caminoActual, caminoMin, aux, sumaMin, marcas);
            }
        }
        caminoActual.remove(caminoActual.size()-1);
        marcas[origen.getPosition()]=false;
        return sumaMin;
    }

    // 4. caminoSinCargarCombustible

    public List<String> caminoSinCargarCombustible(String ciudad1, String ciudad2, int tanqueAuto) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null))
                caminoSinCargarCombustible(origen, destino, tanqueAuto, camino, new boolean[this.getMapaCiudades().getSize()]);
        }
        return camino;
    }

    private boolean caminoSinCargarCombustible(Vertex<String> origen, Vertex<String> destino, int tanqueAuto, List<String> camino, boolean[] marcas) {
        boolean ok=false;
        marcas[origen.getPosition()]=true;
        camino.add(origen.getData());
        if (origen==destino)
            ok=true;
        else {
            Iterator<Edge<String>> it=mapaCiudades.getEdges(origen).iterator();
            while ((it.hasNext()) && (!ok)) {
                Edge<String> e=it.next();
                Vertex<String> v=e.getTarget();
                int aux=tanqueAuto-e.getWeight();
                if ((!marcas[v.getPosition()]) && (aux>0))
                    ok=caminoSinCargarCombustible(v, destino, aux, camino, marcas);
            }
        }
        if (!ok) {
            camino.remove(camino.size()-1);
            marcas[origen.getPosition()]=false;
        }
        return ok;
    }

    // 5. caminoConMenorCargaDeCombustible

    public List<String> caminoConMenorCargaDeCombustible(String ciudad1, String ciudad2, int tanqueAuto) {
        List<String> camino=new LinkedList<>();
        if ((mapaCiudades!=null) && (!mapaCiudades.isEmpty())) {
            Vertex origen=mapaCiudades.search(ciudad1);
            Vertex destino=mapaCiudades.search(ciudad2);
            if ((origen!=null) && (destino!=null))
                caminoConMenorCargaDeCombustible(origen, destino, tanqueAuto, tanqueAuto, new LinkedList<String>(), camino, 0, Integer.MAX_VALUE, new boolean[this.getMapaCiudades().getSize()]);
        }
        return camino;
    }
    
    private int caminoConMenorCargaDeCombustible(Vertex<String> origen, Vertex<String> destino, int tanqueActual, int tanque, List<String> caminoActual, List<String> caminoMin, int recargasActual, int recargasMin, boolean[] marcas) {
        marcas[origen.getPosition()]=true;
        caminoActual.add(origen.getData());
        if ((origen==destino) && (recargasActual<recargasMin)) {
            caminoMin.clear();
            caminoMin.addAll(caminoActual);
            recargasMin=recargasActual;
        }
        else {
            for (Edge<String> e: mapaCiudades.getEdges(origen)) {
                Vertex<String> v=e.getTarget();
                int distancia=e.getWeight();
                if ((!marcas[v.getPosition()]) && (recargasActual<recargasMin)) {
                    if (tanqueActual>=distancia)
                        recargasMin=caminoConMenorCargaDeCombustible(v, destino, tanqueActual-distancia, tanque, caminoActual, caminoMin, recargasActual, recargasMin, marcas);
                    else if (tanque>=distancia)
                        recargasMin=caminoConMenorCargaDeCombustible(v, destino, tanque-distancia, tanque, caminoActual, caminoMin, recargasActual+1, recargasMin, marcas);
                }
            }
        }
        caminoActual.remove(caminoActual.size()-1);
        marcas[origen.getPosition()]=false;
        return recargasMin;
    }

}