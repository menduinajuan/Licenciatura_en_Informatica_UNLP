package tp5.ejercicio1.adjMatrix;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class GraphTest {
	AdjMatrixGraph<Integer> grafo;
	Vertex<Integer> vert1;
	Vertex<Integer> vert2;
	Vertex<Integer> vert3;

	@Before
	public void setUp() throws Exception {
		grafo = new AdjMatrixGraph<Integer>(10);
		// Grafo inicial
		// (2)  <-->  (1)  --> (3)
		vert1 = grafo.createVertex(1);
		vert2 = grafo.createVertex(2);
		vert3 = grafo.createVertex(3);
		grafo.connect(vert1, vert2);
		grafo.connect(vert1, vert3);
		grafo.connect(vert2, vert1);
	}

	@Test
	public void testCreateAndRemoveVertex() {
		Graph<Integer> grafoVacio = new AdjMatrixGraph<>(10);
		assertEquals(0, grafoVacio.getVertices().size());
		assertEquals(3, grafo.getVertices().size());
		
		assertEquals(0, vert1.getPosition());
		assertEquals(1, vert2.getPosition());
		assertEquals(2, vert3.getPosition());

		assertEquals(2, grafo.getEdges(vert1).size());

		Vertex<Integer> vert4 = grafo.createVertex(4);
		assertEquals(4, grafo.getVertices().size());
		assertEquals(3, vert4.getPosition());
		
		grafo.removeVertex(vert2);
		assertEquals(3, grafo.getVertices().size());
		assertEquals(1, vert3.getPosition());
		assertEquals(2, vert4.getPosition());

		assertEquals(1, grafo.getEdges(vert1).size());

		grafo.connect(vert4, vert1);
		grafo.connect(vert3, vert4);
		grafo.removeVertex(vert4);

		Vertex<Integer> vert5 = grafo.createVertex(5);
		assertTrue(grafo.getEdges(vert5).isEmpty());
		assertTrue(grafo.getEdges(vert3).isEmpty());
	}

	@Test
	public void testConnectAndDisconnect() {
		List<Edge<Integer>> adyacentes = grafo.getEdges(vert1);
		assertEquals(2, adyacentes.size());
		assertEquals(1, adyacentes.get(0).getWeight());
		assertEquals(1, adyacentes.get(1).getWeight());
		
		assertTrue(vert2.equals(adyacentes.get(0).getTarget())
			|| vert3.equals(adyacentes.get(0).getTarget()));
		assertTrue(vert2.equals(adyacentes.get(1).getTarget())
				|| vert3.equals(adyacentes.get(1).getTarget()));
	
		Graph<Integer> otherGraph = new AdjMatrixGraph<>(5);
		Vertex<Integer> otherVertex = otherGraph.createVertex(1);
		grafo.connect(vert1, otherVertex);
		// la conexión con vertices ajenos no se considera
		assertEquals(2, grafo.getEdges(vert1).size());
		grafo.connect(otherVertex, vert1);
		assertEquals(2, grafo.getEdges(vert1).size());
				
		grafo.disconnect(vert1, vert2);
		adyacentes = grafo.getEdges(vert1);
		assertEquals(1, adyacentes .size());
		assertTrue(vert3.equals(adyacentes.get(0).getTarget()));
	}

	@Test
	public void testExistsEdge() {
		assertTrue(grafo.existsEdge(vert1,vert2));
		assertTrue(grafo.existsEdge(vert2,vert1));
		assertTrue(grafo.existsEdge(vert1,vert3));
		assertFalse(grafo.existsEdge(vert3,vert1));
		assertFalse(grafo.existsEdge(vert2,vert3));
	}

	@Test
	public void testIsEmpty() {
		assertTrue(new AdjMatrixGraph<Integer>(10).isEmpty());
		assertFalse(grafo.isEmpty());
	}

	@Test
	public void testWeight() {
		grafo.connect(vert3, vert2, 5);
		assertEquals(1, grafo.weight(vert1, vert2));
		assertEquals(5, grafo.weight(vert3, vert2));
		assertEquals(0, grafo.weight(vert3, vert1));
	}
	
	@Test
	public void testSearch() {
		assertEquals(vert1, grafo.search(1));
		assertNull(grafo.search(5));
	}
	
	@Test
	public void testGetPosition() {
		assertEquals(1, vert2.getPosition());
	}
	
	@Test
	public void testGetVertex() {
		assertEquals(vert1, grafo.getVertex(vert1.getPosition()));
		assertNull(grafo.getVertex(-3));
		assertNull(grafo.getVertex(30));
	}
	
	@Test
	public void testGetSetData() {
		assertEquals(1, vert1.getData());
		vert1.setData(5);
		assertEquals(5, vert1.getData());
	}
	
	@Test
	public void testSize() {
		assertEquals(3, grafo.getSize());
	}
}
