package ar.edu.unlp.info.oo1.balanzaElectronica;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class BalanzaTest {
 
  private Balanza balanza;
  
  private Producto queso;
  
  private Producto jamon;
  
  @BeforeEach
  void setUp() {
    balanza = new Balanza();
    queso = new Producto("Queso", 0.1, 140);
    jamon = new Producto("Jamón", 0.1, 90);
  }

  @Test
  void testAgregarProducto() {

    balanza.agregarProducto(queso);
    assertEquals(0.1, balanza.getPesoTotal(), 0.1);
    assertEquals(14, balanza.getPrecioTotal(), 0.1);
    assertEquals(1, balanza.getCantidadDeProductos());

    balanza.agregarProducto(jamon);
    assertEquals(0.2, balanza.getPesoTotal(), 0.1);
    assertEquals(23, balanza.getPrecioTotal(), 0.1);
    assertEquals(2, balanza.getCantidadDeProductos());
  }

  @Test
  void testCantidadDeProductos() {
    assertEquals(0, balanza.getCantidadDeProductos());
    balanza.agregarProducto(queso);
    assertEquals(1, balanza.getCantidadDeProductos());
    balanza.agregarProducto(jamon);
    assertEquals(2, balanza.getCantidadDeProductos());
  }  
  
  @Test
  void testEmitirTicket() {
    balanza.agregarProducto(queso);
    balanza.agregarProducto(jamon);
    Ticket ticket = balanza.emitirTicket();
    assertEquals(0.2, ticket.getPesoTotal(), 0.1);
    assertEquals(23, ticket.getPrecioTotal(), 0.1);
    assertEquals(2, ticket.getCantidadDeProductos());
    assertEquals(23 * 0.21, ticket.impuesto(), 0.1);
    assertEquals(LocalDate.now(), ticket.getFecha());

    // Cambios de precios no tienen que afectar a tickets emitidos
    queso.setPrecioPorKilo(200);
    jamon.setPrecioPorKilo(160);
    assertEquals(23, ticket.getPrecioTotal(), 0.1);
  }

  @Test
  void testConstructor() {
    assertEquals(0, balanza.getPesoTotal());
    assertEquals(0, balanza.getPrecioTotal());
    assertEquals(0, balanza.getCantidadDeProductos());
  }

  @Test
  void testPesoTotal() {
    assertEquals(0, balanza.getPesoTotal());
    balanza.agregarProducto(queso);
    assertEquals(0.1, balanza.getPesoTotal(), 0.1);
    balanza.agregarProducto(jamon);
    assertEquals(0.2, balanza.getPesoTotal(), 0.1);
  }  

  @Test
  void testPonerEnCero() {
    balanza.agregarProducto(queso);
    balanza.ponerEnCero();
    assertEquals(0, balanza.getPesoTotal());
    assertEquals(0, balanza.getPrecioTotal());
    assertEquals(0, balanza.getCantidadDeProductos());
  }  

  @Test
  void testPrecioTotal() {
    assertEquals(0, balanza.getPrecioTotal());
    balanza.agregarProducto(queso);
    assertEquals(14, balanza.getPrecioTotal(), 0.1);
    balanza.agregarProducto(jamon);
    assertEquals(23, balanza.getPrecioTotal(), 0.1);
  }
}
