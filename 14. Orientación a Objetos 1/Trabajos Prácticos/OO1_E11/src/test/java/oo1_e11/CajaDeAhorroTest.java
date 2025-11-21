package oo1_e11;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class CajaDeAhorroTest {

    private final static double PORCENTAJE=0.02;
    private CajaDeAhorro cajaDeAhorro;

    @BeforeEach
    public void setUp() throws Exception {
        this.cajaDeAhorro=new CajaDeAhorro();
    }

    @Test
    public void testConstructor() {
        assertEquals(0, this.cajaDeAhorro.getSaldo());
    }

    @Test
    public void testDepositar() {

        double d=100, saldo=0;

        // Monto de depósito negativo
        this.cajaDeAhorro.depositar(-d);
        assertEquals(saldo, this.cajaDeAhorro.getSaldo());  // saldo=0

        // Monto de depósito positivo
        this.cajaDeAhorro.depositar(d);
        saldo+=d*(1-PORCENTAJE);
        assertEquals(saldo, this.cajaDeAhorro.getSaldo());  // saldo=98

    }

    @Test
    public void testExtraer() {

        double d=100, e=50, saldo=0;

        this.cajaDeAhorro.depositar(d);
        saldo+=d*(1-PORCENTAJE);

        // Monto de extracción negativo
        assertFalse(this.cajaDeAhorro.extraer(-e));
        assertEquals(saldo, this.cajaDeAhorro.getSaldo());  // saldo=98

        // Saldo insuficiente para extraer el monto
        assertFalse(this.cajaDeAhorro.extraer(saldo));
        assertEquals(saldo, this.cajaDeAhorro.getSaldo());  // saldo=98

        // Saldo suficiente para extraer (saldo restante mayor a cero)
        assertTrue(this.cajaDeAhorro.extraer(e));
        saldo-=e*(1+PORCENTAJE);
        assertEquals(saldo, this.cajaDeAhorro.getSaldo());  // saldo=47

        // Saldo suficiente para extraer (saldo restante igual a cero)
        assertTrue(this.cajaDeAhorro.extraer(saldo/(1+PORCENTAJE)));
        saldo-=saldo/(1+PORCENTAJE)*(1+PORCENTAJE);
        assertEquals(saldo, this.cajaDeAhorro.getSaldo());  // saldo=0

    }

    @Test
    public void testTransferirACuenta() {

        CajaDeAhorro cajaDeAhorro2=new CajaDeAhorro();
        double d=100, t=50, saldo1=0, saldo2=0;

        this.cajaDeAhorro.depositar(d);
        saldo1+=d*(1-PORCENTAJE);

        // Monto de transferencia negativo
        this.cajaDeAhorro.transferirACuenta(-t, cajaDeAhorro2);
        assertEquals(saldo1, this.cajaDeAhorro.getSaldo()); // saldo1=98
        assertEquals(saldo2, cajaDeAhorro2.getSaldo());     // saldo2=0

        // Saldo insuficiente para transferir el monto
        this.cajaDeAhorro.transferirACuenta(saldo1, cajaDeAhorro2);
        assertEquals(saldo1, this.cajaDeAhorro.getSaldo()); // saldo1=98
        assertEquals(saldo2, cajaDeAhorro2.getSaldo());     // saldo2=0

        // Saldo suficiente para transferir (saldo restante mayor a cero)
        this.cajaDeAhorro.transferirACuenta(t, cajaDeAhorro2);
        saldo1-=t*(1+PORCENTAJE);
        saldo2+=t*(1-PORCENTAJE);
        assertEquals(saldo1, this.cajaDeAhorro.getSaldo()); // saldo1=47
        assertEquals(saldo2, cajaDeAhorro2.getSaldo());     // saldo2=49

        // Saldo suficiente para transferir (saldo restante igual a cero)
        this.cajaDeAhorro.transferirACuenta(saldo1/(1+PORCENTAJE), cajaDeAhorro2);
        saldo2+=saldo1/(1+PORCENTAJE)*(1-PORCENTAJE);
        saldo1-=saldo1/(1+PORCENTAJE)*(1+PORCENTAJE);
        assertEquals(saldo1, this.cajaDeAhorro.getSaldo()); // saldo1=0
        assertEquals(saldo2, cajaDeAhorro2.getSaldo());     // saldo2=94.1568

    }

}