package oo1_e7;

public class Cuerpo3D {

    private Figura caraBasal;
    private double altura;

    public Cuerpo3D() {
        
    }

    public void setAltura(double altura) {
        this.altura=altura;
    }

    public double getAltura() {
        return altura;
    }

    public void setCaraBasal(Figura caraBasal) {
        this.caraBasal=caraBasal;
    }

    public double getVolumen(){
        return this.caraBasal.getArea()*this.getAltura();
    }

    public double getSuperficieExterior(){
        return 2*this.caraBasal.getArea()+this.caraBasal.getPerimetro()*this.getAltura();
    }

    @Override
    public String toString() {
        return "El volumen y el área (o superficie exterior) del cuerpo son " + String.format("%.2f", getVolumen()) + " y " + String.format("%.2f", getSuperficieExterior()) + ", respectivamente";
    }

}