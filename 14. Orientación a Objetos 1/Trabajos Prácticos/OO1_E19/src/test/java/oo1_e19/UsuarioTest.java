package oo1_e19;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class UsuarioTest {

    private Usuario usuario;

    @BeforeEach
    public void setUp() throws Exception {
        this.usuario=new Usuario("Juan Menduiña", "13 22", 37102205);
    }

    @Test
    public void testConstructor() {
        assertEquals("Juan Menduiña", this.usuario.getNombre());
        assertEquals("13 22", this.usuario.getDireccion());
        assertEquals(37102205, this.usuario.getDni());
    }

    

}