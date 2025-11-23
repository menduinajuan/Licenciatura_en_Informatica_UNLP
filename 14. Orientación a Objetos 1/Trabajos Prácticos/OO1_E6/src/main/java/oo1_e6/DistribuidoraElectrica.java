package oo1_e6;

import java.util.*;

public class DistribuidoraElectrica {

    private CuadroTarifario cuadroTarifario;
    private List<Cliente> clientes;

    public DistribuidoraElectrica(double preciokWh) {
        this.cuadroTarifario=new CuadroTarifario(preciokWh);
        this.clientes=new ArrayList<>();
    }

    public CuadroTarifario getCuadroTarifario() {
        return this.cuadroTarifario;
    }

    protected List<Cliente> getClientes() {
        return this.clientes;
    }

    public void agregarCliente(Cliente c) {
        this.getClientes().add(c);
    }

    public Cliente buscarCliente(String direccion) {
         return this.getClientes().stream().filter(c->c.getDireccion().equals(direccion)).findFirst().orElse(null);
    }

    public Factura emitirFactura(String direccion) {
        Cliente cliente=buscarCliente(direccion);
        if (cliente!=null) {
            Consumo ultimoConsumo=cliente.getUltimoConsumo();
            if (ultimoConsumo!=null)
                return new Factura(cliente.toString(), ultimoConsumo, this.getCuadroTarifario().getPreciokWh());
        }
        return null;
    }

}