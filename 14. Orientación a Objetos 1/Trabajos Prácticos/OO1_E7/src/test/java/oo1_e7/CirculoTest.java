package oo1_e7;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CirculoTest {

    private Circulo circulo;

    @BeforeEach
    public void setUp() throws Exception {
        this.circulo=new Circulo();
        this.circulo.setRadio(3);
    }

    @Test
    public void testDiametro() {
        assertEquals(6, this.circulo.getDiametro());
    }

    @Test
    public void testRadio() {
        assertEquals(3, this.circulo.getRadio());
    }

    @Test
    public void testPerimetro() {
        assertEquals(18.85, this.circulo.getPerimetro(), 0.01);
    }

    @Test
    public void testArea() {
        assertEquals(28.27, this.circulo.getArea(), 0.01);
    }

}