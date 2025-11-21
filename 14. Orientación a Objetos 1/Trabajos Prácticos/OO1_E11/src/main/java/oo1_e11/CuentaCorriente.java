package oo1_e11;

public class CuentaCorriente extends Cuenta {

    private double limiteDescubierto;

    public CuentaCorriente() {
        super();
        this.limiteDescubierto=0;
    }

    public void setLimiteDescubierto(double limiteDescubierto) {
        this.limiteDescubierto=limiteDescubierto;
    }

    public double getLimiteDescubierto() {
        return this.limiteDescubierto;
    }

    @Override
    protected boolean puedeExtraer(double monto) {
        return (this.getSaldo()+this.getLimiteDescubierto())>=monto;
    }

}