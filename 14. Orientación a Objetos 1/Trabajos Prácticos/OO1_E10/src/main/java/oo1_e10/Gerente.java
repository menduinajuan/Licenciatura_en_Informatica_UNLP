package oo1_e10;

public class Gerente extends EmpleadoJerarquico {

    public Gerente(String nombre) {
        super(nombre);
    }

    @Override
    public double aportes() {
        return this.montoBasico()*0.05d;
    }

    @Override
    public double montoBasico() {
        return 57000;
    }

}