package tp1.ejercicio5;

public class Calculadoras {

    private static int[] vector;
    private static int max=Integer.MIN_VALUE;
    private static int min=Integer.MAX_VALUE;
    private static Resultados resultados;

    public static void setVector(int[] vector) {
        Calculadoras.vector=vector;
    }

    public static int[] getVector() {
        return vector;
    }

    public static Resultados getResultados() {
        return resultados;
    }

    public static Resultados calculadoraA() {
        double suma=0;
        for (int i=0; i<vector.length; i++) {
            if (vector[i]>max) max=vector[i];
            if (vector[i]<min) min=vector[i];
            suma+=vector[i];
        }
        resultados=new Resultados(max, min, suma/vector.length);
        return resultados;
    }

    public static void calculadoraB(Resultados resultados) {
        double suma=0;
        for (int i=0; i<vector.length; i++) {
            if (vector[i]>max) max=vector[i];
            if (vector[i]<min) min=vector[i];
            suma+=vector[i];
        }
        resultados.setMax(max);
        resultados.setMin(min);
        resultados.setProm(suma/vector.length);
    }

    public static void calculadoraC() {
        double suma=0;
        for (int i=0; i<vector.length; i++) {
            if (vector[i]>max) max=vector[i];
            if (vector[i]<min) min=vector[i];
            suma+=vector[i];
        }
        resultados=new Resultados(max, min, suma/vector.length);
    }

}