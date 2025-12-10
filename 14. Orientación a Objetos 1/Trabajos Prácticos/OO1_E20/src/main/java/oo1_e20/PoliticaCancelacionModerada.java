package oo1_e20;

public class PoliticaCancelacionModerada implements PoliticaCancelacion {

    public PoliticaCancelacionModerada() {
        
    }

    @Override
    public double reembolso(Reserva reserva) {
        return reserva.isWithinXDaysBeforeStart(2) ? reserva.precioReserva()*0.5 :
               reserva.isWithinXDaysBeforeStart(7) ? reserva.precioReserva() : 0;
    }

}