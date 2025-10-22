/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 5*/
/*
Dado un arreglo de valores tipo entero, se desea calcular el valor máximo, mínimo y promedio en un único método.
Escribir tres métodos de clase, donde, respectivamente:
(a) Devuelva lo pedido por el mecanismo de retorno de un método en Java (“return”).
(b) Devuelva lo pedido interactuando con algún parámetro (el parámetro no puede ser de tipo arreglo).
(c) Devuelva lo pedido sin usar parámetros ni la sentencia “return”.
*/

package tp1.ejercicio5;

import PaqueteLectura.*;

public class TP1_E5 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        int dimF=1+GeneradorAleatorio.generarInt(10);
        int numMax=100;
        int[] vectorNums=new int[dimF];
        Resultados resultados=new Resultados();

        for (int i=0; i<dimF; i++)
            vectorNums[i]=1+GeneradorAleatorio.generarInt(numMax);

        System.out.print("Elementos del vector nums: ");
        for (int i: vectorNums)
            System.out.print(i + " ");

        System.out.println();
        System.out.println("CALCULADORA A: " + Calculadoras.calculadoraA(vectorNums).toString());

        Calculadoras.calculadoraB(vectorNums, resultados);
        System.out.println("CALCULADORA B: " + resultados.toString());

        Calculadoras.calculadoraC(vectorNums);
        System.out.println("CALCULADORA C: " + Calculadoras.getResultados().toString());

    }

}