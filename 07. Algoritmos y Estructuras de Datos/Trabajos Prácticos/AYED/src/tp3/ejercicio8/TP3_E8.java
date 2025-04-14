/*TRABAJO PRÁCTICO N° 3*/
/*EJERCICIO 8*/
/*
Retomando el ejercicio abeto navideño visto en teoría,
crear una clase Navidad que cuenta con una variable de instancia GeneralTree que representa al abeto (ya creado) e
implementar el método con la firma: public String esAbetoNavidenio().
*/

package tp3.ejercicio8;

import tp3.ejercicio1.GeneralTree;

public class TP3_E8 {

    public static GeneralTree<Integer> copiarArbol(GeneralTree<Integer> ag) {
        GeneralTree<Integer> agCopia=new GeneralTree<>(ag.getData());
        for (GeneralTree<Integer> child: ag.getChildren())
            agCopia.addChild(copiarArbol(child));
        return agCopia;
    }

    public static void main(String[] args) {

        GeneralTree<Integer> ag1=new GeneralTree<>(1);
        ag1.addChild(new GeneralTree<>(2));
        ag1.addChild(new GeneralTree<>(3));
        ag1.addChild(new GeneralTree<>(4));

        GeneralTree<Integer> ag2=copiarArbol(ag1);
        ag2.getChildren().get(0).addChild(new GeneralTree<>(5));
        ag2.getChildren().get(0).addChild(new GeneralTree<>(6));
        ag2.getChildren().get(0).addChild(new GeneralTree<>(7));

        GeneralTree<Integer> ag3=copiarArbol(ag1);
        ag3.addChild(new GeneralTree<>(5));
        ag2.getChildren().get(1).addChild(new GeneralTree<>(6));
        ag2.getChildren().get(1).addChild(new GeneralTree<>(7));
        ag2.getChildren().get(1).addChild(new GeneralTree<>(8));

        Navidad agAbeto1=new Navidad(ag1);
        Navidad agAbeto2=new Navidad(ag2);
        Navidad agAbeto3=new Navidad(ag3);

        System.out.println("¿El árbol general ag1 es un abeto?: " + agAbeto1.esAbetoNavidenio());
        System.out.println("¿El árbol general ag2 es un abeto?: " + agAbeto2.esAbetoNavidenio());
        System.out.println("¿El árbol general ag3 es un abeto?: " + agAbeto3.esAbetoNavidenio());

    }

}