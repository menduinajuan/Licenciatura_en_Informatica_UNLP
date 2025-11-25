package oo1_e15;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class ArchivoTest {

    private Archivo archivo;

    @BeforeEach
    public void setUp() {
        this.archivo=new Archivo("Archivo");
    }

    @Test
    public void tamanio() {
        assertEquals(7, this.archivo.tamanio());
    }

}