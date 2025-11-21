package oo1_e5;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class InversionPlazoFijo implements Inversion {

    private LocalDate fechaDeConstitucion;
    private double montoDepositado;
    private double porcentajeDeInteresDiario;

    public InversionPlazoFijo(LocalDate fechaDeConstitucion, double montoDepositado, double porcentajeDeInteresDiario) {
        this.fechaDeConstitucion=fechaDeConstitucion;
        this.montoDepositado=montoDepositado;
        this.porcentajeDeInteresDiario=porcentajeDeInteresDiario;
    }

    public LocalDate getFechaDeConstitucion() {
        return this.fechaDeConstitucion;
    }

    public double getMontoDepositado() {
        return this.montoDepositado;
    }

    public double getPorcentajeDeInteresDiario() {
        return this.porcentajeDeInteresDiario;
    }

    @Override
    public double valorActual() {
        long dias=ChronoUnit.DAYS.between(this.getFechaDeConstitucion(), LocalDate.now());
        return this.getMontoDepositado()*(1+(this.getPorcentajeDeInteresDiario()/100)*dias);
    }

}