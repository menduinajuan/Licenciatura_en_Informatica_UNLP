package tp1.ejercicio1;

public class Imprimir {

    public static void imprimirConFor(int a, int b) {
        for (int i=a; i<=b; i++)
            System.out.println(i);
    }

    public static void imprimirConWhile(int a, int b) {
        while (a<=b)
            System.out.println(a++);
    }

    public static void imprimirConRecursion(int a, int b) {
        if (a<=b) {
            System.out.println(a);
            imprimirConRecursion(++a, b);
        }
    }

}