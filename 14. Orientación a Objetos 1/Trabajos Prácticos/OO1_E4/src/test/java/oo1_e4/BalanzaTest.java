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
        this.balanza=new Balanza();
        this.queso=new Producto();
        this.queso.setPeso(0.1);
        this.queso.setPrecioPorKilo(140);
        this.queso.setDescripcion("Queso");
        this.jamon=new Producto();
        this.jamon.setPeso(0.1);
        this.jamon.setPrecioPorKilo(90);
        this.jamon.setDescripcion("Jamón");
    }

    @Test
    public void testConstructor() {
        assertEquals(0, this.balanza.getPesoTotal());
        assertEquals(0, this.balanza.getPrecioTotal());
        assertEquals(0, this.balanza.getCantidadDeProductos());
    }

    @Test
    public void testCantidadDeProductos() {
        assertEquals(0, this.balanza.getCantidadDeProductos());
        this.balanza.agregarProducto(this.queso);
        assertEquals(1, this.balanza.getCantidadDeProductos());
        this.balanza.agregarProducto(this.jamon);
        assertEquals(2, this.balanza.getCantidadDeProductos());
    }

    @Test
    public void testPrecioTotal() {
        assertEquals(0, this.balanza.getPrecioTotal());
        this.balanza.agregarProducto(this.queso);
        assertEquals(14, this.balanza.getPrecioTotal());
        this.balanza.agregarProducto(this.jamon);
        assertEquals(23, this.balanza.getPrecioTotal());
    }

    @Test
    public void testPesoTotal() {
        assertEquals(0, this.balanza.getPesoTotal());
        this.balanza.agregarProducto(this.queso);
        assertEquals(0.1, this.balanza.getPesoTotal());
        this.balanza.agregarProducto(this.jamon);
        assertEquals(0.2, this.balanza.getPesoTotal());
    }

    @Test
    public void testPonerEnCero() {
        this.balanza.agregarProducto(this.queso);
        this.balanza.ponerEnCero();
        assertEquals(0, this.balanza.getPesoTotal());
        assertEquals(0, this.balanza.getPrecioTotal());
        assertEquals(0, this.balanza.getCantidadDeProductos());
    }

    @Test
    public void testAgregarProducto() {
        this.balanza.agregarProducto(this.queso);
        assertEquals(0.1, this.balanza.getPesoTotal());
        assertEquals(14, this.balanza.getPrecioTotal());
        assertEquals(1, this.balanza.getCantidadDeProductos());
        this.balanza.agregarProducto(this.jamon);
        assertEquals(0.2, this.balanza.getPesoTotal());
        assertEquals(23, this.balanza.getPrecioTotal());
        assertEquals(2, this.balanza.getCantidadDeProductos());
    }

    @Test
    public void testEmitirTicket() {
        this.balanza.agregarProducto(this.queso);
        this.balanza.agregarProducto(this.jamon);
        Ticket ticket=this.balanza.emitirTicket();
        assertEquals(0.2, ticket.getPesoTotal());
        assertEquals(23, ticket.getPrecioTotal());
        assertEquals(2, ticket.getCantidadDeProductos());
        assertEquals(23*0.21, ticket.impuesto());
        assertEquals(LocalDate.now(), ticket.getFecha());
        this.queso.setPrecioPorKilo(200);
        this.jamon.setPrecioPorKilo(160);
        assertEquals(23, ticket.getPrecioTotal());
    }

}