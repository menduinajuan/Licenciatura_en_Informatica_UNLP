package oo1_e13;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class InversionAccionTest {

    private InversionAccion inversionAccion;

    @BeforeEach
    public void setUp() throws Exception {
        inversionAccion=new InversionAccion("BTC", 1, 100000);
    }

    @Test
    public void testConstructor() {
        assertEquals("BTC", this.inversionAccion.getNombre());
        assertEquals(1, this.inversionAccion.getCantidad());
        assertEquals(100000, this.inversionAccion.getValorUnitario());
    }

    @Test
    public void testValorActual() {
        double valorActual=100000*1;
        assertEquals(valorActual, this.inversionAccion.valorActual());
    }

}