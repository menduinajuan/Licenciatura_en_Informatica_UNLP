package oo1_e8;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class MamiferoTest {

    private Mamifero nala;
    private Mamifero melquiades;
    private Mamifero mufasa;
    private Mamifero alexa;
    private Mamifero elsa;
    private Mamifero scar;
    private Mamifero sarabi;
    private Mamifero anonimo;

    @BeforeEach
    public void setUp() throws Exception {
        this.nala=new Mamifero("Nala");
        this.melquiades=new Mamifero("Melquiades");
        this.mufasa=new Mamifero("Mufasa");
        this.alexa=new Mamifero("Alexa");
        this.elsa=new Mamifero("Elsa");
        this.scar=new Mamifero("Scar");
        this.sarabi=new Mamifero("Sarabi");
        this.anonimo=new Mamifero();
        this.alexa.setPadre(this.mufasa);
        this.alexa.setMadre(this.sarabi);
        this.mufasa.setPadre(this.melquiades);
        this.mufasa.setMadre(this.nala);
        this.sarabi.setPadre(this.scar);
        this.sarabi.setMadre(this.elsa);
    }

    @Test
    public void testIdentificador() {
        this.anonimo.setIdentificador("Nala");
        assertEquals("Nala", this.anonimo.getIdentificador());
    }

    @Test
    public void testEspecie() {
        this.anonimo.setEspecie("Panthera leo");
        assertEquals("Panthera leo", this.anonimo.getEspecie());
    }

    @Test
    public void testPadre() {
        this.anonimo.setPadre(this.mufasa);
        assertEquals(this.mufasa, this.anonimo.getPadre());
        assertNull(this.nala.getPadre());
    }

    @Test
    public void testMadre() {
        this.anonimo.setMadre(this.alexa);
        assertEquals(this.alexa, this.anonimo.getMadre());
        assertNull(this.nala.getMadre());
    }

    @Test
    void testAbueloPaterno() {
        assertEquals(this.melquiades, this.alexa.getAbueloPaterno());
        assertNull(this.mufasa.getAbueloPaterno());
        assertNull(this.melquiades.getAbueloPaterno());
    }

    @Test
    void testAbuelaPaterna() {
        assertEquals(this.nala, this.alexa.getAbuelaPaterna());
        assertNull(this.mufasa.getAbuelaPaterna());
        assertNull(this.nala.getAbuelaPaterna());
    }

    @Test
    void testAbueloMaterno() {
        assertEquals(this.scar, this.alexa.getAbueloMaterno());
        assertNull(this.sarabi.getAbueloMaterno());
        assertNull(this.scar.getAbueloMaterno());
    }

    @Test
    public void testAbuelaMaterna() {
        assertEquals(this.elsa, this.alexa.getAbuelaMaterna());
        assertNull(this.sarabi.getAbuelaMaterna());
        assertNull(this.elsa.getAbuelaMaterna());
    }

    @Test
    public void testTieneComoAncestroA() {
        assertFalse(this.nala.tieneComoAncestroA(this.anonimo));
        assertFalse(this.mufasa.tieneComoAncestroA(this.anonimo));
        assertFalse(this.alexa.tieneComoAncestroA(this.anonimo));
        assertFalse(this.alexa.tieneComoAncestroA(this.alexa));
        assertTrue(this.alexa.tieneComoAncestroA(this.mufasa));
        assertTrue(this.alexa.tieneComoAncestroA(this.sarabi));
        assertTrue(this.alexa.tieneComoAncestroA(this.nala));
        assertTrue(this.alexa.tieneComoAncestroA(this.melquiades));
        assertTrue(this.alexa.tieneComoAncestroA(this.elsa));
        assertTrue(this.alexa.tieneComoAncestroA(this.scar));
    }

}