package oo1_e3;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.time.LocalDate;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class PresupuestoTest {

    private Presupuesto presupuesto;

    @BeforeEach
    public void setUp() throws Exception {
        presupuesto=new Presupuesto("Pedro");
    }

    @Test
    public void testConstructor() {
        assertEquals(LocalDate.now(), presupuesto.getFecha());
        assertEquals("Pedro", presupuesto.getCliente());
        assertEquals(0, presupuesto.calcularTotal());
    }

    @Test
    public void testCalcularTotal() {
        assertEquals(0, presupuesto.calcularTotal());
        Item item=new Item("Leche", 100, 1);
        presupuesto.agregarItem(item);
        assertEquals(100, presupuesto.calcularTotal());
        item=new Item("Chocolate", 150, 2);
        presupuesto.agregarItem(item);
        assertEquals(400, presupuesto.calcularTotal());
    }

}