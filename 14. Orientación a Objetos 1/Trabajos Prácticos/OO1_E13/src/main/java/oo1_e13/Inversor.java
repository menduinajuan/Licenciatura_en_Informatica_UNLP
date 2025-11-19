package oo1_e13;

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

    public double getValorInversiones() {
        return this.inversiones.stream().mapToDouble(Inversion::getValorActual).sum();
    }
 
    public List<Inversion> getInversiones() {
        return this.inversiones;
    }

    public void agregarInversion(Inversion i) {
        this.getInversiones().add(i);
    }

    public Inversion sacarInversion(Inversion i) {
        if (this.getInversiones().remove(i))
            return i;
        return null;
    }

}