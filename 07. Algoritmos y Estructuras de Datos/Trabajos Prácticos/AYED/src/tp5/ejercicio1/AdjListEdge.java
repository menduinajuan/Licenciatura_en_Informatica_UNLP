package tp5.ejercicio1;

public class AdjListEdge<T> implements Edge<T> {

    private Vertex<T> target;
    private int weight;

    public AdjListEdge(Vertex<T> target, int weight){
        this.target=target;
        this.weight=weight;
    }

    @Override
    public Vertex<T> getTarget() {
        return this.target;
    }

    @Override
    public int getWeight() {
        return this.weight;
    }

}