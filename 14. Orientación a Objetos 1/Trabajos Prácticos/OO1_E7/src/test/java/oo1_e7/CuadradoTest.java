package oo1_e7;;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CuadradoTest {

    private Cuadrado cuadrado;

    @BeforeEach
    public void setUp() throws Exception {
        this.cuadrado=new Cuadrado();
        this.cuadrado.setLado(3);
    }

    @Test
    public void testLado() {
        assertEquals(3, this.cuadrado.getLado());
    }

    @Test
    public void testPerimetro() {
        assertEquals(12, this.cuadrado.getPerimetro());
    }

    @Test
    public void testArea() {
        assertEquals(9, this.cuadrado.getArea());
    }

}