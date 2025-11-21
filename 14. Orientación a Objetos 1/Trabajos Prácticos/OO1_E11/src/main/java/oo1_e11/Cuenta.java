package oo1_e11;

public abstract class Cuenta {

    private double saldo;

    public Cuenta() {
        this.saldo=0;
    }

    public double getSaldo() {
        return this.saldo;
    }

    public void depositar(double monto) {
        if (monto>0)
            this.saldo+=monto;
    }

    protected void extraerSinControlar(double monto) {
        this.saldo-=monto;
    }

    public boolean extraer(double monto) {
        if ((monto>0) && (this.puedeExtraer(monto))) {
            this.extraerSinControlar(monto);
            return true;
        }
        return false;
    }

    public boolean transferirACuenta(double monto, Cuenta cuentaDestino) {
        if ((monto>0) && (this.puedeExtraer(monto))) {
            this.extraerSinControlar(monto);
            cuentaDestino.depositar(monto);
            return true;
        }
        return false;
    }

    protected abstract boolean puedeExtraer(double monto);

}