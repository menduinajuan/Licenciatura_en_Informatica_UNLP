package oo1_e20;

public class PoliticaCancelacionFlexible implements PoliticaCancelacion {

    public PoliticaCancelacionFlexible() {
        
    }

    @Override
    public double reembolso(Reserva reserva) {
        return reserva.puedeCrearCancelar() ? reserva.precioReserva() : 0;
    }

}