package oo1_e19;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class PropiedadTest {

    private Propiedad propiedad;

    @BeforeEach
    public void setUp() throws Exception {
        this.propiedad=new Propiedad("Casa Menduiña", "13 22", 100);
    }

    @Test
    public void testConstructor() {
        assertEquals("Casa Menduiña", this.propiedad.getNombre());
        assertEquals("13 22", this.propiedad.getDireccion());
        assertEquals(100, this.propiedad.getPrecioNoche());
    }

    

}