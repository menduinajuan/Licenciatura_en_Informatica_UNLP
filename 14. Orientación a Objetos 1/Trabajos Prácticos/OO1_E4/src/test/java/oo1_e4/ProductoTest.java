package oo1_e4;

import oo1_e4.Producto;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ProductoTest {

    private Producto queso;

    @BeforeEach
    public void setUp() throws Exception {
        queso=new Producto();
    }

    @Test
    public void testPeso() {
        queso.setPeso(100);
        assertEquals(100, queso.getPeso());
    }

    @Test
    public void testPrecioPorKilo() {
        queso.setPrecioPorKilo(100);
        assertEquals(100, queso.getPrecioPorKilo());
    }

    @Test
    public void testDescripcion() {
        queso.setDescripcion("Queso crema");
        assertEquals("Queso crema", queso.getDescripcion());
    }

    @Test
    public void testPrecio() {
        queso.setPeso(0.1);
        queso.setPrecioPorKilo(140);
        assertEquals(14, queso.getPrecio());
    }

}