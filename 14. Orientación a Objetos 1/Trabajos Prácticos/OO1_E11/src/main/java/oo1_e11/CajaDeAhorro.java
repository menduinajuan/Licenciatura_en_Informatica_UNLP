package oo1_e11;

public class CajaDeAhorro extends Cuenta {

    private final static double PORCENTAJE=0.02;

    public CajaDeAhorro() {
        super();
    }

    @Override
    public void depositar(double monto) {
        super.depositar(monto*(1-PORCENTAJE));
    }

    @Override
    protected void extraerSinControlar(double monto) {
        super.extraerSinControlar(monto*(1+PORCENTAJE));
    }

    @Override
    public boolean puedeExtraer(double monto) {
        return this.getSaldo()>=monto*(1+PORCENTAJE);
    }

}