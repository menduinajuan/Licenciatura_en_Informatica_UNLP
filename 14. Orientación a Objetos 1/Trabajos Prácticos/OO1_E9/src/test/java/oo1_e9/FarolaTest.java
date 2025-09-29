package oo1_e9;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class FarolaTest {
	private Farola farolaUno;
	private Farola farolaDos;

	@BeforeEach
	void setUp() throws Exception {
		this.farolaUno = new Farola();
		this.farolaDos = new Farola();
	}

	@Test
	void testConstructor() {
		assertFalse(farolaUno.isOn(), "La farolaUno no está apagada");
		assertTrue(farolaUno.isOff(), "La farolaUno no está apagada");
		assertTrue(farolaUno.getNeighbors().isEmpty(), "La farolaUno no debería tener vecinos");
	}

	@Test
	void testPairWithNeighbor() {
		farolaUno.pairWithNeighbor(farolaDos);
		assertTrue(farolaUno.getNeighbors().contains(farolaDos));
		assertTrue(farolaDos.getNeighbors().contains(farolaUno));
	}

	@Test
	void testTurnOnAndOff() {
		farolaUno.pairWithNeighbor(farolaDos);
		farolaUno.turnOn();
		assertTrue(farolaUno.isOn());
		assertTrue(farolaDos.isOn());
		farolaUno.turnOff();
		assertFalse(farolaUno.isOn());
		assertFalse(farolaDos.isOn());

		farolaDos.turnOn();
		assertTrue(farolaUno.isOn());
		assertTrue(farolaDos.isOn());
		farolaDos.turnOff();
		assertFalse(farolaUno.isOn());
		assertFalse(farolaDos.isOn());
	}
}