package tp1.ejercicio5;

public class Calculadoras {

    private Resultados resultados;

    public Calculadoras() {
        
    }

    public static Resultados calculadoraA(int[] vector) {
        int max=Integer.MIN_VALUE;
        int min=Integer.MAX_VALUE;
        double suma=0;
        for (int i: vector) {
            if (i>max) max=i;
            if (i<min) min=i;
            suma+=i;
        }
        return new Resultados(max, min, suma/vector.length);
    }

    public static void calculadoraB(int[] vector, Resultados resultados) {
        int max=Integer.MIN_VALUE;
        int min=Integer.MAX_VALUE;
        double suma=0;
        for (int i: vector) {
            if (i>max) max=i;
            if (i<min) min=i;
            suma+=i;
        }
        resultados.setMax(max);
        resultados.setMin(min);
        resultados.setProm(suma/vector.length);
    }

    public void calculadoraC(int[] vector) {
        int max=Integer.MIN_VALUE;
        int min=Integer.MAX_VALUE;
        double suma=0;
        for (int i: vector) {
            if (i>max) max=i;
            if (i<min) min=i;
            suma+=i;
        }
        resultados=new Resultados(max, min, suma/vector.length);
    }

    public Resultados getResultados() {
        return resultados;
    }

}