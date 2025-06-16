package tp5.ejercicio1;

import java.util.*;

public class AdjListVertex<T> implements Vertex<T> {

    private T data;
    private int position;
    private List<Edge<T>> edges;

    public AdjListVertex(T data, int position) {
        this.data=data;
        this.position=position;
        this.edges=new ArrayList<>();
    }

    @Override
    public void setData(T data) {
        this.data=data;
    }

    @Override
    public T getData() {
        return this.data;
    }

    @Override
    public int getPosition() {
        return this.position;
    }

    public void decrementPosition() {
        this.position--;
    }

    public void connect(Vertex<T> destination) {
        this.connect(destination, 1);
    }

    public void connect(Vertex<T> destination, int weight) {
        Edge<T> edge=this.getEdge(destination);
        if (edge==null)
            this.edges.add(new AdjListEdge<>(destination, weight));
    }

    public void disconnect(Vertex<T> destination) {
        Edge<T> edge=this.getEdge(destination);
        if (edge!=null)
            this.edges.remove(edge);
    }

    public List<Edge<T>> getEdges() {
        return this.edges;
    }

    public Edge<T> getEdge(Vertex<T> destination) {
        for (Edge<T> edge: this.edges)
            if (edge.getTarget()==destination)
               return edge;
        return null;
    }

}