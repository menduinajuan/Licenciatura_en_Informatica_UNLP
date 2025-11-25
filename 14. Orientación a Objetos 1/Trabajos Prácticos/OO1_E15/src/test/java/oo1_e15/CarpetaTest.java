package oo1_e15;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class CarpetaTest {

    private Carpeta carpeta;
    private Email email;
    private Archivo archivo;

    @BeforeEach
    public void setUp() {
        this.carpeta=new Carpeta("Carpeta");
        this.email=new Email("Email", "Cuerpo");
        this.archivo=new Archivo("Archivo");
    }

    @Test
    public void testConstructor() {
        assertEquals("Carpeta", this.carpeta.getNombre());
    }

    @Test
    public void testAgregarEliminarEmail() {
        assertEquals(0, this.carpeta.getEmails().size());
        this.carpeta.agregarEmail(this.email);
        assertEquals(1, this.carpeta.getEmails().size());
        this.carpeta.eliminarEmail(this.email);
        assertEquals(0, this.carpeta.getEmails().size());
    }

    @Test
    public void testMover() {
        Carpeta carpeta2=new Carpeta("Carpeta2");
        assertEquals(0, this.carpeta.getEmails().size());
        assertEquals(0, carpeta2.getEmails().size());
        this.carpeta.agregarEmail(this.email);
        assertEquals(1, this.carpeta.getEmails().size());
        assertEquals(0, carpeta2.getEmails().size());
        this.carpeta.mover(this.email, carpeta2);
        assertEquals(0, this.carpeta.getEmails().size());
        assertEquals(1, carpeta2.getEmails().size());
    }

    @Test
    public void testBuscar() {
        assertNull(this.carpeta.buscar("Email"));
        this.carpeta.agregarEmail(this.email);
        assertNotNull(this.carpeta.buscar("Email"));
    }

    @Test
    public void testEspacioOcupado() {
        assertEquals(0, this.carpeta.espacioOcupado());
        this.email.agregarArchivo(this.archivo);
        this.carpeta.agregarEmail(this.email);
        assertEquals(18, this.email.espacioOcupado());
    }

}