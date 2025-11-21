package oo1_e9;

import java.util.*;

public class Farola {

    private boolean estado;
    private List<Farola> farolasVecinas;

    public Farola() {
        this.estado=false;
        this.farolasVecinas=new ArrayList<>();
    }

    public void pairWithNeighbor(Farola otraFarola) {
        if (!this.farolasVecinas.contains(otraFarola)) {
            this.farolasVecinas.add(otraFarola);
            otraFarola.pairWithNeighbor(this);
        }
    }

    public List<Farola> getNeighbors() {
        return new ArrayList<>(this.farolasVecinas);
    }

    public void turnOn() {
        if (!this.estado) {
            this.estado=true;
            for (Farola f: this.farolasVecinas)
                f.turnOn();
        }
    }

    public void turnOff() {
        if (this.estado) {
            this.estado=false;
            for (Farola f: this.farolasVecinas)
                f.turnOff();
        }
    }

    public boolean isOn() {
        return this.estado;
    }

    public boolean isOff() {
        return !this.estado;
    }

}