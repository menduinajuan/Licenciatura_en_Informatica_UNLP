package oo1_e14;

import java.util.*;

public class ReporteDeConstruccion {

    private List<Pieza> piezas;

    public ReporteDeConstruccion() {
        this.piezas=new ArrayList<>();
    }

    protected List<Pieza> getPiezas() {
        return this.piezas;
    }

    public void agregarPieza(Pieza p) {
        this.getPiezas().add(p);
    }

    public void sacarPieza(Pieza p) {
        if (p!=null)
            this.getPiezas().remove(p);
    }

    public double volumenDeMaterial(String nombreDeMaterial) {
        return this.getPiezas().stream().filter(p->p.getMaterial().equals(nombreDeMaterial)).mapToDouble(Pieza::getVolumen).sum();
    }

    public double superficieDeColor(String unNombreDeColor) {
        return this.getPiezas().stream().filter(p->p.getColor().equals(unNombreDeColor)).mapToDouble(Pieza::getSuperficie).sum();
    }

}