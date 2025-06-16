package tp5.ejercicio2;

import java.util.*;
import tp1.ejercicio8.Queue;
import tp5.ejercicio1.*;

public class Recorridos<T> {

    public Recorridos() {
        
    }

    public List<T> dfs(Graph<T> grafo) {
        List<T> lista=new LinkedList<T>();
        if ((grafo!=null) && (!grafo.isEmpty())) {
            boolean[] marca=new boolean[grafo.getSize()];
            for (int i=0; i<grafo.getSize(); i++)
                if (!marca[i])
                    dfs(i, grafo, lista, marca);
        }
        return lista;
    }

    private void dfs(int i, Graph<T> grafo, List<T> lista, boolean[] marca) {
        marca[i]=true;
        Vertex<T> v=grafo.getVertex(i);
        lista.add(v.getData());
        for (Edge<T> e: grafo.getEdges(v)) {
            int j=e.getTarget().getPosition();
            if (!marca[j])
                dfs(j, grafo, lista, marca);
        }
    }

    public List<T> bfs(Graph<T> grafo) {
        List<T> lista=new LinkedList<T>(); 
        if ((grafo!=null) && (!grafo.isEmpty())) {
            boolean[] marca=new boolean[grafo.getSize()];
            for (int i=0; i<grafo.getSize(); i++)
                if (!marca[i])
                    bfs(i, grafo, lista, marca);
        }
        return lista;
    }
    
    private void bfs(int i, Graph<T> grafo, List<T> lista, boolean[] marca) {
        marca[i]=true;
        Queue<Vertex<T>> q=new Queue<>();
        q.enqueue(grafo.getVertex(i));
        while (!q.isEmpty()) {
            Vertex<T> v=q.dequeue();
            lista.add(v.getData());
            for (Edge<T> e: grafo.getEdges(v)) {
                int j=e.getTarget().getPosition();
                if (!marca[j]) {
                    marca[j]=true;
                    q.enqueue(e.getTarget());
                }
            }
        }
    }

}