package oo1_e4;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.time.LocalDate;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class BalanzaTest {

    private Balanza balanza;
    private Producto queso;
    private Producto jamon;

    @BeforeEach
    public void setUp() throws Exception {
        balanza=new Balanza();
        queso=new Producto();
        queso.setPeso(0.1);
        queso.setPrecioPorKilo(140);
        queso.setDescripcion("Queso");
        jamon=new Producto();
        jamon.setPeso(0.1);
        jamon.setPrecioPorKilo(90);
        jamon.setDescripcion("Jamón");
    }

    @Test
    public void testConstructor() {
        assertEquals(0, balanza.getPesoTotal());
        assertEquals(0, balanza.getPrecioTotal());
        assertEquals(0, balanza.getCantidadDeProductos());
    }

    @Test
    public void testCantidadDeProductos() {
        assertEquals(0, balanza.getCantidadDeProductos());
        balanza.agregarProducto(queso);
        assertEquals(1, balanza.getCantidadDeProductos());
        balanza.agregarProducto(jamon);
        assertEquals(2, balanza.getCantidadDeProductos());
    }

    @Test
    public void testPrecioTotal() {
        assertEquals(0, balanza.getPrecioTotal());
        balanza.agregarProducto(queso);
        assertEquals(14, balanza.getPrecioTotal());
        balanza.agregarProducto(jamon);
        assertEquals(23, balanza.getPrecioTotal());
    }

    @Test
    public void testPesoTotal() {
        assertEquals(0, balanza.getPesoTotal());
        balanza.agregarProducto(queso);
        assertEquals(0.1, balanza.getPesoTotal());
        balanza.agregarProducto(jamon);
        assertEquals(0.2, balanza.getPesoTotal());
    }

    @Test
    public void testPonerEnCero() {
        balanza.agregarProducto(queso);
        balanza.ponerEnCero();
        assertEquals(0, balanza.getPesoTotal());
        assertEquals(0, balanza.getPrecioTotal());
        assertEquals(0, balanza.getCantidadDeProductos());
    }

    @Test
    public void testAgregarProducto() {
        balanza.agregarProducto(queso);
        assertEquals(0.1, balanza.getPesoTotal());
        assertEquals(14, balanza.getPrecioTotal());
        assertEquals(1, balanza.getCantidadDeProductos());
        balanza.agregarProducto(jamon);
        assertEquals(0.2, balanza.getPesoTotal());
        assertEquals(23, balanza.getPrecioTotal());
        assertEquals(2, balanza.getCantidadDeProductos());
    }

    @Test
    public void testEmitirTicket() {
        balanza.agregarProducto(queso);
        balanza.agregarProducto(jamon);
        Ticket ticket=balanza.emitirTicket();
        assertEquals(0.2, ticket.getPesoTotal());
        assertEquals(23, ticket.getPrecioTotal());
        assertEquals(2, ticket.getCantidadDeProductos());
        assertEquals(23*0.21, ticket.impuesto());
        assertEquals(LocalDate.now(), ticket.getFecha());
        queso.setPrecioPorKilo(200);
        jamon.setPrecioPorKilo(160);
        assertEquals(23, ticket.getPrecioTotal());
    }

}