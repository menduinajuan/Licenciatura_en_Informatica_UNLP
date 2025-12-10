package oo1_e20;

import java.util.*;

public class Propiedad {

    private String nombre;
    private String direccion;
    private double precioNoche;
    private PoliticaCancelacion politica;
    private List<Reserva> reservas;

    public Propiedad(String nombre, String direccion, double precioNoche, PoliticaCancelacion politica) {
        this.nombre=nombre;
        this.direccion=direccion;
        this.precioNoche=precioNoche;
        this.politica=politica;
        this.reservas=new ArrayList<>();
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getDireccion() {
        return this.direccion;
    }

    public double getPrecioNoche() {
        return this.precioNoche;
    }

    public PoliticaCancelacion getPolitica() {
        return this.politica;
    }

    protected List<Reserva> getReservas() {
        return this.reservas;
    }

    public boolean consultarDisponibilidad(DateLapse periodo) {
        return this.getReservas().stream().noneMatch(r->r.dentroDePeriodo(periodo));
    }

    public void crearReserva(DateLapse periodo, Usuario usuario) {
        if (this.consultarDisponibilidad(periodo)) {
            Reserva reserva=new Reserva(periodo, this);
            if (reserva.puedeCrearCancelar())
                if (this.getReservas().add(reserva))
                    usuario.agregarReserva(reserva);
        }
    }

    public double cancelarReserva(Reserva reserva, Usuario usuario) {
        if (reserva.puedeCrearCancelar()) {
            this.getReservas().remove(reserva);
            usuario.cancelarReserva(reserva);
            return this.getPolitica().reembolso(reserva);
        }
        return 0;
    }

    public double retribucionPropietario(DateLapse periodo) {
        return this.getReservas().stream().filter(r->r.dentroDePeriodo(periodo)).mapToDouble(r->r.precioReserva()).sum();
    }

}