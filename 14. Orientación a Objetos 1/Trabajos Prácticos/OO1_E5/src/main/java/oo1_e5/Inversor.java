package oo1_e5;

import java.util.*;

public class Inversor {

    private String nombre;
    private List<Inversion> inversiones;

    public Inversor(String nombre) {
        this.nombre=nombre;
        this.inversiones=new ArrayList<>();
    }

    public String getNombre() {
        return this.nombre;
    }

    protected List<Inversion> getInversiones() {
        return this.inversiones;
    }

    public void agregarInversion(Inversion i) {
        this.getInversiones().add(i);
    }

    public void sacarInversion(Inversion i) {
        if (i!=null)
            this.getInversiones().remove(i);
    }

    public double valorActualInversiones() {
        return this.getInversiones().stream().mapToDouble(Inversion::valorActual).sum();
    }

}