package oo1_e13;

import java.util.*;

public class OO1_E13 {

    public static void main(String[] args) {

        Inversor inversor=new Inversor("Juan Menduiña");

        inversor.agregarInversion(new InversionAccion("BTC", 1, 100000));
        inversor.agregarInversion(new InversionPlazoFijo(100000, 100));
        System.out.println("Valor de la Inversión Actual: USD " + String.format("%.2f", inversor.getValorInversiones()));

        List<Inversion> inversiones=inversor.getInversiones();
        inversor.sacarInversion(inversiones.get(inversiones.size()-1));
        System.out.println("Valor de la Inversión Actual: USD " + String.format("%.2f", inversor.getValorInversiones()));

    }

}