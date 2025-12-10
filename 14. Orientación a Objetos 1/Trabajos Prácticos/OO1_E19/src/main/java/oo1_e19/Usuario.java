package oo1_e19;

import java.util.*;

public class Usuario {

    private String nombre;
    private String direccion;
    private int dni;
    private List<Propiedad> propiedades;
    private List<Reserva> reservas;

    public Usuario(String nombre, String direccion, int dni) {
        this.nombre=nombre;
        this.direccion=direccion;
        this.dni=dni;
        this.propiedades=new ArrayList<>();
        this.reservas=new ArrayList<>();
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getDireccion() {
        return this.direccion;
    }

    public int getDni() {
        return this.dni;
    }

    protected List<Propiedad> getPropiedades() {
        return this.propiedades;
    }

    protected List<Reserva> getReservas() {
        return this.reservas;
    }

    public void agregarPropiedad(Propiedad propiedad) {
        this.getPropiedades().add(propiedad);
    }

    public void eliminarPropiedad(Propiedad propiedad) {
        this.getPropiedades().remove(propiedad);
    }

    public void agregarReserva(Reserva reserva) {
        this.getReservas().add(reserva);
    }

    public void cancelarReserva(Reserva reserva) {
        this.getReservas().remove(reserva);
    }

    public double retribucionPropietario(DateLapse periodo) {
        return this.getPropiedades().stream().mapToDouble(p->p.retribucionPropietario(periodo)).sum()*0.75;
    }

}