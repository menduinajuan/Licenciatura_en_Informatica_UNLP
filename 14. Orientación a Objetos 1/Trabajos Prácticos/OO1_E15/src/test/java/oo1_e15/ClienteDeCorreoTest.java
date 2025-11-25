package oo1_e15;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class ClienteDeCorreoTest {

    private ClienteDeCorreo cliente;
    private Carpeta carpeta;
    private Email email;
    private Archivo archivo;

    @BeforeEach
    public void setUp() {
        this.cliente=new ClienteDeCorreo("Inbox");
        this.carpeta=new Carpeta("Carpeta");
        this.email=new Email("Email", "Cuerpo");
        this.archivo=new Archivo("Archivo");
    }

    @Test
    public void testConstructor() {
        assertEquals("Inbox", this.cliente.getInbox().getNombre());
    }

    @Test
    public void testAgregarEliminarCarpeta() {
        assertEquals(1, this.cliente.getCarpetas().size());
        this.cliente.agregarCarpeta(this.carpeta);
        assertEquals(2, this.cliente.getCarpetas().size());
        this.cliente.eliminarCarpeta(this.carpeta);
        assertEquals(1, this.cliente.getCarpetas().size());
    }

    @Test
    public void testMover() {
        this.cliente.agregarCarpeta(this.carpeta);
        assertEquals(0, this.cliente.getCarpetas().get(0).getEmails().size());
        assertEquals(0, this.cliente.getCarpetas().get(1).getEmails().size());
        this.cliente.recibir(this.email);
        assertEquals(1, this.cliente.getCarpetas().get(0).getEmails().size());
        assertEquals(0, this.cliente.getCarpetas().get(1).getEmails().size());
        this.cliente.mover(this.email, this.carpeta);
        assertEquals(0, this.cliente.getCarpetas().get(0).getEmails().size());
        assertEquals(1, this.cliente.getCarpetas().get(1).getEmails().size());
    }

    @Test
    public void testRecibir() {
        assertEquals(0, this.cliente.getInbox().getEmails().size());
        this.cliente.recibir(this.email);
        assertEquals(1, this.cliente.getInbox().getEmails().size());
    }

    @Test
    public void testBuscar() {
        assertNull(this.cliente.buscar("Email"));
        this.cliente.recibir(this.email);
        assertNotNull(this.cliente.buscar("Email"));
    }

    @Test
    public void testEspacioOcupado() {
        Email email2=new Email("Email", "Cuerpo");
        assertEquals(0, this.cliente.espacioOcupado());
        this.email.agregarArchivo(this.archivo);
        this.carpeta.agregarEmail(this.email);
        this.cliente.agregarCarpeta(this.carpeta);
        assertEquals(18, this.cliente.espacioOcupado());
        this.cliente.recibir(email2);
        assertEquals(29, this.cliente.espacioOcupado());
    }

}