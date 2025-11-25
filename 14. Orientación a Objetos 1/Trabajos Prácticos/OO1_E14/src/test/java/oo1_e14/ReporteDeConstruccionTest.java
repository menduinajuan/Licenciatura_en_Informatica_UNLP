package oo1_e14;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class ReporteDeConstruccionTest {

    private ReporteDeConstruccion reporte;
    private Cilindro cilindro;
    private Esfera esfera;
    private PrismaRectangular prismaRectangular;

    @BeforeEach
    public void setUp() throws Exception {
        this.reporte=new ReporteDeConstruccion();
        this.cilindro=new Cilindro("Hierro", "Rojo", 10, 10);
        this.esfera=new Esfera("Acero", "Amarillo", 10);
        this.prismaRectangular=new PrismaRectangular("Hierro", "Rojo", 10, 5, 5);
    }

    @Test
    public void testAgregarSacarPieza() {
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

        double volumen=0;

        // Sin agregar piezas
        assertEquals(volumen, this.reporte.volumenDeMaterial("Hierro"));

        // Agregando tres piezas
        this.reporte.agregarPieza(this.cilindro);
        this.reporte.agregarPieza(this.esfera);
        this.reporte.agregarPieza(this.prismaRectangular);
        volumen=this.cilindro.getVolumen()+this.prismaRectangular.getVolumen();
        assertEquals(volumen, this.reporte.volumenDeMaterial("Hierro"));

        // Sacando una pieza
        this.reporte.sacarPieza(this.prismaRectangular);
        volumen-=this.prismaRectangular.getVolumen();
        assertEquals(volumen, this.reporte.volumenDeMaterial("Hierro"));

    }

    @Test
    public void testSuperficieDeColor() {

        double superficie=0;

        // Sin agregar piezas
        assertEquals(superficie, this.reporte.superficieDeColor("Rojo"));

        // Agregando tres piezas
        this.reporte.agregarPieza(this.cilindro);
        this.reporte.agregarPieza(this.esfera);
        this.reporte.agregarPieza(this.prismaRectangular);
        superficie=cilindro.getSuperficie()+this.prismaRectangular.getSuperficie();
        assertEquals(superficie, this.reporte.superficieDeColor("Rojo"));

        // Sacando una pieza
        this.reporte.sacarPieza(this.prismaRectangular);
        superficie-=this.prismaRectangular.getSuperficie();
        assertEquals(superficie, this.reporte.superficieDeColor("Rojo"));

    }

}