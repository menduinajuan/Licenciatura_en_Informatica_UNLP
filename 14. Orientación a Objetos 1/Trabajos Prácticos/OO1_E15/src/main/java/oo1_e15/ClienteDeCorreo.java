package oo1_e15;

import java.util.*;

public class ClienteDeCorreo {

    private Carpeta inbox;
    private List<Carpeta> carpetas;

    public ClienteDeCorreo(String nombre) {
        this.inbox=new Carpeta(nombre);
        this.carpetas=new ArrayList<>();
        this.carpetas.add(this.inbox);
    }

    public Carpeta getInbox(){
        return this.inbox;
    }

    protected List<Carpeta> getCarpetas() {
        return this.carpetas;
    }

    public void agregarCarpeta(Carpeta carpeta) {
        this.getCarpetas().add(carpeta);
    }

    public void eliminarCarpeta(Carpeta carpeta) {
        if (carpeta!=null)
            this.getCarpetas().remove(carpeta);
    }

    public void mover(Email email, Carpeta carpeta) {
        this.getInbox().eliminarEmail(email);
        carpeta.agregarEmail(email);
    }

    public void recibir(Email email) {
        this.getInbox().agregarEmail(email);
    }

    public Email buscar(String texto) {
        return this.getCarpetas().stream().map(c->c.buscar(texto)).filter(e->e!=null).findFirst().orElse(null);
    }

    public int espacioOcupado() {
        return this.getCarpetas().stream().mapToInt(Carpeta::espacioOcupado).sum();
    }

}