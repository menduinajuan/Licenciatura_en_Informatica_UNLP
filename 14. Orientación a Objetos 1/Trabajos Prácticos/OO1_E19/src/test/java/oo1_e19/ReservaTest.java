package oo1_e19;

import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class ReservaTest {

    private DateLapse dateLapse;
    private Propiedad propiedad;
    private Reserva reserva;

    @BeforeEach
    public void setUp() throws Exception {
        this.dateLapse=new DateLapse(LocalDate.of(2025, 1, 1), LocalDate.of(2025, 1, 31));
        this.propiedad=new Propiedad("Casa Menduiña", "13 22", 100);
        this.reserva=new Reserva(this.dateLapse, this.propiedad);
    }

    @Test
    public void testConstructor() {
        assertEquals(this.dateLapse, this.reserva.getDateLapse());
        assertEquals(this.propiedad, this.reserva.getPropiedad());
    }

    

}