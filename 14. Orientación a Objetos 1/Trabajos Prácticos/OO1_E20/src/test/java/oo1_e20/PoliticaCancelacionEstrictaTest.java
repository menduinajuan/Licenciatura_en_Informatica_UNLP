package oo1_e20;

import org.junit.jupiter.api.*;
import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;

public class PoliticaCancelacionEstrictaTest {

    private Propiedad propiedad;
    private PoliticaCancelacionEstricta politica;

    @BeforeEach
    public void setUp() throws Exception {
        this.politica=new PoliticaCancelacionEstricta();
        this.propiedad=new Propiedad("Casa Menduiña", "13 22", 100, this.politica);
    }

    @Test
    public void testReembolso() {
        Usuario usuario=new Usuario("Juan Menduiña", "13 22", 37102205);
        DateLapse dateLapse=new DateLapse(LocalDate.now().plusDays(1), LocalDate.now().plusDays(10));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals(0, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));
    }

}