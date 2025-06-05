package tp5.ejercicio1;

import java.util.List;

public interface Graph<T> {

	/**
	 * Crea un vértice con el dato recibido y lo retorna.
	 * 
	 * @param dato Dato que contendrá el nuevo vértice
	 */
	public Vertex<T> createVertex(T data);
	
	/**
	 * Elimina el vértice del Grafo.
	 * En caso que el vértice esté relacionado con otros, estas relaciones también se eliminan.
	 * 
	 * @param vertice Vértice a eliminar
	 */
	public void removeVertex(Vertex<T> vertex);
	
	/**
	 * Busca y retorna el primer vértice cuyo dato es igual al parámetro recibido.
	 * Retorna null si no existe tal.
	 * 
	 * @param dato Contenido del vértice
	 * @return Vertice o null si no existe tal
	 */
	public Vertex<T> search(T data);
	
	/**
	 * Conecta el vértice origen con el vértice destino.
	 * Verifica que ambos vértices existan, caso contrario no realiza ninguna conexión.
	 * 
	 * @param origen
	 * @param destino
	 */
	public void connect(Vertex<T> origin, Vertex<T> destination);
	
	/**
	 * Conecta el vertice origen con el destino con peso.
	 * Verifica que ambos vertices existan, caso contrario no realiza ninguna conexion
	 * 
	 * @param origen
	 * @param destino
	 * @param peso
	 */
	public void connect(Vertex<T> origin, Vertex<T> destination, int weight);
	
	/**
	 * Desconecta el vértice origen con el destino.
	 * Verifica que ambos vértices existan, caso contrario no realiza ninguna desconexión
	 * En caso de existir la conexión destino-->origen, esta permanecerá sin cambios. 
	 * 
	 * @param origen
	 * @param destino
	 */
	public void disconnect(Vertex<T> origin, Vertex<T> destination);
	
	/**
	 * Retorna true si existe una arista entre el vértice origen y el destino.
	 * 
	 * @param origen
	 * @param destino
	 * @return
	 */
	public boolean existsEdge(Vertex<T> origin, Vertex<T> destination);
	
	/**
	 * Retorna el peso entre dos vértices.
	 * En caso de no existir la arista retorna 0.
	 * 
	 * @param origen
	 * @param destino
	 * @return
	 */
	public int weight(Vertex<T> origin, Vertex<T> destination);

	/**
	 * Retorna si el grafo no contiene datos (sin vértices creados).
	 * 
	 * @return
	 */
	public boolean isEmpty();
	
	/**
	 * Retorna la lista de vértices.
	 * 
	 * @return
	 */
	public List<Vertex<T>> getVertices();
		
	/**
	 * Retorna la lista de adyacentes al vértice recibido.
	 * 
	 * @param v
	 * @return
	 */
	public List<Edge<T>> getEdges(Vertex<T> v);
	
	/**
	 * Obtiene el vértice para la posición recibida.
	 * 
	 * @param position
	 * @return
	 */
	public Vertex<T> getVertex(int position);
	
	/**
	 * Retorna la cantidad de vértices del grafo
	 * 
	 * @return
	 */
	public int getSize();

}
