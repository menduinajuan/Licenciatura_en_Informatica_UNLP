package oo1_e6;

import java.time.LocalDate;

public class Consumo {

    private LocalDate fecha;
    private double energiaActiva;
    private double energiaReactiva;

    public Consumo(double kWh, double kVArh) {
        this.fecha=LocalDate.now();
        this.energiaActiva=kWh;
        this.energiaReactiva=kVArh;
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

}