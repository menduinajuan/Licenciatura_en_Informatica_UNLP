package oo1_e15;

public class Archivo {
    
    private String nombre;

    public Archivo(String nombre) {
        this.nombre=nombre;
    }

    public void setNombre(String nombre) {
        this.nombre=nombre;
    }

    public String getNombre() {
        return this.nombre;
    }

    public int tamanio() {
        return this.getNombre().length();
    }

}