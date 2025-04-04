package tp1.ejercicio2;

public class Metodos {

    public static int[] crearVectorMultiplosN(int n) {
        int vector[]=new int[n];
        for (int i=0; i<n; i++)
            vector[i]=(i+1)*n;
        return vector;
    }

}