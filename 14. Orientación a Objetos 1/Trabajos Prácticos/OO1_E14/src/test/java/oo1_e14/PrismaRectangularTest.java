package oo1_e14;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class PrismaRectangularTest {

    private PrismaRectangular prismaRectangular;

    @BeforeEach
    public void setUp() throws Exception {
        this.prismaRectangular=new PrismaRectangular("Hierro", "Rojo", 10, 5, 5);
    }

    @Test
    public void testConstructor() {
        assertEquals("Hierro", this.prismaRectangular.getMaterial());
        assertEquals("Rojo", this.prismaRectangular.getColor());
        assertEquals(10, this.prismaRectangular.getLadoMayor());
        assertEquals(5, this.prismaRectangular.getLadoMenor());
        assertEquals(5, this.prismaRectangular.getAltura());
    }

    @Test
    public void testGetVolumen() {
        double volumen=10*5*5;
        assertEquals(volumen, this.prismaRectangular.getVolumen());
    }

    @Test
    public void testGetSuperficie() {
        double superficie=2*(10*5+10*5+5*5);
        assertEquals(superficie, this.prismaRectangular.getSuperficie());
    }

}