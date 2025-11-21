package oo1_e7;

public class Cuadrado implements Figura {

    private double lado;

    public Cuadrado() {
        
    }

    public void setLado(double lado) {
        this.lado=lado;
    }

    public double getLado() {
        return lado;
    }

    @Override
    public double getPerimetro() {
        return 4*this.getLado();
    }

    @Override
    public double getArea() {
        return Math.pow(this.getLado(), 2);
    }

    @Override
    public String toString() {
        return "El perímetro y el área del círculo son " + String.format("%.2f", getPerimetro()) + " y " + String.format("%.2f", getArea()) + ", respectivamente";
    }

}