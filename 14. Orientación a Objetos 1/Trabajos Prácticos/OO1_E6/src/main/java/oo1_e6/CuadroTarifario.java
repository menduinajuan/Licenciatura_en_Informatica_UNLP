package oo1_e6;

public class CuadroTarifario {

    private double preciokWh;

    public CuadroTarifario(double preciokWh) {
        setPreciokWh(preciokWh);
    }

    public void setPreciokWh(double preciokWh) {
        if (preciokWh>0)
            this.preciokWh=preciokWh;
        else
            System.out.println("El precio del kWh debe ser mayor a 0 (cero)");
    }

    public double getPreciokWh() {
        return this.preciokWh;
    }

}