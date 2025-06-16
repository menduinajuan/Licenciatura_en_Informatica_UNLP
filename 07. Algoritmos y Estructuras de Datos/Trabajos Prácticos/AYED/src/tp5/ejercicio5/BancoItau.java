package tp5.ejercicio5;

import java.util.*;
import tp1.ejercicio8.Queue;
import tp5.ejercicio1.*;

public class BancoItau {

    public BancoItau() {
        
    }

    public List<Persona> carteraJubilados(Graph<Persona> grafo, String empleado, int grado) {
        List<Persona> lista=new LinkedList<>();
        if ((grafo!=null) && (!grafo.isEmpty())) {
            Vertex<Persona> vEmp=buscarEmpleado(grafo, empleado);
            if (vEmp!=null)
                carteraJubilados(grafo, vEmp, grado, lista, 40, new boolean[grafo.getSize()]);          
        }
        return lista;
    }

    private void carteraJubilados(Graph<Persona> grafo, Vertex<Persona> vEmp, int grado, List<Persona> lista, int maxList, boolean[] marcas) {
        marcas[vEmp.getPosition()]=true;
        Queue<Vertex<Persona>> q=new Queue<>();
        q.enqueue(vEmp);
        q.enqueue(null);
        while ((!q.isEmpty()) && (grado>0) && (lista.size()<maxList)) {
            Vertex<Persona> vActual=q.dequeue();
            if (vActual!=null) {
                Iterator<Edge<Persona>> it=grafo.getEdges(vActual).iterator();
                while ((it.hasNext()) && (lista.size()<maxList)) {
                    Vertex<Persona> vDestino=it.next().getTarget();
                    int i=vDestino.getPosition();
                    if (!marcas[i]) {
                        marcas[i]=true;
                        q.enqueue(vDestino);
                        if (vDestino.getData().cumple())
                            lista.add(vDestino.getData());
                    }
                }
            } 
            else if (!q.isEmpty()) {
                grado--;
                q.enqueue(null);
            }
        }
    }

    private Vertex<Persona> buscarEmpleado(Graph<Persona> grafo, String empleado) {
        for (Vertex<Persona> v: grafo.getVertices())
            if (v.getData().getNombre().equals(empleado))
                return v;
        return null;
    }

}