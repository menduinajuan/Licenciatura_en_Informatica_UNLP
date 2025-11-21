package oo1_e4;

import java.util.*;

public class Balanza {

    private List<Producto> productos;

    public Balanza() {
        this.productos=new ArrayList<>();
    }

    public int getCantidadDeProductos() {
        return this.productos.size();
    }

    public double getPrecioTotal() {
        return this.productos.stream().mapToDouble(Producto::getPrecio).sum();
    }

    public double getPesoTotal() {
        return this.productos.stream().mapToDouble(Producto::getPeso).sum();
    }

    public List<Producto> getProductos() {
        return this.productos;
    }

    public void ponerEnCero() {
        this.getProductos().clear();
    }

    public void agregarProducto(Producto producto) {
        this.getProductos().add(producto);
    }

    public Ticket emitirTicket() {
        Ticket ticket=new Ticket(this.getCantidadDeProductos(), this.getPesoTotal(), this.getPrecioTotal(), this.getProductos());
        this.ponerEnCero();
        return ticket;
    }

}