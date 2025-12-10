package oo1_e19;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import org.junit.jupiter.api.*;

public class DateLapseTest {

    private DateLapse dateLapse;
    private LocalDate from;
    private LocalDate to;

    @BeforeEach
    public void setUp() throws Exception {
        this.from=LocalDate.of(2025, 1, 1);
        this.to=LocalDate.of(2025, 1, 31);
        this.dateLapse=new DateLapse(this.from, this.to);
    }

    @Test
    public void testConstructor() {
        assertEquals(this.from, this.dateLapse.getFrom());
        assertEquals(this.to, this.dateLapse.getTo());
    }

    @Test
    public void testSizeInDays() {
        assertEquals(30, this.dateLapse.sizeInDays());
    }

    @Test
    public void testIncludesDate() {
        assertFalse(this.dateLapse.includesDate(this.dateLapse.getFrom().minusDays(1)));
        assertFalse(this.dateLapse.includesDate(this.dateLapse.getTo().plusDays(1)));
        assertTrue(this.dateLapse.includesDate(this.dateLapse.getFrom()));
        assertTrue(this.dateLapse.includesDate(this.dateLapse.getFrom().plusDays(1)));
        assertTrue(this.dateLapse.includesDate(this.dateLapse.getTo()));
        assertTrue(this.dateLapse.includesDate(this.dateLapse.getTo().minusDays(1)));
    }

    @Test
    public void testOverLaps() {

        // otroAntes
        DateLapse otroAntes=new DateLapse(this.from.minusDays(10), this.from.minusDays(1));
        assertFalse(this.dateLapse.overlaps(otroAntes));

        // otroDespues
        DateLapse otroDespues=new DateLapse(this.to.plusDays(1), this.to.plusDays(10));
        assertFalse(this.dateLapse.overlaps(otroDespues));

        // otroIgual
        DateLapse otroIgual=new DateLapse(this.from, this.to);
        assertTrue(this.dateLapse.overlaps(otroIgual));

        // otroTocaIzquierda
        DateLapse otroTocaIzquierda=new DateLapse(this.from.minusDays(10), this.from);
        assertTrue(this.dateLapse.overlaps(otroTocaIzquierda));

        // otroTocaDerecha
        DateLapse otroTocaDerecha=new DateLapse(this.to, this.to.plusDays(10));
        assertTrue(this.dateLapse.overlaps(otroTocaDerecha));

        // otroParcialIzquierda
        DateLapse otroParcialIzquierda=new DateLapse(this.from.minusDays(10), this.from.plusDays(10));
        assertTrue(this.dateLapse.overlaps(otroParcialIzquierda));

        // otroParcialDerecha
        DateLapse otroParcialDerecha=new DateLapse(this.to.minusDays(10), this.to.plusDays(10));
        assertTrue(this.dateLapse.overlaps(otroParcialDerecha));

        // otroContenido
        DateLapse otroContenido=new DateLapse(this.from.plusDays(10), this.to.minusDays(10));
        assertTrue(this.dateLapse.overlaps(otroContenido));

    }

    @Test
    public void testThisIsAfterNow() {
        DateLapse dateLapse2=new DateLapse(this.from.plusDays(365), this.to.plusDays(365));
        assertFalse(this.dateLapse.nowIsBeforeThis());
        assertTrue(dateLapse2.nowIsBeforeThis());
    }

}