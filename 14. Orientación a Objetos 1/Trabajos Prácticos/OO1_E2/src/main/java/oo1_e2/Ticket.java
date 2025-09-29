package oo1_e2;

import java.time.LocalDate;

public class Ticket {

    private LocalDate fecha;
    private int cantidadDeProductos;
    private double pesoTotal;
    private double precioTotal;

    public Ticket(int cantidadDeProductos, double pesoTotal, double precioTotal) {
        this.fecha=LocalDate.now();
        this.cantidadDeProductos=cantidadDeProductos;
        this.pesoTotal=pesoTotal;
        this.precioTotal=precioTotal;
    }

    public LocalDate getFecha() {
        return this.fecha;
    }

    public int getCantidadDeProductos() {
        return this.cantidadDeProductos;
    }

    public double getPesoTotal() {
        return this.pesoTotal;
    }

    public double getPrecioTotal() {
        return this.precioTotal;
    }

    public double impuesto() {
        return this.getPrecioTotal()*0.21;
    }

    @Override
    public String toString() {
        return "Fecha: " + this.getFecha().toString() + "\n" +
               "Cantidad de Productos: " + this.getCantidadDeProductos() + "\n" +
               "Peso Total: " + this.getPesoTotal() + " kg.\n" + 
               "Precio Total: $" + String.format("%.2f", this.getPrecioTotal());
    }

}