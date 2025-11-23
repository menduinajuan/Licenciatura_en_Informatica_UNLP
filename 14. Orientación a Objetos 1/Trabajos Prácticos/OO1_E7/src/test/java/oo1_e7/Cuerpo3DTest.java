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
        this.cilindro=new Cuerpo3D();
        this.cilindro.setAltura(5);
        this.cilindro.setCaraBasal(circulo);
        this.prisma=new Cuerpo3D();
        this.prisma.setAltura(7);
        this.prisma.setCaraBasal(cuadrado);
    }

    @Test
    public void testAltura() {
        assertEquals(5, this.cilindro.getAltura());
        assertEquals(7, this.prisma.getAltura());
    }

    @Test
    public void testVolumen() {
        assertEquals(28.2743*5, this.cilindro.getVolumen(), 0.001);
        assertEquals(9*7, this.prisma.getVolumen());
    }

    @Test
    public void testSuperficieExterior() {
        assertEquals(2*28.2743+18.8496*5, this.cilindro.getSuperficieExterior(), 0.001);
        assertEquals(2*9+12*7, this.prisma.getSuperficieExterior());
    }

}