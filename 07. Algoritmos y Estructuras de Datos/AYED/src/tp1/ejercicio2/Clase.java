package tp1.ejercicio2;

public class Clase {

    public static int[] crearVectorMultiplosN(int n) {
        int vector[]=new int[n];
        int num=0;
        for (int i=0; i<n; i++) {
            vector[i]=n+num;
            num+=n;
        }
        return vector;
    }

}