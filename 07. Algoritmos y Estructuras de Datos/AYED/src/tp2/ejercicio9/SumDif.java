package tp2.ejercicio9;

public class SumDif {

    private int sum;
    private int dif;

    public SumDif(int sum, int dif) {
        this.sum=sum;
        this.dif=dif;
    }

    public void setSum(int sum) {
        this.sum=sum;
    }

    public void setDif(int dif) {
        this.dif=dif;
    }

    public int getSum() {
        return sum;
    }

    public int getDif() {
        return dif;
    }

    @Override
    public String toString() {
        return getSum() + "|" + getDif(); 
    }

}