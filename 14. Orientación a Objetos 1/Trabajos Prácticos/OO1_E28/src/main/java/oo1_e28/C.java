package oo1_e28;

public class C extends B implements A {

    @Override
    public void mensajeAbstracto() {
        System.out.println("C: mensajeAbstracto()");
    }

    @Override
    public void mensajeInterface() {
        System.out.println("C: mensajeInterface()");
    }

}