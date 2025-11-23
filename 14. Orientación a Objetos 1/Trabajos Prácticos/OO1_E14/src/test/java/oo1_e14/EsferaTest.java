package oo1_e14;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class EsferaTest {

    private Esfera esfera;

    @BeforeEach
    public void setUp() throws Exception {
        this.esfera=new Esfera("Acero", "Amarillo", 10);
    }

    @Test
    public void testConstructor() {
        assertEquals("Acero", this.esfera.getMaterial());
        assertEquals("Amarillo", this.esfera.getColor());
        assertEquals(10, this.esfera.getRadio());
    }

    @Test
    public void testGetVolumen() {
        double volumen=(4.0/3.0)*Math.PI*Math.pow(10, 3);
        assertEquals(volumen, this.esfera.getVolumen());
    }

    @Test
    public void testGetSuperficie() {
        double superficie=4*Math.PI*Math.pow(10, 2);
        assertEquals(superficie, this.esfera.getSuperficie());
    }

}