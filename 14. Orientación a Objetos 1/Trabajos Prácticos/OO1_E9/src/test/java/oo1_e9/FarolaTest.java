package oo1_e9;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class FarolaTest {

    private Farola farolaUno;
    private Farola farolaDos;

    @BeforeEach
    public void setUp() throws Exception {
        this.farolaUno=new Farola();
        this.farolaDos=new Farola();
    }

    @Test
    public void testConstructor() {
        assertFalse(this.farolaUno.isOn(), "La farolaUno no está apagada");
        assertTrue(this.farolaUno.isOff(), "La farolaUno no está apagada");
        assertTrue(this.farolaUno.getNeighbors().isEmpty(), "La farolaUno no debería tener vecinos");
    }

    @Test
    public void testPairWithNeighbor() {
        this.farolaUno.pairWithNeighbor(this.farolaDos);
        assertTrue(this.farolaUno.getNeighbors().contains(this.farolaDos));
        assertTrue(this.farolaDos.getNeighbors().contains(this.farolaUno));
    }

    @Test
    public void testTurnOnAndOff() {
        this.farolaUno.pairWithNeighbor(this.farolaDos);
        this.farolaUno.turnOn();
        assertTrue(this.farolaUno.isOn());
        assertTrue(this.farolaDos.isOn());
        this.farolaUno.turnOff();
        assertFalse(this.farolaUno.isOn());
        assertFalse(this.farolaDos.isOn());
        this.farolaDos.turnOn();
        assertTrue(this.farolaUno.isOn());
        assertTrue(this.farolaDos.isOn());
        this.farolaDos.turnOff();
        assertFalse(this.farolaUno.isOn());
        assertFalse(this.farolaDos.isOn());
    }

}