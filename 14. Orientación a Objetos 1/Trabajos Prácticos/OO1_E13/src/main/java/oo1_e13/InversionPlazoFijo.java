package oo1_e13;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class InversionPlazoFijo implements Inversion {

    private LocalDate fecha;
    private double montoDepositado;
    private double interes;

    public InversionPlazoFijo(double montoDepositado, double interes) {
        this.fecha=LocalDate.now();
        this.montoDepositado=montoDepositado;
        this.interes=interes;
    }

    public LocalDate getFecha() {
        return this.fecha;
    }

    public double getMontoDepositado() {
        return this.montoDepositado;
    }

    public double getInteres() {
        return this.interes;
    }

    @Override
    public double getValorActual() {
        double interesDiario=(this.getInteres()/100)/365;
        long dias=ChronoUnit.DAYS.between(this.getFecha(), LocalDate.now());
        return this.getMontoDepositado()*(1+interesDiario*dias);
    }

}