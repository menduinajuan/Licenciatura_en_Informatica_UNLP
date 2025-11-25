package oo1_e18;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import java.util.*;

public class EvenNumberSet2Test {

    EvenNumberSet2 set;

    @BeforeEach
    public void setUp() throws Exception {
        this.set=new EvenNumberSet2();
    }

    @Test
    public void testAdd() {
        assertFalse(this.set.add(1));
        assertTrue(this.set.add(2));
        assertFalse(this.set.add(3));
        assertTrue(this.set.add(4));
        assertEquals(2, this.set.size());
        assertFalse(this.set.contains(1));
        assertTrue(this.set.contains(2));
        assertFalse(this.set.contains(3));
        assertTrue(this.set.contains(4));
    }

    @Test
    public void testAddAll() {
        List<Integer> lista=Arrays.asList(1, 2, 3, 4);
        boolean result=this.set.addAll(lista);
        assertTrue(result);
        assertEquals(2, this.set.size());
        assertFalse(this.set.contains(1));
        assertTrue(this.set.contains(2));
        assertFalse(this.set.contains(3));
        assertTrue(this.set.contains(4));
    }


}