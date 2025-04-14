/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 6*/
/*
Sea una red de agua potable, la cual comienza en un caño maestro y la misma se va dividiendo, sucesivamente, hasta llegar a cada una de las casas.
Por el caño maestro, ingresan “x” cantidad de litros y, en la medida que el caño se divide de acuerdo con las bifurcaciones que pueda tener, el caudal se divide en partes iguales en cada una de ellas.
Es decir, si un caño maestro recibe 1000 litros y tiene, por ejemplo, 4 bifurcaciones, se divide en 4 partes iguales, donde cada división tendrá un caudal de 250 litros.
Luego, si una de esas divisiones se vuelve a dividir, por ejemplo, en 5 partes, cada una tendrá un caudal de 50 litros y así sucesivamente hasta llegar a un lugar sin bifurcaciones.
Se debe implementar una clase RedDeAguaPotable que contenga el método con la siguiente firma:
public double minimoCaudal(double caudal),
que calcule el caudal de cada nodo y determine cuál es el caudal mínimo que recibe una casa.
Asumir que la estructura de caños de la red está representada por una variable de instancia de la clase RedAguaPotable y que es un GeneralTree<Character>.
Extendiendo el ejemplo en el siguiente gráfico, al llamar al método minimoCaudal con un valor de 1000.0, debería retornar 25.0.
*/

package tp3.ejercicio6;

import PaqueteLectura.*;
import tp3.ejercicio1.GeneralTree;

public class TP3_E6 {

    public static void main(String[] args) {

        GeneradorAleatorio.iniciar();

        GeneralTree<Character> ag=new GeneralTree<>('A');
        ag.addChild(new GeneralTree<>('B'));
        ag.addChild(new GeneralTree<>('C'));
        ag.addChild(new GeneralTree<>('D'));
        ag.addChild(new GeneralTree<>('E'));
        ag.getChildren().get(1).addChild(new GeneralTree<>('F'));
        ag.getChildren().get(1).addChild(new GeneralTree<>('G'));
        ag.getChildren().get(2).addChild(new GeneralTree<>('H'));
        ag.getChildren().get(2).addChild(new GeneralTree<>('I'));
        ag.getChildren().get(2).addChild(new GeneralTree<>('J'));
        ag.getChildren().get(2).addChild(new GeneralTree<>('K'));
        ag.getChildren().get(2).addChild(new GeneralTree<>('P'));
        ag.getChildren().get(1).getChildren().get(1).addChild(new GeneralTree<>('L'));
        ag.getChildren().get(2).getChildren().get(2).addChild(new GeneralTree<>('M'));
        ag.getChildren().get(2).getChildren().get(2).addChild(new GeneralTree<>('N'));

        RedDeAguaPotable agRed=new RedDeAguaPotable(ag);
        double caudalTotal=100+GeneradorAleatorio.generarDouble(901);
        System.out.println("El caudal mínimo que recibe una casa dado un caudal total de " + String.format("%.2f", caudalTotal) + " es " + String.format("%.2f", agRed.minimoCaudal(caudalTotal)));

    }

}