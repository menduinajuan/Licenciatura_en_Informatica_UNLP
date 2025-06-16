package tp5.ejercicio1;

import java.util.*;

public class AdjListGraph<T> implements Graph<T> {

    private List<AdjListVertex<T>> vertices;

    public AdjListGraph() {
    	this.vertices=new ArrayList<>();
    }

    @Override
    public Vertex<T> createVertex(T data) {
        AdjListVertex<T> vertex=new AdjListVertex<>(data, this.vertices.size());
        this.vertices.add(vertex);
        return vertex;
    }

    @Override
    public void removeVertex(Vertex<T> vertex) {
        int position=vertex.getPosition();
        if (this.vertices.get(position)!=vertex)
            return;
        this.vertices.remove(position);
        for (; position<this.vertices.size(); position++)
            this.vertices.get(position).decrementPosition();
        for (Vertex<T> other: this.vertices)
            this.disconnect(other, vertex);
    }

    @Override
    public Vertex<T> search(T data) {
        for (Vertex<T> vertex: this.vertices)
            if (vertex.getData().equals(data))
                return vertex;
        return null;
    }

    /*
    * Indica si el vértice recibido pertenece al grafo.
    */
    private boolean belongs(Vertex<T> vertex) {
        int pos=vertex.getPosition();
        return pos>=0 && pos<this.vertices.size() && this.vertices.get(pos)==vertex;
    }

    @Override
    public void connect(Vertex<T> origin, Vertex<T> destination) {
        if (this.belongs(origin) && this.belongs(destination))
            ((AdjListVertex<T>) origin).connect(destination);
    }

    @Override
    public void connect(Vertex<T> origin, Vertex<T> destination, int weight) {
        if (this.belongs(origin) && this.belongs(destination))
            ((AdjListVertex<T>) origin).connect(destination, weight);
    }

    @Override
    public void disconnect(Vertex<T> origin, Vertex<T> destination) {
        if (this.belongs(origin))
            ((AdjListVertex<T>) origin).disconnect(destination);
    }

    /*
    * Retorna la arista entre los dos vértices, si es que existe. Previamente, valida que el vértice pertenezca al grafo.
    */
    private Edge<T> edge(Vertex<T> origin, Vertex<T> destination) {
        if (this.belongs(origin))
            return ((AdjListVertex<T>) origin).getEdge(destination);
        return null;
    }

    @Override
    public boolean existsEdge(Vertex<T> origin, Vertex<T> destination) {
        return this.edge(origin, destination)!=null;
    }

    @Override
    public boolean isEmpty() {
        return this.vertices.isEmpty();
    }

    @Override
    public List<Vertex<T>> getVertices() {
        return new ArrayList<>(this.vertices);
    }

    @Override
    public int weight(Vertex<T> origin, Vertex<T> destination) {
        Edge<T> edge=this.edge(origin, destination);
        int weight=0;
        if (edge!=null)
            weight=edge.getWeight();
        return weight;
    }

    @Override
    public List<Edge<T>> getEdges(Vertex<T> vertex) {
        if (this.belongs(vertex))
            return ((AdjListVertex<T>) vertex).getEdges();
        return null;
    }

    @Override
    public Vertex<T> getVertex(int position) {
        if ((position<0) || (this.vertices.size()<=position))
            return null;
        return this.vertices.get(position);
    }

    @Override
    public int getSize() {
        return this.vertices.size();
    }

}