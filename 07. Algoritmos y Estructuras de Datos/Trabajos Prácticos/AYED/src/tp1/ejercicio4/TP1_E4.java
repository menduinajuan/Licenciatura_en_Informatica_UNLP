/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 4*/
/*
Pasaje de parámetros en Java.
(a) Sin ejecutar el programa en la computadora, sólo analizándolo, indicar qué imprime el siguiente código.
(b) Ejecutar el ejercicio en la computadora y comparar el resultado con lo esperado en el inciso anterior.
(c) Insertar un breakpoint en las líneas donde se indica: y= tmp y ejecutar en modo debug. ¿Los valores que adoptan las variables x, y coinciden con los valores impresos por consola?
*/

package tp1.ejercicio4;

public class TP1_E4 {

    public static void swap1(int x, int y) {
        if (x<y) {
            int tmp=x;
            x=y;
            y=tmp;
        }
    }

    public static void swap2(Integer x, Integer y) {
        if (x<y) {
            int tmp=x ;
            x=y ;
            y=tmp;
        }
    }

    public static void main(String[] args) {
        int a=1, b=2;
        Integer c=3, d=4;
        swap1(a, b);
        swap2(c, d);
        System.out.println("a=" + a + " b=" + b);
        System.out.println("c=" + c + " d=" + d);
    }

}