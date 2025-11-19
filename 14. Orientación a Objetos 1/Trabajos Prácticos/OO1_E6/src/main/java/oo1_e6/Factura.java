package oo1_e6;

public class Factura {

    private String cliente;
    private Consumo ultimoConsumo;
    private double preciokWh;
    private double bonificacion;
    private double montoFinal;

    public Factura(String cliente, Consumo ultimoConsumo, double preciokWh) {
        this.cliente=cliente;
        this.ultimoConsumo=ultimoConsumo;
        this.preciokWh=preciokWh;
        this.setBonificacion();
        this.setMontoFinal();
    }

    private void setBonificacion() {
        this.bonificacion=(this.getUltimoConsumo().getFPE()>0.8) ? 0.1 : 0;
    }

    private void setMontoFinal() {
        this.montoFinal=this.getUltimoConsumo().getEnergiaActiva()*this.getPreciokWh()*(1-this.getBonificacion());
    }

    public String getCliente() {
        return this.cliente;
    }

    public Consumo getUltimoConsumo() {
        return this.ultimoConsumo;
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
               "Fecha: " + this.getUltimoConsumo().getFecha().toString() + "\n" +
               "Monto Final: $" + String.format("%.2f", this.getMontoFinal());
    }

}