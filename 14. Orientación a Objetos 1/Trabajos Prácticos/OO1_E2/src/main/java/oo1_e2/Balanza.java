package oo1_e2;

public class Balanza {

    private int cantidadDeProductos;
    private double precioTotal;
    private double pesoTotal;

    public Balanza() {
        this.ponerEnCero();
    }

    public int getCantidadDeProductos() {
        return this.cantidadDeProductos;
    }

    public double getPrecioTotal() {
        return this.precioTotal;
    }

    public double getPesoTotal() {
        return this.pesoTotal;
    }

    public void ponerEnCero() {
        this.cantidadDeProductos=0;
        this.precioTotal=0;
        this.pesoTotal=0;
    }

    public void agregarProducto(Producto producto) {
        this.cantidadDeProductos++;
        this.precioTotal+=producto.getPrecio();
        this.pesoTotal+=producto.getPeso();
    }

    public Ticket emitirTicket() {
        Ticket ticket=new Ticket(this.getCantidadDeProductos(), this.getPesoTotal(), this.getPrecioTotal());
        this.ponerEnCero();
        return ticket;
    }

}