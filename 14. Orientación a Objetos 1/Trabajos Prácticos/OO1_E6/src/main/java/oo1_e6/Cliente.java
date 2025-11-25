package oo1_e6;

import java.util.*;

public class Cliente {

    private String nombre;
    private String apellido;
    private String direccion;
    private List<Consumo> consumos;

    public Cliente(String nombre, String apellido, String direccion) {
        this.nombre=nombre;
        this.apellido=apellido;
        this.direccion=direccion;
        this.consumos=new ArrayList<>();
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getApellido() {
        return this.apellido;
    }

    public String getDireccion() {
        return this.direccion;
    }

    protected List<Consumo> getConsumos() {
        return this.consumos;
    }

    public void agregarConsumo(Consumo c) {
        this.getConsumos().add(c);
    }

    public Consumo getUltimoConsumo() {
        return !this.getConsumos().isEmpty() ? this.getConsumos().get(this.getConsumos().size()-1) : null;
    }

    @Override
    public String toString() {
        return this.getApellido() + " " + this.getNombre() + " - " + this.getDireccion();
    }

}