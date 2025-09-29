package oo1_e6;

import java.time.LocalDate;

public class Factura {

    private String cliente;
    private LocalDate fecha;
    private double energiaActiva;
    private double energiaReactiva;
    private double preciokWh;
    private double bonificacion;
    private double montoFinal;

    public Factura(String cliente, Consumo ultimoConsumo, double preciokWh) {
        this.cliente=cliente;
        this.fecha=ultimoConsumo.getFecha();
        this.energiaActiva=ultimoConsumo.getEnergiaActiva();
        this.energiaReactiva=ultimoConsumo.getEnergiaReactiva();
        this.preciokWh=preciokWh;
        this.setBonificacion();
        this.setMontoFinal();
    }

    private void setBonificacion() {
        double energiaAparente=Math.sqrt(Math.pow(this.getEnergiaActiva(), 2)+Math.pow(this.getEnergiaReactiva(), 2));
        double fpc=this.getEnergiaActiva()/energiaAparente;
        this.bonificacion=(fpc>0.8) ? 0.1 : 0;
    }

    private void setMontoFinal() {
        double costoConsumo=this.getEnergiaActiva()*this.getPreciokWh();
        this.montoFinal=costoConsumo*(1-this.getBonificacion());
    }

    public String getCliente() {
        return this.cliente;
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

    public double getPreciokWh() {
        return this.preciokWh;
    }

    public double getBonificacion() {
        return this.bonificacion;
    }

    public double getMontoFinal() {
        return this.montoFinal;
    }

    @Override
    public String toString() {
        return "Cliente: " + this.getCliente() + "\n" +
               "Fecha: " + this.getFecha().toString() + "\n" +
               "Monto Final: $" + String.format("%.2f", this.getMontoFinal());
    }

}