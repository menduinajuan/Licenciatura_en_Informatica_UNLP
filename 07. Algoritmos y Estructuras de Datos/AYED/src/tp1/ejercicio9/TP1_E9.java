/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 9*/
/*
Considerar un string de caracteres S, el cual comprende, únicamente, los caracteres: (,), [,], {,}.
Se dice que S está balanceado si tiene alguna de las siguientes formas:
•	S = “” S es el string de longitud cero.
•	S = “(T)”.
•	S = “[T]”.
•	S = “{T}”.
•	S = “TU”.
Donde ambos T y U son strings balanceados. Por ejemplo, “{( ) [ ( ) ] }” está balanceado, pero “( [ ) ]” no lo está.
(a) Indicar qué estructura de datos se utilizará para resolver este problema y cómo se utilizará.
(b) Implementar una clase llamada tp1.ejercicio9.TestBalanceo, cuyo objetivo es determinar si un String dado está balanceado. El String a verificar es un parámetro de entrada (no es un dato predefinido).
*/

package tp1.ejercicio9;

import java.util.*;

public class TP1_E9 {

    public static void main(String[] args) {

        Scanner scanner=new Scanner(System.in);
        System.out.print("Introducir string S: ");
        String S=scanner.nextLine();
        scanner.close();

        if (TestBalanceo.esBalanceado(S)) System.out.println("El String " + S + " está balanceado");
        else                              System.out.println("El String " + S + " no está balanceado");

    }

}