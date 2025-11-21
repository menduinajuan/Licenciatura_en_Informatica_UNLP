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
        nala=new Mamifero("Nala");
        melquiades=new Mamifero("Melquiades");
        mufasa=new Mamifero("Mufasa");
        alexa=new Mamifero("Alexa");
        elsa=new Mamifero("Elsa");
        scar=new Mamifero("Scar");
        sarabi=new Mamifero("Sarabi");
        anonimo=new Mamifero();
        alexa.setPadre(mufasa);
        alexa.setMadre(sarabi);
        mufasa.setPadre(melquiades);
        mufasa.setMadre(nala);
        sarabi.setPadre(scar);
        sarabi.setMadre(elsa);
    }

    @Test
    public void testIdentificador() {
        anonimo.setIdentificador("Nala");
        assertEquals("Nala", anonimo.getIdentificador());
    }

    @Test
    public void testEspecie() {
        anonimo.setEspecie("Panthera leo");
        assertEquals("Panthera leo", anonimo.getEspecie());
    }

    @Test
    public void testPadre() {
        anonimo.setPadre(mufasa);
        assertEquals(mufasa, anonimo.getPadre());
        assertNull(nala.getPadre());
    }

    @Test
    public void testMadre() {
        anonimo.setMadre(alexa);
        assertEquals(alexa, anonimo.getMadre());
        assertNull(nala.getMadre());
    }

    @Test
    void testAbueloPaterno() {
        assertEquals(melquiades, alexa.getAbueloPaterno());
        assertNull(mufasa.getAbueloPaterno());
        assertNull(melquiades.getAbueloPaterno());
    }

    @Test
    void testAbuelaPaterna() {
        assertEquals(nala, alexa.getAbuelaPaterna());
        assertNull(mufasa.getAbuelaPaterna());
        assertNull(nala.getAbuelaPaterna());
    }

    @Test
    void testAbueloMaterno() {
        assertEquals(scar, alexa.getAbueloMaterno());
        assertNull(sarabi.getAbueloMaterno());
        assertNull(scar.getAbueloMaterno());
    }

    @Test
    public void testAbuelaMaterna() {
        assertEquals(elsa, alexa.getAbuelaMaterna());
        assertNull(sarabi.getAbuelaMaterna());
        assertNull(elsa.getAbuelaMaterna());
    }

    @Test
    public void testTieneComoAncestroA() {
        assertFalse(nala.tieneComoAncestroA(anonimo));
        assertFalse(mufasa.tieneComoAncestroA(anonimo));
        assertFalse(alexa.tieneComoAncestroA(anonimo));
        assertFalse(alexa.tieneComoAncestroA(alexa));
        assertTrue(alexa.tieneComoAncestroA(mufasa));
        assertTrue(alexa.tieneComoAncestroA(sarabi));
        assertTrue(alexa.tieneComoAncestroA(nala));
        assertTrue(alexa.tieneComoAncestroA(melquiades));
        assertTrue(alexa.tieneComoAncestroA(elsa));
        assertTrue(alexa.tieneComoAncestroA(scar));
    }

}