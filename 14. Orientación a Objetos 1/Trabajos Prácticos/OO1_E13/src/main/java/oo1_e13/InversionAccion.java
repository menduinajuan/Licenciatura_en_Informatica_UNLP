package oo1_e13;

public class InversionAccion implements Inversion {

    private String nombre;
    private int cantidad;
    private double valorUnitario;

    public InversionAccion(String nombre, int cantidad, double valorUnitario) {
        this.nombre=nombre;
        this.cantidad=cantidad;
        this.valorUnitario=valorUnitario;
    }

    public String getNombre() {
        return this.nombre;
    }

    public int getCantidad() {
        return this.cantidad;
    }

    public double getValorUnitario() {
        return this.valorUnitario;
    }

    @Override
    public double getValorActual() {
        return this.getValorUnitario()*this.getCantidad();
    }

}