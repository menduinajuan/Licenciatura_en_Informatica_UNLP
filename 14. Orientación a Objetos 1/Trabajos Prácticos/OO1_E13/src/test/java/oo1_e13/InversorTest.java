package oo1_e13;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import org.junit.jupiter.api.*;

public class InversorTest {

    private Inversor inversor;

    @BeforeEach
    public void setUp() throws Exception {
        inversor=new Inversor("Matias");
    }

    @Test
    public void testValorActualInversiones() {

        InversionAccion inversionAccion=new InversionAccion("BTC", 1, 100000);
        InversionPlazoFijo inversionPlazoFijo=new InversionPlazoFijo(LocalDate.of(2025, 01, 01), 100000, 1);
        double valorActualInversiones=0;

        // Sin agregar inversiones
        assertEquals(valorActualInversiones, this.inversor.valorActualInversiones());    // valorActualInversiones=0

        // Agregando dos inversiones
        this.inversor.agregarInversion(inversionAccion);
        this.inversor.agregarInversion(inversionPlazoFijo);
        valorActualInversiones=inversionAccion.valorActual()+inversionPlazoFijo.valorActual();
        assertEquals(valorActualInversiones, this.inversor.valorActualInversiones());    // valorActualInversiones=100000+XXX

        // Sacando una inversión
        this.inversor.sacarInversion(inversionPlazoFijo);
        valorActualInversiones-=inversionPlazoFijo.valorActual();
        assertEquals(valorActualInversiones, this.inversor.valorActualInversiones());    // valorActualInversiones=100000

    }

}