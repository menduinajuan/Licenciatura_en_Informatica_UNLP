package oo1_e3;

import java.time.LocalDate;
import java.util.*;

public class Presupuesto {

    private LocalDate fecha;
    private String cliente;
    private List<Item> items;

    public Presupuesto(String cliente) {
        this.fecha=LocalDate.now();
        this.cliente=cliente;
        this.items=new ArrayList<>();
    }

    public LocalDate getFecha() {
        return this.fecha;
    }

    public String getCliente() {
        return this.cliente;
    }

    public List<Item> getItems() {
        return this.items;
    }
    
    public void agregarItem(Item item) {
        this.getItems().add(item);
    }

    public double calcularTotal() {
        return this.getItems().stream().mapToDouble(Item::costo).sum();
    }

}