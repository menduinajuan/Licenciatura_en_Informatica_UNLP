package oo1_e14;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class CilindroTest {

    private Cilindro cilindro;

    @BeforeEach
    public void setUp() throws Exception {
        this.cilindro=new Cilindro("Hierro", "Rojo", 10, 10);
    }

    @Test
    public void testConstructor() {
        assertEquals("Hierro", this.cilindro.getMaterial());
        assertEquals("Rojo", this.cilindro.getColor());
        assertEquals(10, this.cilindro.getRadio());
        assertEquals(10, this.cilindro.getAltura());
    }

    @Test
    public void testGetVolumen() {
        double volumen=Math.PI*(Math.pow(10, 2))*10;
        assertEquals(volumen, this.cilindro.getVolumen());
    }

    @Test
    public void testGetSuperficie() {
        double superficie=2*Math.PI*10*10+2*Math.PI*(Math.pow(10, 2));
        assertEquals(superficie, this.cilindro.getSuperficie());
    }

}