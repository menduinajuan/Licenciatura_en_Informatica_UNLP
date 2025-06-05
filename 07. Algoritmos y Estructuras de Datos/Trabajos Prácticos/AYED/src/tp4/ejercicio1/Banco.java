package tp4.ejercicio1;

import java.util.*;

public class Banco {

    static final int CANTIDAD_CUENTAS  =1000;
    static final int CANTIDAD_CONSULTAS=CANTIDAD_CUENTAS;

    public static void procesarMovimientos(Integer[] cuentas, Consulta[] consultas) {
        Consulta c;
        long tiempoInicio=System.currentTimeMillis();
        for (int i=0; i<consultas.length; i++) {
            c=consultas[i];
            for (int j=c.getDesde(); j<=c.getHasta(); j++)
                cuentas[j]+=c.getValor();
        }
        long tiempoFin=System.currentTimeMillis();
        System.out.println("procesarMovimientos: " + ((float)(tiempoFin-tiempoInicio)/1000) + " segundos");
    }

    public static void procesarMovimientosOptimizado(Integer[] cuentas, Consulta[] consultas) {
        Consulta c;
        long tiempoInicio=System.currentTimeMillis();
        Integer[] aux=new Integer[CANTIDAD_CUENTAS+1];
        Arrays.fill(aux, 0);
        for (int i=0; i<consultas.length; i++) {
            c=consultas[i];
            aux[c.getDesde()]  +=c.getValor();
            aux[c.getHasta()+1]-=c.getValor();
        }
        for (int i=0; i<cuentas.length; i++) {
            if (i>0)
              aux[i]+=aux[i-1];
            cuentas[i]+=aux[i];
        }
        long tiempoFin=System.currentTimeMillis();
        System.out.println("procesarMovimientosOptimizado: " + ((float)(tiempoFin-tiempoInicio)/1000) + " segundos");
    }

    public static void main(String[] args) {
        Integer[] cuentas          =new Integer[CANTIDAD_CUENTAS];
        Integer[] cuentasOptimizado=new Integer[CANTIDAD_CUENTAS];
        Arrays.fill(cuentas, 0);
        Arrays.fill(cuentasOptimizado, 0);
        Consulta[] consultas=Consulta.generarConsultasRandom();
        System.out.println("Comenzando procesamiento de movimientos bancarios...");
        procesarMovimientos(cuentas, consultas);
        procesarMovimientosOptimizado(cuentasOptimizado, consultas);
    }

}