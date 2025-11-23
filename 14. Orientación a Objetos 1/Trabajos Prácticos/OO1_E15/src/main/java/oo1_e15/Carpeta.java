package oo1_e15;

import java.util.*;

public class Carpeta {

    private String nombre;
    private List<Email> emails;

    public Carpeta(String nombre) {
        this.nombre=nombre;
        this.emails=new ArrayList<>();
    }

    public String getNombre() {
        return this.nombre;
    }

    protected List<Email> getEmails() {
        return this.emails;
    }

    public void agregarMail(Email mail) {
        this.getEmails().add(mail);
    }

    public void eliminarMail(Email mail) {
        if (mail!=null)
            this.getEmails().remove(mail);
    }

    public void mover(Email email, Carpeta destino) {
        this.eliminarMail(email);
        destino.agregarMail(email);
    }

    public Email buscar(String texto){
        return this.getEmails().stream().filter(e->e.buscar(texto)).findFirst().orElse(null);
    }

    public int espacioOcupado() {
        return this.getEmails().stream().mapToInt(Email::espacioOcupado).sum();
    }

}