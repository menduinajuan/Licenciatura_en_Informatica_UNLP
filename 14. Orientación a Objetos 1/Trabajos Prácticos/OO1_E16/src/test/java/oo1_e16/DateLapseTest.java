package oo1_e16;

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

}