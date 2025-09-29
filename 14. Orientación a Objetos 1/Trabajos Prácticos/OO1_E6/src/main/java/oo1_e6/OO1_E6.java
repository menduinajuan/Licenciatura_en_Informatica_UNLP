package oo1_e6;

public class OO1_E6 {

    public static void main(String[] args) {

        DistribuidoraElectrica distribuidora=new DistribuidoraElectrica(10);

        distribuidora.agregarCliente(new Cliente("Juan", "Menduiña", "13 22"));
        distribuidora.agregarCliente(new Cliente("Demian", "Panigo", "489 22"));
 
        distribuidora.buscarCliente("13 22").agregarConsumo(new Consumo(10, 10));
        distribuidora.buscarCliente("489 22").agregarConsumo(new Consumo(10, 5));

        System.out.println(distribuidora.emitirFactura("13 22").toString());
        System.out.println(distribuidora.emitirFactura("489 22").toString());

    }

}