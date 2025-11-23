package oo1_e2;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ProductoTest {

    private Producto queso;

    @BeforeEach
    public void setUp() throws Exception {
        this.queso=new Producto();
    }

    @Test
    public void testPeso() {
        this.queso.setPeso(100);
        assertEquals(100, this.queso.getPeso());
    }

    @Test
    public void testPrecioPorKilo() {
        this.queso.setPrecioPorKilo(100);
        assertEquals(100, this.queso.getPrecioPorKilo());
    }

    @Test
    public void testDescripcion() {
        this.queso.setDescripcion("Queso crema");
        assertEquals("Queso crema", this.queso.getDescripcion());
    }

    @Test
    public void testPrecio() {
        this.queso.setPeso(0.1);
        this.queso.setPrecioPorKilo(140);
        assertEquals(14, this.queso.getPrecio());
    }

}