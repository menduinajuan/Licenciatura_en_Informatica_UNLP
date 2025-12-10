package oo1_e19;

public class Reserva {

    private DateLapse dateLapse;
    private Propiedad propiedad;
    private double precioNoche;

    public Reserva(DateLapse dateLapse, Propiedad propiedad) {
        this.dateLapse=dateLapse;
        this.propiedad=propiedad;
        this.precioNoche=this.propiedad.getPrecioNoche();
    }

    public DateLapse getDateLapse() {
        return this.dateLapse;
    }

    public Propiedad getPropiedad() {
        return this.propiedad;
    }

    public double getPrecioNoche() {
        return this.precioNoche;
    }

    public boolean dentroDePeriodo(DateLapse periodo) {
        return this.getDateLapse().overlaps(periodo);
    }

    public boolean puedeCrearCancelar() {
        return this.getDateLapse().nowIsBeforeThis();
    }

    public double precioReserva() {
        return this.getDateLapse().sizeInDays()*this.getPrecioNoche();
    }

}