package ar.edu.unlp.info.oo1.balanzaElectronica;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ProductoTest {

  private Producto queso;
  
  @BeforeEach
  void setUp() {
    // El producto se crea asignandole la descripción, el peso y el precio.
    // En este ejemplo, el peso es en kilos, lo mismo que su precio
    queso = new Producto("Queso crema", 0.200, 14);
  }

  @Test
  void testDescripcion() {
    assertEquals("Queso crema", queso.getDescripcion());
  }

  @Test
  void testPeso() {
    assertEquals(0.2, queso.getPeso());
  }

  @Test
  void testPrecioPorKilo() {
    assertEquals(14, queso.getPrecioPorKilo());
  }

  @Test
  void testPrecio() {
    assertEquals(2.8, queso.getPrecio(), 0.1);
  }

  @Test
  void testSetPrecioPorKilo() {
    queso.setPrecioPorKilo(20.3);
    assertEquals(20.3, queso.getPrecioPorKilo(), 0.1);
  }
}
