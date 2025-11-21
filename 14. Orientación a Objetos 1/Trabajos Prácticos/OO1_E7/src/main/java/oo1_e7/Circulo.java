package oo1_e7;

public class Circulo implements Figura {

    private double radio;

    public Circulo() {
        
    }

    public double getDiametro() {
        return this.radio*2;
    }

    public void setDiametro(double diametro) {
        this.radio=diametro/2;
    }

    public double getRadio() {
        return radio;
    }

    public void setRadio(double radio) {
        this.radio=radio;
    }

    @Override
    public double getPerimetro() {
        return Math.PI*this.getDiametro();
    }

    @Override
    public double getArea() {
        return Math.PI*Math.pow(this.getRadio(), 2);
    }

    @Override
    public String toString() {
        return "El perímetro y el área del círculo son " + String.format("%.2f", getPerimetro()) + " y " + String.format("%.2f", getArea()) + ", respectivamente";
    }

}