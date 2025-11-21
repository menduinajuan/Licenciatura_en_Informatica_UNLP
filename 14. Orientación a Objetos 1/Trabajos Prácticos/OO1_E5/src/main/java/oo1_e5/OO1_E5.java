package oo1_e5;

import java.time.LocalDate;
import java.util.*;

public class OO1_E5 {

    public static void main(String[] args) {

        Inversor inversor=new Inversor("Juan Menduiña");

        inversor.agregarInversion(new InversionAccion("BTC", 1, 100000));
        inversor.agregarInversion(new InversionPlazoFijo(LocalDate.of(2025, 01, 01), 100000, 1));
        System.out.println("Valor de la Inversión Actual: USD " + String.format("%.2f", inversor.valorActualInversiones()));

        List<Inversion> inversiones=inversor.getInversiones();
        inversor.sacarInversion(inversiones.get(inversiones.size()-1));
        System.out.println("Valor de la Inversión Actual: USD " + String.format("%.2f", inversor.valorActualInversiones()));

    }

}