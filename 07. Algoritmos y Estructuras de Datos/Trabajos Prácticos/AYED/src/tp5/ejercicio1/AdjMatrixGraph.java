package tp5.ejercicio1;

import java.util.*;

public class AdjMatrixGraph<T> implements Graph<T> {

    private static final int EMPTY_VALUE=0;
    private int maxVertices;
    private List<AdjMatrixVertex<T>> vertices;
    private int[][] adjMatrix;

    public AdjMatrixGraph(int maxVert) {
        this.maxVertices=maxVert;
        this.vertices=new ArrayList<>();
        this.adjMatrix=new int[this.maxVertices][this.maxVertices];
        for (int i=0; i<this.maxVertices; i++)
            for (int j=0; j<this.maxVertices; j++)
            	this.adjMatrix[i][j]=EMPTY_VALUE;
    }

    @Override
    public Vertex<T> createVertex(T data) {
    	if (this.vertices.size()==this.maxVertices)
            return null;
    	AdjMatrixVertex<T> vertice=new AdjMatrixVertex<>(data, this.vertices.size());
    	this.vertices.add(vertice);
    	return vertice;
    }

    @Override
    public void removeVertex(Vertex<T> vertex) {
    	if (!this.vertices.remove(vertex))
            return;
        int index=vertex.getPosition();
        int total=this.vertices.size();
        for (int fila=index; fila<total; fila++)
            this.adjMatrix[fila]=this.adjMatrix[fila+1];
        for (int fila=0; fila<total; fila++)
            for (int col=index; col<total; col++)
            	this.adjMatrix[fila][col]=this.adjMatrix[fila][col+1];
        for (int fila=index; fila<total; fila++)
            this.vertices.get(fila).decrementPosition();
        for (int col=0; col<total; col++)
            this.adjMatrix[total][col]=EMPTY_VALUE;
        for (int fila=0; fila<total; fila++)
            this.adjMatrix[fila][total]=EMPTY_VALUE;
    }

    @Override
    public Vertex<T> search(T data) {
        for (Vertex<T> vertice: this.vertices)
            if (vertice.getData().equals(data))
                return vertice;
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
    	connect(origin, destination, 1);
    }

    @Override
    public void connect(Vertex<T> origin, Vertex<T> destination, int weight) {
    	if (this.belongs(origin) && this.belongs(destination))
            this.adjMatrix[((AdjMatrixVertex<T>) origin).getPosition()][((AdjMatrixVertex<T>) destination).getPosition()]=weight;
    }

    @Override
    public void disconnect(Vertex<T> origin, Vertex<T> destination) {
    	if (this.belongs(origin))
            this.connect(origin, destination, EMPTY_VALUE);
    }

    @Override
    public boolean existsEdge(Vertex<T> origin, Vertex<T> destination) {
        return this.weight(origin, destination)!=EMPTY_VALUE;
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
    	int weight=0;
    	if (this.belongs(origin) && this.belongs(destination))
            weight=this.adjMatrix[((AdjMatrixVertex<T>) origin).getPosition()][((AdjMatrixVertex<T>) destination).getPosition()];
   	return weight;
    }

    @Override
    public List<Edge<T>> getEdges(Vertex<T> v) {
        List<Edge<T>> ady=new ArrayList<>();
        int veticePos=v.getPosition();
        for (int i=0; i<this.vertices.size(); i++)
            if (this.adjMatrix[veticePos][i]!=EMPTY_VALUE)
                ady.add(new AdjMatrixEdge<>(this.vertices.get(i), adjMatrix[veticePos][i]));
        return ady;
    }

    @Override
    public Vertex<T> getVertex(int position) {
    	if ((position<0) || (position>=this.vertices.size()))
            return null;
        return this.vertices.get(position);
    }

    @Override
    public int getSize() {
    	return this.vertices.size();
    }

}