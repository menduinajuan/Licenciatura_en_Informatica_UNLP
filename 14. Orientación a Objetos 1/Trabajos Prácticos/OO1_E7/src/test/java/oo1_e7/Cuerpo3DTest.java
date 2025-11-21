package oo1_e7;;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class Cuerpo3DTest {

    private Cuerpo3D cilindro;
    private Cuerpo3D prisma;

    @BeforeEach
    public void setUp() throws Exception {
        Circulo circulo=new Circulo();
        circulo.setRadio(3);
        Cuadrado cuadrado=new Cuadrado();
        cuadrado.setLado(3);
        cilindro=new Cuerpo3D();
        cilindro.setAltura(5);
        cilindro.setCaraBasal(circulo);
        prisma=new Cuerpo3D();
        prisma.setAltura(7);
        prisma.setCaraBasal(cuadrado);
    }

    @Test
    public void testAltura() {
        assertEquals(5, cilindro.getAltura());
        assertEquals(7, prisma.getAltura());
    }

    @Test
    public void testVolumen() {
        assertEquals(28.2743*5, cilindro.getVolumen(), 0.001);
        assertEquals(9*7, prisma.getVolumen());
    }

    @Test
    public void testSuperficieExterior() {
        assertEquals(2*28.2743+18.8496*5, cilindro.getSuperficieExterior(), 0.001);
        assertEquals(2*9+12*7, prisma.getSuperficieExterior());
    }

}