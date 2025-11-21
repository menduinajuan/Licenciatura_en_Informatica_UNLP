package oo1_e13;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import org.junit.jupiter.api.*;

public class InversionPlazoFijoTest {

    private InversionPlazoFijo inversionPlazoFijo;

    @BeforeEach
    public void setUp() throws Exception {
        inversionPlazoFijo=new InversionPlazoFijo(LocalDate.of(2025, 01, 01), 100000, 1);
    }

    @Test
    public void testConstructor() {
        assertEquals(LocalDate.of(2025, 01, 01), this.inversionPlazoFijo.getFechaDeConstitucion());
        assertEquals(100000, this.inversionPlazoFijo.getMontoDepositado());
        assertEquals(1, this.inversionPlazoFijo.getPorcentajeDeInteresDiario());
    }

    @Test
    public void testValorActual() {
        long dias=ChronoUnit.DAYS.between(LocalDate.of(2025, 01, 01), LocalDate.now());
        double valorActual=100000*(1+(1.0/100)*dias);
        assertEquals(valorActual, this.inversionPlazoFijo.valorActual());
    }

}