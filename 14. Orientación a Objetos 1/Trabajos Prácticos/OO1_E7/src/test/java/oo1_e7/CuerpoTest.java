package oo1_e7;;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CuerpoTest {
	private Cuerpo3D cilindro;
	private Cuerpo3D prisma;
	
	@BeforeEach
	public void setUp() {
		Circulo circulo = new Circulo();
		circulo.setRadio(3);

		Cuadrado cuadrado = new Cuadrado();
		cuadrado.setLado(3);

		cilindro = new Cuerpo3D();
		cilindro.setAltura(5);
		cilindro.setCaraBasal(circulo);

		prisma = new Cuerpo3D();
		prisma.setAltura(7);
		prisma.setCaraBasal(cuadrado);
	}

	@Test
	public void testAltura() {
		assertEquals(7, prisma.getAltura());
		assertEquals(5, cilindro.getAltura());
	}

	@Test
	public void testSuperficieExterior() {
		double esperado = 2 * 28.2743 + 18.8495 * 5;
		assertEquals(esperado, cilindro.getSuperficieExterior(), 0.001);
		assertEquals( 2*9 + 12*7, prisma.getSuperficieExterior());
	}

	@Test
	public void testVolumen() {
		double esperado = 28.2743 * 5;
		assertEquals(esperado, cilindro.getVolumen(), 0.001);
		assertEquals(63, prisma.getVolumen());
	}
}