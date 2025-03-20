/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 5*/
/*
Dado un arreglo de valores tipo entero, se desea calcular el valor máximo, mínimo y promedio en un único método.
Escribir tres métodos de clase, donde respectivamente:
(a) Devolver lo pedido por el mecanismo de retorno de un método en Java (“return”).
(b) Devolver lo pedido interactuando con algún parámetro (el parámetro no puede ser de tipo arreglo).
(c) Devolver lo pedido sin usar parámetros ni la sentencia “return”.
*/

package tp1.ejercicio5;

import java.util.concurrent.ThreadLocalRandom;

public class TP1_E5 {

    public static void main(String[] args) {

        int dimF=1+ThreadLocalRandom.current().nextInt(10);
        int numMax=100;
        int[] vector=new int[dimF];
        Resultados resultados=new Resultados();

        for (int i=0; i<dimF; i++)
            vector[i]=1+ThreadLocalRandom.current().nextInt(numMax);
        Calculadoras.setVector(vector);

        System.out.print("Elementos del vector: ");
        for (int i=0; i<dimF; i++)
            System.out.print(vector[i] + " ");

        System.out.println();
        System.out.println("CALCULADORA A: " + Calculadoras.calculadoraA().toString());

        Calculadoras.calculadoraB(resultados);
        System.out.println("CALCULADORA B: " + resultados.toString());

        Calculadoras.calculadoraC();
        System.out.println("CALCULADORA C: " + Calculadoras.getResultados().toString());

    }

}