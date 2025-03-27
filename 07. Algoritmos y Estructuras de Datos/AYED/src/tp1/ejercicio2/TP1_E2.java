/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 2*/
/*Escribir un método de clase que, dado un número n, devuelva un nuevo arreglo de tamaño n con los n primeros múltiplos enteros de n mayores o iguales que 1.
Ejemplo: f(5)= [5; 10; 15; 20; 25]; f(k)= {n*k donde k: 1…k}.
Agregar al programa la posibilidad de probar con distintos valores de n ingresándolos por teclado, mediante el uso de System.in.
La clase Scanner permite leer, de forma sencilla, valores de entrada.*/

package tp1.ejercicio2;

import java.util.Scanner;

public class TP1_E2 {

    public static void main(String[] args) {

        Scanner scanner=new Scanner(System.in);
        int nSalida=0;
        int n;
        int vectorNum[];

        System.out.print("Introducir número n: ");
        n=scanner.nextInt();

        while (n!=nSalida) {
            System.out.print("Elementos del vector nums: ");
            vectorNum=Clase.crearVectorMultiplosN(n);
            for (int i=0; i<n; i++)
                System.out.print(vectorNum[i] + " ");
            System.out.print("\n\nIntroducir número n: ");
            n=scanner.nextInt();
        }

    }

}