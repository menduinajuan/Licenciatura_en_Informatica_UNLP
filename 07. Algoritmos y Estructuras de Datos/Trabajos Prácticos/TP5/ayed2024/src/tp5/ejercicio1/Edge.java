package tp5.ejercicio1;

public interface Edge<T> {
	
	/**
	 * Retorna el vértice destino de la arista.
	 * 
	 * @return
	 */
	public Vertex<T> getTarget();
	
	/**
	 * Retorna el peso de la arista
	 * 
	 * @return
	 */
	public int getWeight();

}
