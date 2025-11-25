package oo1_e15;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class EmailTest {

    private Email email;
    private Archivo archivo;

    @BeforeEach
    public void setUp() {
        this.email=new Email("Email", "Cuerpo");
        this.archivo=new Archivo("Archivo");
    }

    @Test
    public void testConstructor() {
        assertEquals("Email", this.email.getTitulo());
        assertEquals("Cuerpo", this.email.getCuerpo());
    }

    @Test
    public void testAgregarEliminarArchivo() {
        assertEquals(0, this.email.adjuntos().size());
        this.email.agregarArchivo(this.archivo);
        assertEquals(1, this.email.adjuntos().size());
        this.email.eliminarArchivo(this.archivo);
        assertEquals(0, this.email.adjuntos().size());
    }

    @Test
    public void testBuscar() {        
        assertFalse(this.email.buscar("XXX"));
        assertTrue(this.email.buscar("Email"));
        assertTrue(this.email.buscar("Cuerpo"));
    }

    @Test
    public void testEspacioOcupado() {
        assertEquals(11, this.email.espacioOcupado());
        this.email.agregarArchivo(this.archivo);
        assertEquals(18, this.email.espacioOcupado());
    }

}