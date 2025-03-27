/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 7*/
/*
Uso de las estructuras de listas provistas por la API de Java. Para resolver este ejercicio, crear el paquete tp1.ejercicio7.
(a) Escribir una clase llamada TestArrayList cuyo método main recibe una secuencia de números, los agrega a una lista de tipo ArrayList y, luego de haber agregado todos los números a la lista, imprime el contenido de la misma iterando sobre cada elemento.
(b) Si en lugar de usar un ArrayList en el inciso anterior se hubiera usado un LinkedList, ¿qué diferencia se encuentra respecto de la implementación? Justificar.
(c) ¿Existen otras alternativas para recorrer los elementos de la lista del inciso (a)?
(d) Escribir un método que realice las siguientes acciones:
•	Crear una lista que contenga 3 estudiantes.
•	Generar una nueva lista que sea una copia de la lista anterior.
•	Imprimir el contenido de la lista original y el contenido de la nueva lista.
•	Modificar algún dato de los estudiantes.
•	Volver a imprimir el contenido de la lista original y el contenido de la nueva lista. ¿Qué conclusiones se obtiene a partir de lo realizado?
•	¿Cuántas formas de copiar una lista existen? ¿Qué diferencias existen entre ellas?
(e) A la lista del inciso (d), agregar un nuevo estudiante. Antes de agregar, verificar que el estudiante no estaba incluído en la lista.
(f) Escribir un método que devuelva verdadero o falso si la secuencia almacenada en la lista es o no capicúa: public boolean esCapicua(ArrayList<Integer> lista).
(g) Considerar que se aplica la siguiente función de forma recursiva. A partir de un número n positivo, se obtiene una sucesión que termina en 1. Escribir un programa recursivo que, a partir de un número n, devuelva una lista con cada miembro de la sucesión.
(h) Implementar un método recursivo que invierta el orden de los elementos en un ArrayList: public void invertirArrayList(ArrayList<Integer> lista).
(i) Implementar un método recursivo que calcule la suma de los elementos en un LinkedList: public int sumarLinkedList(LinkedList<Integer> lista).
(j) Implementar el método “combinarOrdenado” que reciba 2 listas de números ordenados y devuelva una nueva lista también ordenada conteniendo los elementos de las 2 listas: public ArrayList<Integer> combinarOrdenado(ArrayList<Integer> lista1, ArrayList<Integer> lista2).
*/

package tp1.ejercicio7;

import PaqueteLectura.*;
import java.util.*;

public class TestArrayList {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        // INCISO (a)

        int numSalida=0;
        int numMax=100;
        ArrayList<Integer> listaNumsAL=new ArrayList<>();

        int num=GeneradorAleatorio.generarInt(numMax);
        while (num!=numSalida) {
            listaNumsAL.add(num);
            num=GeneradorAleatorio.generarInt(num);
        }

        System.out.print("\nElementos de la lista nums AL (impresión 1): ");
        Metodos.imprimirLista1nteger1(listaNumsAL);

        // INCISO (b)

        LinkedList<Integer> listaNumsLL=new LinkedList<>(listaNumsAL);
        System.out.print("\nElementos de la lista nums LL (impresión 1): ");
        Metodos.imprimirLista1nteger1(listaNumsLL);

        // INCISO (c)

        System.out.print("\nElementos de la lista nums AL (impresión 2): ");
        Metodos.imprimirLista1nteger2(listaNumsAL);
        System.out.print("\nElementos de la lista nums AL (impresión 3): ");
        Metodos.imprimirLista1nteger3(listaNumsAL);
        System.out.print("\nElementos de la lista nums AL (impresión 4): ");
        Metodos.imprimirLista1nteger4(listaNumsAL);

        // INCISO (d)

        List<Estudiante> listaEstudiantes=new LinkedList<>();
        Metodos.cargarListaEstudiantes(listaEstudiantes);

        // INCISO (e)

        Estudiante e1=new Estudiante("Matías", "Menduiña", "e1@gmail.com");
        Estudiante e2=new Estudiante("Juan", "Menduiña", "e1@gmail.com");
        Metodos.agregarAListaEstudiantes(listaEstudiantes, e1, e2);

        System.out.println("\nESTUDIANTES DE LA LISTA:");
        Metodos.imprimirListaEstudiantes(listaEstudiantes);

        // INCISO (f)

        System.out.println("\n¿La secuencia almacenada en la lista es capicúa? " + Metodos.esCapicua(listaNumsAL));
        System.out.println("¿La secuencia almacenada en la lista es capicúa? " + Metodos.esCapicua(new ArrayList<>(Arrays.asList(1,2,1))));

        // INCISO (g)

        System.out.println("\nElementos de la lista sucesión: " + Metodos.calcularSucesion(6));

        // INCISO (h)

        System.out.println("\nElementos de la lista nums AL (original): " + listaNumsAL);
        Metodos.invertirArrayList(listaNumsAL);
        System.out.println("Elementos de la lista nums AL (invertida): " + listaNumsAL);

        // INCISO (i)

        System.out.println("\nElementos de la lista nums LL: " + listaNumsLL);
        System.out.println("Suma de los elementos de la lista nums LL: " + Metodos.sumarLinkedList(listaNumsLL));

        // INCISO (j)

        System.out.println("\nElementos de la lista ordenada 1: " + Metodos.combinarOrdenado(new ArrayList<>(Arrays.asList(1,2,3)), new ArrayList<>(Arrays.asList(4,5,6))));
        System.out.println("Elementos de la lista ordenada 2: " + Metodos.combinarOrdenado(new ArrayList<>(Arrays.asList(4,5,6)), new ArrayList<>(Arrays.asList(1,2,3))));

}

}