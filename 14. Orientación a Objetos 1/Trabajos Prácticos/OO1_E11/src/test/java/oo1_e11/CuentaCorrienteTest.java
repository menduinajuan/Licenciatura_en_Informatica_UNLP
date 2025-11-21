package oo1_e11;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class CuentaCorrienteTest {

    private CuentaCorriente cuentaCorriente;

    @BeforeEach
    public void setUp() throws Exception {
        this.cuentaCorriente=new CuentaCorriente();
    }

    @Test
    public void testConstructor() {
        assertEquals(0, this.cuentaCorriente.getSaldo());
        assertEquals(0, this.cuentaCorriente.getLimiteDescubierto());
    }

    @Test
    public void testDepositar() {

        double d=100, saldo=0;

        // Monto de depósito negativo
        this.cuentaCorriente.depositar(-d);
        assertEquals(saldo, this.cuentaCorriente.getSaldo());   // saldo=0

        // Monto de depósito positivo
        this.cuentaCorriente.depositar(d);
        saldo+=d;
        assertEquals(saldo, this.cuentaCorriente.getSaldo());   // saldo=100

    }

    @Test
    public void testExtraer() {

        double d=100, e=50, saldo=0, descubierto=50;

        this.cuentaCorriente.setLimiteDescubierto(descubierto);
        this.cuentaCorriente.depositar(d);
        saldo+=d;

        // Monto de extracción negativo
        assertFalse(this.cuentaCorriente.extraer(-e));
        assertEquals(saldo, this.cuentaCorriente.getSaldo());   // saldo=100

        // Saldo+Descubierto insuficiente para extraer el monto
        assertFalse(this.cuentaCorriente.extraer(saldo+descubierto+1));
        assertEquals(saldo, this.cuentaCorriente.getSaldo());   // saldo=100

        // Saldo+Descubierto suficiente para extraer (saldo restante mayor a -descubierto)
        assertTrue(this.cuentaCorriente.extraer(e));
        saldo-=e;
        assertEquals(saldo, this.cuentaCorriente.getSaldo());   // saldo=50

        // Saldo+Descubierto suficiente para extraer (saldo restante igual a -descubierto)
        assertTrue(this.cuentaCorriente.extraer(saldo+descubierto));
        saldo-=(saldo+descubierto);
        assertEquals(saldo, this.cuentaCorriente.getSaldo());   // saldo=-50

    }

    @Test
    public void testTransferirACuenta() {

        CuentaCorriente cuentaCorriente2=new CuentaCorriente();
        double d=100, t=50, saldo1=0, saldo2=0, descubierto=50;

        this.cuentaCorriente.setLimiteDescubierto(descubierto);
        this.cuentaCorriente.depositar(d);
        saldo1+=d;

        // Monto de transferencia negativo
        this.cuentaCorriente.transferirACuenta(-t, cuentaCorriente2);
        assertEquals(saldo1, this.cuentaCorriente.getSaldo());  // saldo1=100
        assertEquals(saldo2, cuentaCorriente2.getSaldo());      // saldo2=0

        // Saldo+Descubierto insuficiente para transferir el monto
        this.cuentaCorriente.transferirACuenta(saldo1+descubierto+1, cuentaCorriente2);
        assertEquals(saldo1, this.cuentaCorriente.getSaldo());  // saldo1=100
        assertEquals(saldo2, cuentaCorriente2.getSaldo());      // saldo2=0

        // Saldo+Descubierto suficiente para transferir (saldo restante mayor a -descubierto)
        this.cuentaCorriente.transferirACuenta(t, cuentaCorriente2);
        saldo1-=t;
        saldo2+=t;
        assertEquals(saldo1, this.cuentaCorriente.getSaldo());  // saldo1=50
        assertEquals(saldo2, cuentaCorriente2.getSaldo());      // saldo2=50

        // Saldo+Descubierto suficiente para transferir (saldo restante igual a -descubierto)
        this.cuentaCorriente.transferirACuenta(saldo1+descubierto, cuentaCorriente2);
        saldo2+=(saldo1+descubierto);
        saldo1-=(saldo1+descubierto);
        assertEquals(saldo1, this.cuentaCorriente.getSaldo());  // saldo1=-50
        assertEquals(saldo2, cuentaCorriente2.getSaldo());      // saldo2=150

    }

}