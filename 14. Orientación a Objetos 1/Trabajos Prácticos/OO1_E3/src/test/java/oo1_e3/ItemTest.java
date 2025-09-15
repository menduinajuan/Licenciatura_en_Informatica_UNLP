package oo1_e3;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ItemTest {

    private Item item;

    @BeforeEach
    public void setUp() throws Exception {
        item=new Item("Azúcar", 2, 60);
    }

    @Test
    public void testCostoUnitario() {
        assertEquals(60, item.getCostoUnitario());
    }

    @Test
    public void testCosto() {
        assertEquals(120, item.costo());
    }

}