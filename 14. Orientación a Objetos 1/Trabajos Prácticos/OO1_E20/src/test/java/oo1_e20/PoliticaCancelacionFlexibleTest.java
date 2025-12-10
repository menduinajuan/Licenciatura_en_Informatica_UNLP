package oo1_e20;

import org.junit.jupiter.api.*;
import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;

public class PoliticaCancelacionFlexibleTest {

    private Propiedad propiedad;
    private PoliticaCancelacionFlexible politica;

    @BeforeEach
    public void setUp() throws Exception {
        this.politica=new PoliticaCancelacionFlexible();
        this.propiedad=new Propiedad("Casa Menduiña", "13 22", 100, this.politica);
    }

    @Test
    public void testReembolso() {

        Usuario usuario=new Usuario("Juan Menduiña", "13 22", 37102205);
        DateLapse dateLapse;
        double reembolso;
        int from, to;

        // Reembolso 100%
        reembolso=1;
        from=1; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

        // Reembolso 0%
        reembolso=0;
        from=0; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);    // No es posible crear un reserva con fecha de inicio actual
        //assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

    }

}