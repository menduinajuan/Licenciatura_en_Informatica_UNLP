package oo1_e3;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.time.LocalDate;

public class PresupuestoTest {

    private Presupuesto presupuesto;

    @BeforeEach
    public void setUp() throws Exception {
        this.presupuesto=new Presupuesto("Pedro");
    }

    @Test
    public void testConstructor() {
        assertEquals(LocalDate.now(), this.presupuesto.getFecha());
        assertEquals("Pedro", this.presupuesto.getCliente());
        assertEquals(0, this.presupuesto.calcularTotal());
    }

    @Test
    public void testCalcularTotal() {
        assertEquals(0, this.presupuesto.calcularTotal());
        Item item=new Item("Leche", 100, 1);
        this.presupuesto.agregarItem(item);
        assertEquals(100, this.presupuesto.calcularTotal());
        item=new Item("Chocolate", 150, 2);
        this.presupuesto.agregarItem(item);
        assertEquals(400, this.presupuesto.calcularTotal());
    }

}