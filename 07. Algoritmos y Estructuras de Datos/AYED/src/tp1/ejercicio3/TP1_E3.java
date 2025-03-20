/*TRABAJO PRÁCTICO N° 1*/
/*EJERCICIO 3*/
/*
Creación de instancias mediante el uso del operador new.
(a) Crear una clase llamada Estudiante con los atributos especificados abajo y sus correspondientes métodos getters y setters (hacer uso de las facilidades que brinda eclipse).
•	nombre
•	apellido
•	comision
•	email
•	direccion
(b) Crear una clase llamada Profesor con los atributos especificados abajo y sus correspondientes métodos getters y setters (hacer uso de las facilidades que brinda eclipse).
•	nombre
•	apellido
•	email
•	catedra
•	facultad
(c) Agregar un método de instancia llamado tusDatos() en la clase Estudiante y en la clase Profesor, que retorne un String con los datos de los atributos de las mismas. Para acceder a los valores de los atributos, utilizar los getters previamente definidos.
(d) Escribir una clase llamada Test con el método main, el cual cree un arreglo con 2 objetos Estudiante, otro arreglo con 3 objetos Profesor, y, luego, recorrer ambos arreglos imprimiendo los valores obtenidos mediante el método tusDatos(). Recordar asignar los valores de los atributos de los objetos Estudiante y Profesor invocando los respectivos métodos setters.
(e) Agregar dos breakpoints, uno en la línea donde itera sobre los estudiantes y otro en la línea donde itera sobre los profesores.
(f) Ejecutar la clase Test en modo debug y avanzar paso a paso visualizando si el estudiante o el profesor recuperado es lo esperado.
*/

package tp1.ejercicio3;

import PaqueteLectura.*;

public class TP1_E3 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        int estMax=2;
        int proMax=3;
        int tam=10;

        Estudiante estudiantes[]=new Estudiante[estMax];
        Profesor profesores[]=new Profesor[proMax];

        for (int i=0; i<estMax; i++)
            estudiantes[i]=new Estudiante(GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), 1+GeneradorAleatorio.generarInt(10), GeneradorAleatorio.generarString(tam));
        for (int i=0; i<proMax; i++)
            profesores[i]=new Profesor(GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam), GeneradorAleatorio.generarString(tam));

        for (int i=0; i<estMax; i++)
            System.out.println(estudiantes[i].tusDatos());
        System.out.println();
        for (int i=0; i<proMax; i++)
            System.out.println(profesores[i].tusDatos());

    }

}