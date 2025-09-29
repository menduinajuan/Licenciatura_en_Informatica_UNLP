package oo1_e5;

import java.util.*;

public class Inversor {

    private double valorInversiones;
    private List<Inversion> inversiones;

    public Inversor() {
        this.valorInversiones=0;
        this.inversiones=new ArrayList<>();
    }

    public double getValorInversiones() {
        // return this.inversiones.stream().mapToDouble(Inversion::getValorActual).sum();
        return this.valorInversiones;
    }
 
    public List<Inversion> getInversiones() {
        return this.inversiones;
    }

    public void agregarInversion(Inversion i) {
        this.getInversiones().add(i);
        this.valorInversiones+=i.getValorActual();
    }

    public Inversion sacarInversion(Inversion i) {
        if (this.getInversiones().remove(i)) {
            this.valorInversiones-=i.getValorActual();
            return i;
        }
        return null;
    }

}