package oo1_e6;

import java.time.LocalDate;

public class Consumo {

    private LocalDate fecha;
    private double energiaActiva;
    private double energiaReactiva;
    private double fpe;

    public Consumo(double kWh, double kVArh) {
        this.fecha=LocalDate.now();
        this.energiaActiva=kWh;
        this.energiaReactiva=kVArh;
        this.setFPE();
    }

    private void setFPE() {
        double energiaAparente=Math.sqrt(Math.pow(this.getEnergiaActiva(), 2)+Math.pow(this.getEnergiaReactiva(), 2));
        this.fpe=this.getEnergiaActiva()/energiaAparente;
    }

    public LocalDate getFecha() {
        return this.fecha;
    }

    public double getEnergiaActiva() {
        return this.energiaActiva;
    }

    public double getEnergiaReactiva() {
        return this.energiaReactiva;
    }

    public double getFPE() {
        return this.fpe;
    }

}