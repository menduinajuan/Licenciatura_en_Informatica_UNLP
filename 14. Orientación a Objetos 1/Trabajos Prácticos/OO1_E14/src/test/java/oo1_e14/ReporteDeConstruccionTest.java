package oo1_e14;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class ReporteDeConstruccionTest {

    private ReporteDeConstruccion reporte;

    @BeforeEach
    public void setUp() throws Exception {
        this.reporte=new ReporteDeConstruccion();
    }

    @Test
    public void testAgregarSacarPieza() {
        Cilindro cilindro=new Cilindro("Hierro", "Rojo", 10, 10);
        Esfera esfera=new Esfera("Acero", "Amarillo", 10);
        assertEquals(0, this.reporte.getPiezas().size());
        this.reporte.agregarPieza(cilindro);
        assertEquals(1, this.reporte.getPiezas().size());
        this.reporte.agregarPieza(esfera);
        assertEquals(2, this.reporte.getPiezas().size());
        this.reporte.sacarPieza(esfera);
        assertEquals(1, this.reporte.getPiezas().size());
        this.reporte.sacarPieza(cilindro);
        assertEquals(0, this.reporte.getPiezas().size());
    }

    @Test
    public void testVolumenDeMaterial() {

        Cilindro cilindro=new Cilindro("Hierro", "Rojo", 10, 10);
        Esfera esfera=new Esfera("Acero", "Amarillo", 10);
        PrismaRectangular prismaRectangular=new PrismaRectangular("Hierro", "Rojo", 10, 5, 5);
        double volumen=0;

        // Sin agregar piezas
        assertEquals(volumen, this.reporte.volumenDeMaterial("Hierro"));

        // Agregando tres piezas
        this.reporte.agregarPieza(cilindro);
        this.reporte.agregarPieza(esfera);
        this.reporte.agregarPieza(prismaRectangular);
        volumen=cilindro.getVolumen()+prismaRectangular.getVolumen();
        assertEquals(volumen, this.reporte.volumenDeMaterial("Hierro"));

        // Sacando una pieza
        this.reporte.sacarPieza(prismaRectangular);
        volumen-=prismaRectangular.getVolumen();
        assertEquals(volumen, this.reporte.volumenDeMaterial("Hierro"));

    }

    @Test
    public void testSuperficieDeColor() {

        Cilindro cilindro=new Cilindro("Hierro", "Rojo", 10, 10);
        Esfera esfera=new Esfera("Acero", "Amarillo", 10);
        PrismaRectangular prismaRectangular=new PrismaRectangular("Hierro", "Rojo", 10, 5, 5);
        double superficie=0;

        // Sin agregar piezas
        assertEquals(superficie, this.reporte.superficieDeColor("Rojo"));

        // Agregando tres piezas
        this.reporte.agregarPieza(cilindro);
        this.reporte.agregarPieza(esfera);
        this.reporte.agregarPieza(prismaRectangular);
        superficie=cilindro.getSuperficie()+prismaRectangular.getSuperficie();
        assertEquals(superficie, this.reporte.superficieDeColor("Rojo"));

        // Sacando una pieza
        this.reporte.sacarPieza(prismaRectangular);
        superficie-=prismaRectangular.getSuperficie();
        assertEquals(superficie, this.reporte.superficieDeColor("Rojo"));

    }

}