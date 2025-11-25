package oo1_e15;

import java.util.*;

public class Email {

    private String titulo;
    private String cuerpo;
    private List<Archivo> adjuntos;

    public Email(String titulo, String cuerpo) {
        this.titulo=titulo;
        this.cuerpo=cuerpo;
        this.adjuntos=new ArrayList<>();
    }

    public String getTitulo() {
        return this.titulo;
    }

    public String getCuerpo() {
        return this.cuerpo;
    }

    protected List<Archivo> adjuntos() {
        return this.adjuntos;
    }

    public void agregarArchivo(Archivo archivo) {
        this.adjuntos().add(archivo);
    }

    public void eliminarArchivo(Archivo archivo) {
        if (archivo!=null)
            this.adjuntos().remove(archivo);
    }

    public boolean buscar(String texto) {
        return this.getTitulo().contains(texto) || this.getCuerpo().contains(texto);
    }

    public int espacioOcupado() {
        return this.getTitulo().length()+this.getCuerpo().length()+this.adjuntos().stream().mapToInt(Archivo::tamanio).sum();
    }

}