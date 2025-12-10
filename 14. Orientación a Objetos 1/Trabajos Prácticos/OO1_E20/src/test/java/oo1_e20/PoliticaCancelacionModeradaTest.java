package oo1_e20;

import org.junit.jupiter.api.*;
import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;

public class PoliticaCancelacionModeradaTest {

    private Propiedad propiedad;
    private PoliticaCancelacionModerada politica;

    @BeforeEach
    public void setUp() throws Exception {
        this.politica=new PoliticaCancelacionModerada();
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

        from=7; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

        from=3; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

        // Reembolso 50%

        reembolso=0.5;

        from=2; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

        from=1; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

        // Reembolso 0%

        reembolso=0;

        from=8; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);
        assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

        from=0; to=from+10;
        dateLapse=new DateLapse(LocalDate.now().plusDays(from), LocalDate.now().plusDays(to));
        this.propiedad.crearReserva(dateLapse, usuario);    // No es posible crear un reserva con fecha de inicio actual
        //assertEquals((to-from)*100*reembolso, this.propiedad.cancelarReserva(usuario.getReservas().get(0), usuario));

    }

}