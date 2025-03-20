package tp1.ejercicio5;

public class Resultados {

    private int max;
    private int min;
    private double prom;

    public Resultados(int max, int min, double prom) {
        this.max=max;
        this.min=min;
        this.prom=prom;
    }

    public Resultados() {
        
    }

    public void setMax(int max) {
        this.max=max;
    }

    public void setMin(int min) {
        this.min=min;
    }

    public void setProm(double prom) {
        this.prom=prom;
    }

    public int getMax() {
        return max;
    }

    public int getMin() {
        return min;
    }

    public double getProm() {
        return prom;
    }

    @Override
    public String toString() {
        return "Máximo= " + getMax() + "; Mínimo= " + getMin() + "; Promedio= " + String.format("%.2f", getProm());
    }

}