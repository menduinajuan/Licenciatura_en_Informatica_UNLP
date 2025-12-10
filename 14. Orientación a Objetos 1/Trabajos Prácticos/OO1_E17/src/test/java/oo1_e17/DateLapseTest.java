package oo1_e17;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import org.junit.jupiter.api.*;

public class DateLapseTest {

    private DateLapseAbstract dateLapse;
    private LocalDate from;
    private long sizeInDays;

    @BeforeEach
    public void setUp() throws Exception {
        this.from=LocalDate.of(2025, 1, 1);
        this.sizeInDays=30;
        this.dateLapse=new DateLapse2(this.from, this.sizeInDays);
    }

    @Test
    public void testConstructor() {
        assertEquals(this.from, this.dateLapse.getFrom());
        assertEquals(this.from.plusDays(this.sizeInDays), this.dateLapse.getTo());
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