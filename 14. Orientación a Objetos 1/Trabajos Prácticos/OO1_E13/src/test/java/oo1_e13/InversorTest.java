package oo1_e13;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import org.junit.jupiter.api.*;

public class InversorTest {

    private Inversor inversor;
    private InversionAccion inversionAccion;
    private InversionPlazoFijo inversionPlazoFijo;

    @BeforeEach
    public void setUp() throws Exception {
        this.inversor=new Inversor("Matias");
        this.inversionAccion=new InversionAccion("BTC", 1, 100000);
        this.inversionPlazoFijo=new InversionPlazoFijo(LocalDate.of(2025, 1, 1), 100000, 1);
    }

    @Test
    public void testAgregarSacarInversion() {
        assertEquals(0, this.inversor.getInversiones().size());
        this.inversor.agregarInversion(this.inversionAccion);
        assertEquals(1, this.inversor.getInversiones().size());
        this.inversor.agregarInversion(this.inversionPlazoFijo);
        assertEquals(2, this.inversor.getInversiones().size());
        this.inversor.sacarInversion(this.inversionPlazoFijo);
        assertEquals(1, this.inversor.getInversiones().size());
        this.inversor.sacarInversion(this.inversionAccion);
        assertEquals(0, this.inversor.getInversiones().size());
    }

    @Test
    public void testValorActualInversiones() {

        double valorActualInversiones=0;

        // Sin agregar inversiones
        assertEquals(valorActualInversiones, this.inversor.valorActualInversiones());    // valorActualInversiones=0

        // Agregando dos inversiones
        this.inversor.agregarInversion(this.inversionAccion);
        this.inversor.agregarInversion(this.inversionPlazoFijo);
        valorActualInversiones=this.inversionAccion.valorActual()+this.inversionPlazoFijo.valorActual();
        assertEquals(valorActualInversiones, this.inversor.valorActualInversiones());    // valorActualInversiones=100000+XXX

        // Sacando una inversión
        this.inversor.sacarInversion(this.inversionPlazoFijo);
        valorActualInversiones-=this.inversionPlazoFijo.valorActual();
        assertEquals(valorActualInversiones, this.inversor.valorActualInversiones());    // valorActualInversiones=100000

    }

}